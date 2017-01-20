function isbinded(...)
  if not $fasthotkeys then
    local temp, i, arg, info = {}, 1, {...}

    while arg[i] do
      if type(arg[i]) == 'table' then
        info = spellinfo(arg[i][1])
        temp[i] = {key = arg[i][1], type = #info.words > 0 and info.itemid == 0, force = arg[i][2]}
      else
        info = spellinfo(arg[i])
        temp[i] = {key = arg[i], type = #info.words > 0 and info.itemid == 0, force = "all"}
      end

      i = i + 1
    end

    for _, entry in ipairs(temp) do
      local func, params = clientitemhotkey, {"self", "target", "crosshair"}

      if entry.type then
        func, params = clienttexthotkey, {"automatic", "manual"}
      end

      if entry.force and not table.find(params, entry.force:lower()) then
        entry.force = 'all'
      end

      if func(entry.key, entry.force) == 'not found' then
        return false
      end
    end
  end

  return true
end
