function getareaextrapolicy(name, poltype)
  local t = type(poltype)
  poltype = t == 'string' and poltype:lower() or false

  if poltype then
    if poltype:match('loot') then
      poltype = 'IgnoreWhenLooting'
    elseif poltype:match('luring') or poltype:match('lure') then
      poltype = 'IgnoreWhenLuring'
    else
      return printerrorf("bad argument #2 to 'getareaextrapolicy', ('Lure', 'Loot', 'Luring' or 'Looting' expected, got '%s')", poltype)
    end
  else
    return printerrorf("bad argument #2 to 'getareaextrapolicy', (string expected, got '%s')", t)
  end

  local setting = getareasetting(name, poltype)

  return setting ~= nil and setting == 'yes'
end
