function formattime(n, pattern)
  local units = {DD = math.floor(n / 86400 % 7), HH = math.floor(n / 3600 % 24), MM = math.floor(n / 60 % 60), SS = math.floor(n % 60)}

  if not pattern then
    if units.DD > 0 then
      pattern = "DD:HH:MM:SS"
    elseif units.HH > 0 then
      pattern = "HH:MM:SS"
    else
      pattern = "MM:SS"
    end
  else
    pattern = pattern:upper()
  end

  return pattern:gsub("%u%u", function(str) return string.format("%02d", units[str]) end)
end
