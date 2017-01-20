function botversion(n)
  print('`botversion` is deprecated as of version 2.0.0, please use $botversion native method instead.')
  n = n or $botversion

  return (tonumber(n:sub(1,1)) * 100) + (tonumber(n:sub(3,3)) * 10) + tonumber(n:sub(5,5))
end

BOT_VERSION = botversion()
