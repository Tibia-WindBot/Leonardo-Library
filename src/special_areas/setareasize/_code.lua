function setareasize(name, w, h)
  h, w = tonumber(h) or 1, tonumber(w) or 1

  return setareasetting(name, 'Size', sprintf('%d to %d', w, h))
end
