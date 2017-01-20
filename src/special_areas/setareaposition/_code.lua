function setareaposition(name, x, y, z)
  x, y, z = tonumber(x) or $posx, tonumber(y) or $posy, tonumber(z) or $posz

  return setareasetting(name, 'Coordinates', sprintf("x:%s, y:%s, z:%s", x, y, z))
end
