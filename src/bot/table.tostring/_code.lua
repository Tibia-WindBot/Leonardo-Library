function table.tostring(self, name, sep)
  if name and not sep then
    sep = name
    name = nil
  elseif not (name or sep) then
    sep = ' '
  end

  local str = ''

  for k, v in pairs(self) do
    local t, n = type(v), type(k)

    k = ((n ~= 'number' and tonumber(k) ~= nil) or tostring(k):match("[%s\'+]") ~= nil) and sprintf('[%q]', k) or k

    if t == 'string' then
      str = str .. sprintf("%s,%s", (n == 'number' and sprintf('%q', v)) or sprintf('%s = %q', k, v), sep)
    elseif t == 'number' or t == 'boolean' then
      str = str .. sprintf("%s,%s", (n == 'number' and tostring(v)) or sprintf('%s = %s', k, tostring(v)), sep)
    elseif t == 'table' then
      str = str .. sprintf("%s,%s", (n == 'number' and table.tostring(v)) or sprintf('%s = %s', k, table.tostring(v)), sep)
    elseif t == 'userdata' and userdatastringformat then
      str = str .. sprintf("%s, %s", (n == 'number' and userdatastringformat(v)) or sprintf('%s = %s', k, userdatastringformat(v)), sep)
    end
  end

  return sprintf("%s{%s}", name and sprintf('%s = ', name) or '', str:sub(1, -(2 + #sep)))
end
