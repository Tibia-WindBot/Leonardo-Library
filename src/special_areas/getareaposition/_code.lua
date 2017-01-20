function getareaposition(name)
  local setting = getareasetting(name, 'Coordinates')

  if setting then
    local x, y, z = setting:match(REGEX_COORDS)

    return {x = tonumber(x) or 0, y = tonumber(y) or 0, z = tonumber(z) or 0}
  end

  return {x = 0, y = 0, z = 0}
end
