function setareaavoidance(name, avoid)
  avoid = tonumber(avoid) or 0

  return setareasetting(name, 'Avoidance', avoid)
end
