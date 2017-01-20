function formatnumber(n, s)
  local result, sign, before, after, s = '', string.match(tostring(n), '^([%+%-]?)(%d*)(%.?.*)$'), s or ','

  while #before > 3 do
    result = s .. string.sub(before, -3, -1) .. result
    before = string.sub(before, 1, -4)
  end

  return sign .. before .. result .. after
end
