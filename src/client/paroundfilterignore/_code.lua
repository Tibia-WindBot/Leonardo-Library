function paroundfilterignore(range, floor, ...)
  local Creatures, Callback = {...}, function(c) return true end

  if type(floor) == 'string' then
    table.insert(Creatures, floor)
    floor = false
  end

  if type(range) == 'boolean' then
    floor = range
    range = 7
  elseif type(range) == 'string' then
    table.insert(Creatures, range)
    range = 7
  end

  if type(Creatures[#Creatures]) == 'function' then
    Callback = table.remove(Creatures)
  end

  table.lower(Creatures)

  return __crearoundf__callback(range, floor, Creatures, 'px', true, Callback)
end
