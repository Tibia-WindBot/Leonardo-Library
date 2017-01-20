function getareaavoidance(name)
  local setting = getareasetting(name, 'Avoidance')

  return tonumber(setting) or 0
end
