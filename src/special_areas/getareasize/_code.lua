function getareasize(name)
  local setting = getareasetting(name, 'Size')

  if setting then
    local w, h = setting:match(REGEX_RANGE)

    return {w = tonumber(w) or 0, h = tonumber(h) or 0}
  end

  return {w = 0, h = 0}
end
