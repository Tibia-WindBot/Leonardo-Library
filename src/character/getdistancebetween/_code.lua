function getdistancebetween(x, y, z, a, b, c)
  if type(x) == 'table' and type(y) == 'table' and not (z and a and b and c) then
    if x.x and y.x then
      x, y, z, a, b, c = x.x, x.y, x.z, y.x, y.y, y.z
    elseif #x == 3 and #y == 3 then
      x, y, z, a, b, c = x[1], x[2], x[3], y[1], y[2], y[3]
    else
      return -1
    end
  end

  return z == c and math.max(math.abs(x - a), math.abs(y - b)) or -1
end
