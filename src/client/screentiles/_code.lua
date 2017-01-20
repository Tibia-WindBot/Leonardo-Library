function screentiles(sortf, area, func)
  local tempType, xs, ys, xe, ye, Positions, i = type(sortf), -7, -5, 7, 5, {}, 0

  if tempType == 'table' and #sortf == 4 then
    xs, xe, ys, ye = sortf[1], sortf[2], sortf[3], sortf[4]
    sortf = false
  elseif tempType ~= 'function' then
    sortf = false
  end

  tempType = type(area)

  if tempType == 'function' then
    func = area
  elseif tempType == 'table' and #area == 4 then
    xs, xe, ys, ye = area[1], area[2], area[3], area[4]
  elseif tempType == 'number' then
    xs, xe, ys, ye = -area, area, -area, area
  end

  for x = xs, xe, xs < xe and 1 or -1 do
    for y = ys, ye, ys < ye and 1 or -1 do
      local _x, _y = $posx + x, $posy + y

      if tilehasinfo(_x, _y, $posz) then
        table.insert(Positions, {_x, _y, $posz})
      end
    end
  end

  if sortf then
    table.sort(Positions, sortf)

    if sortf == ORDER_RANDOM then
      -- little trick to get random values for ORDER_RANDOM every time it is used
      LIB_CACHE.screentiles = math.random(10^2, 10^4)
    end
  end

  return function()
    i = i + 1

    if Positions[i] then
      return func and func(Positions[i][1], Positions[i][2], Positions[i][3]) or Positions[i][1], Positions[i][2], Positions[i][3]
    end

    return
  end
end
