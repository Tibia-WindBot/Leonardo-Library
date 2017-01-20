function table.search(self, value, argument, ...)
  local typeVal = type(value)
  local typeArg = type(argument)
  local val1, val2
  local args = {...}

  if typeVal == 'string' then
    if typeArg == 'boolean' then
      table.insert(args, 1, argument)
      argument = nil
    end

    -- string options
    -- disconsider case, partial match
    val1, val2 = unpack(args)
  elseif typeVal == 'number' then
    if typeArg == 'number' and #args == 1 then
      table.insert(args, 1, argument)
      argument = nil
    end

    -- number options
    -- between min, between max
    val1, val2 = unpack(args)
  elseif typeVal == 'boolean' then
    if typeArg == 'boolean' then
      table.insert(args, 1, argument)
      argument = nil
    end

    -- bool options
    -- convert values to bool, must have Raphael's lib
    val1 = args[1]
  end

  for k, v in pairs(self) do
    if typeVal == 'string' and type(k[argument] or v) == 'string' then
      local str1, str2, str3 = v:lower(), value:lower(), (argument ~= nil and k[argument] or ''):lower()

      if v == value or argument and k[argument] == value or (val1 and (str1 == str2 or (argument and str1 == str3))) or (val2 and (str1:find(str2) or str2:find(str1) or (argument and (str1:find(str3) or str3:find(str1))))) then
        return k
      end
    elseif typeVal == 'number' and type(k[argument] or v) == 'number' then
      if v == value or argument and k[argument] == value or (val1 and val2 and (v < val2 and v > val1 or argument and k[argument] < val2 and k[argument] > val1)) then
        return k
      end
    elseif typeVal == 'boolean' and type(k[argument] or v) == 'boolean' then
      if v == value or argument and k[argument] == value or (val1 and tobool(argument and k[argument] or v)) then
        return k
      end
    end
  end

  return nil
end
