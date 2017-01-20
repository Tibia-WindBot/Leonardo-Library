function setareaextrapolicy(name, poltype, t)
  local typ = type(poltype)
  poltype = typ == 'string' and poltype:lower() or false

  if poltype then
    if poltype:match('loot') then
      poltype = 'IgnoreWhenLooting'
    elseif poltype:match('luring') or poltype:match('lure') then
      poltype = 'IgnoreWhenLuring'
    else
      return printerrorf("bad argument #2 to 'getareaextrapolicy', ('Lure', 'Loot', 'Luring' or 'Looting' expected, got '%s')", poltype)
    end
  else
    return printerrorf("bad argument #2 to 'getareaextrapolicy', (string expected, got '%s')", typ)
  end

  return setareasetting(name, poltype, t)
end
