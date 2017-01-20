function antifurnituretrap(weapon, stand)
  print('`antifurnituretrap` is deprecated as of version 2.0.0, please check [[URL]]')

  weapon = weapon or 'Machete'
  stand = (stand or 0) * 1000

  if clientitemhotkey(weapon, 'crosshair') == 'not found' and itemcount(weapon) == 0 then
    return "AntiFurniture[Issue1]: 'Weapon' given not found on hotkeys and not visible."
  end

  if $standtime > stand then
    local Furniture = {}

    for x, y, z in screentiles(ORDER_RADIAL, 7) do
      if tilereachable(x, y, z, false) and not LIB_CACHE.antifurniture[ground(x, y, z)] then
        local tile = gettile(x, y, z)

        for k = tile.itemcount, 1, -1 do
          local info = iteminfo(tile.item[k].id)

          if info.isunpass and not info.isunmove then
            table.insert(Furniture, {x = x, y = y, z = z, id = info.id, top = k == tile.itemcount})
            break
          end
        end
      end
    end

    if #Furniture > 0 then
      for _, item in ipairs(Furniture) do
        local x, y, z, id, top = item.x, item.y, item.z, item.id, item.top

        pausewalking(10000) reachlocation(x, y, z)

        foreach newmessage m do
          if m.content:match("You are not invited") then
            LIB_CACHE.antifurniture[ground(x, y, z)] = true
            return "AntiFurniture[Issue4]: Cancelling routine due to an item inside a house. (top item)"
          end
        end

        if top then
          while id == topitem(x, y, z).id and tilereachable(x, y, z, false) do
            useitemon(weapon, id, ground(x, y, z)) waitping()

            foreach newmessage m do
              if m.content:match("You are not invited") then
                LIB_CACHE.antifurniture[ground(x, y, z)] = true
                return "AntiFurniture[Issue4]: Cancelling routine due to an item inside a house. (top item)"
              end
            end
          end
        else
          browsefield(x, y, z) waitcontainer("browse field", true)
          local cont = getcontainer('Browse Field')

          for j = 1, cont.lastpage do
            for i = 1, cont.itemcount do
              local info = iteminfo(cont.item[i].id)

              if info.isunpass and not info.isunmove then
                while itemcount(cont.item[i].id, 'Browse Field') > 0 and tilereachable(x, y, z, false) do
                  useitemon(weapon, info.id, "Browse Field") waitping()

                  foreach newmessage m do
                    if m.content:match("You are not invited") then
                      LIB_CACHE.antifurniture[ground(x, y, z)] = true
                      return "AntiFurniture[Issue3]: Cancelling routine due to an item inside a house. (browsing field)"
                    end
                  end
                end
              end
            end

            changepage('browse field', math.min(j + 1, cont.lastpage))
          end
        end

        pausewalking(0)
      end
    else
      return "AntiFurniture[Issue5]: Character is standing still without furnitures to break."
    end
  else
    return "AntiFurniture[Issue2]: Current standtime less than the required time."
  end

  return "AntiFurniture[No Issue]"
end

-- ALIASES

antifurniture = antifurniture or antifurnituretrap
