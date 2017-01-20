function tosec(str)
  local sum, time, units, index = 0, str:token(nil, ":"), {86400, 3600, 60, 1}, 1

  for i = #units - #time + 1, #units do
    sum, index = sum + ((tonumber(time[index]) or 0) * units[i]), index + 1
  end

  return math.max(sum, 0)
end
