--[[
Leonardo's Library
Created: 15/01/2014
Version: 1.6.2
Updated: 13/12/2015

]]

-- GLOBALS AND LOCAL VARIABLES

LIBS = LIBS or {}
LIBS.LEONARDO = "1.6.2"

POLICY_NONE = 'None'
POLICY_CAVEBOT = 'Cavebot'
POLICY_TARGETING = 'Targeting'
POLICY_ALL = 'Cavebot & Targeting'

AREA_SQUARE_FILLED = 'Square (Filled)'
AREA_SQUARE_BORDER = 'Square (Border Only)'
AREA_SQUARE_DOUBLE_BORDER = 'Square (Double Border)'

local SA_POLICY = {POLICY_CAVEBOT, POLICY_TARGETING, POLICY_ALL}
local SA_TYPE = {AREA_SQUARE_FILLED, AREA_SQUARE_BORDER, AREA_SQUARE_DOUBLE_BORDER}

local slotNames = {
  ["amulet"] = function() return {name = 'neck', obj = $neck} end,
  ["neck"] = function() return {name = 'neck', obj = $neck} end,
  ["weapon"] = function() return {name = 'rhand', obj = $rhand} end,
  ["rhand"] = function() return {name = 'rhand', obj = $rhand} end,
  ["shield"] = function() return {name = 'lhand', obj = $lhand} end,
  ["lhand"] = function() return {name = 'lhand', obj = $lhand} end,
  ["ring"] = function() return {name = 'finger', obj = $finger} end,
  ["finger"] = function() return {name = 'finger', obj = $finger} end,
  ["armor"] = function() return {name = 'chest', obj = $chest} end,
  ["chest"] = function() return {name = 'chest', obj = $chest} end,
  ["boots"] = function() return {name = 'feet', obj = $feet} end,
  ["feet"] = function() return {name = 'feet', obj = $feet} end,
  ["ammo"] = function() return {name = 'belt', obj = $belt} end,
  ["belt"] = function() return {name = 'belt', obj = $belt} end,
  ["helmet"] = function() return {name = 'head', obj = $head} end,
  ["head"] = function() return {name = 'head', obj = $head} end,
  ["legs"] = function() return {name = 'legs', obj = $legs} end,
}

local cityTemples = {
  -- thanks @Donatello for finding the positions:
  --{fx, lx, fy, ly, z}
  {32953, 32966, 32072, 32081, 7}, -- venore
  {32358, 32380, 32231, 32248, 7}, -- thais
  {32357, 32363, 31776, 31787, 7}, -- carlin
  {32718, 32739, 31628, 31640, 7}, -- abdendriel
  {33509, 33517, 32360, 32366, 7}, -- roshaamul
  {33208, 33225, 31804, 31819, 8}, -- edron
  {33018, 33033, 31511, 31531, 11}, -- farmine
  {33018, 33033, 31511, 31531, 13}, -- farmine
  {33018, 33033, 31511, 31531, 15}, -- farmine
  {33210, 33218, 32450, 32457, 1}, -- darashia
  {32642, 32662, 31920, 31929, 11}, -- kazordoon
  {32093, 32101, 32216, 32222, 7}, -- rookgaard
  {33442, 33454, 31312, 31326, 9}, -- gray island
  {32208, 32217, 31128, 31138, 7}, -- svargrond
  {33188, 33201, 32844, 32857, 8}, -- ankrahmun
  {32590, 32599, 32740, 32749, 6}, -- port hope
  {32313, 32321, 32818, 32830, 7}, -- liberty bay
  {32785, 32789, 31274, 31279, 7}, -- yalahar
  {33586, 33602, 31896, 31903, 6}, -- oramond
}

local defaultColors = {
  ['red'] = {0, 16},
  ['yellow'] = {47, 55},
  ['blue'] = {180, 225},
  ['green'] = {63, 179},
  ['purple'] = {240, 280},
  ['orange'] = {16, 43},
  ['pink'] = {300, 336},
  ['cyan'] = {168, 187},
  ['monochrome'] = 1,
}

-- LOCAL FUNCTIONS

LIB_CACHE = LIB_CACHE or {
  antifurniture = {},
  specialarea = {},
  cancast = {},
  isontemple = false,
  screentiles = math.random(10^2, 10^4)
}

ORDER_RADIAL = function(a, b) return getdistancebetween(a, {$posx, $posy, $posz}) < getdistancebetween(b, {$posx, $posy, $posz}) end
ORDER_RADIAL_REVERSE = function(a, b) return ORDER_RADIAL(b, a) end
ORDER_EUCLIDEAN = function(a, b) return math.sqrt(math.abs(a[1] - $posx)^2 + math.abs(a[2] - $posy)^2) > math.sqrt(math.abs(b[1] - $posx)^2 + math.abs(b[2] - $posy)^2) end
ORDER_EUCLIDEAN_REVERSE = function(a, b) return ORDER_EUCLIDEAN(b, a) end
ORDER_REALDIST = function(a, b) return math.abs((a[1] - $posx) + (a[2] - $posy)) > math.abs((b[1] - $posx) + (b[2] - $posy)) end
ORDER_REALDIST_REVERSE = function(a, b) return ORDER_REALDIST(b, a) end
ORDER_RANDOM = function(a, b) return (a[1] * a[2] * a[3]) % LIB_CACHE.screentiles < (b[1] * b[2] * b[3]) % LIB_CACHE.screentiles end

local __FUNCTIONS = __FUNCTIONS or {
  CAST = cast,
}

local function __crearoundf__callback(range, floor, list, cretype, ignore, f)
  local Creatures = {}

  foreach creature cre cretype do
    if f(cre) and cre.dist <= range and (cre.posz == $posz or floor) and ((not ignore and (#list == 0 or table.find(list, cre.name:lower()))) or (ignore and not table.find(list, cre.name:lower()))) then
      table.insert(Creatures, cre)
    end
  end

  return #Creatures
end

local function getareasetting(name, setting)
  name = name:lower()
  if LIB_CACHE.specialarea[name] then
    return getsetting(LIB_CACHE.specialarea[name].path, setting)
  else
    foreach settingsentry e 'Cavebot/SpecialAreas' do
      local n = getsetting(e, 'Name')
      LIB_CACHE.specialarea[n:lower()] = {path = e, name = n}

      if n:lower() == name then
        return getsetting(e, setting)
      end
    end
  end
  return nil
end

local function setareasetting(name, setting, v)
  name = name:lower()
  if LIB_CACHE.specialarea[name] then
    return setsetting(LIB_CACHE.specialarea[name].path, setting, v)
  else
    foreach settingsentry e 'Cavebot/SpecialAreas' do
      local n = getsetting(e, 'Name')
      LIB_CACHE.specialarea[n:lower()] = {path = e, name = n}

      if n:lower() == name then
        return setsetting(e, setting, v)
      end
    end
  end
end
