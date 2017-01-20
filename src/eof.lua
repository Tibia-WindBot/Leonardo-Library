-- FIXES AND GENERAL EXTENSIONS

-- enables advanced cooldown control in cancast
function cast(...)
  local args = {...}
  local info = ("userdata|table"):find(type(args[1])) ~= nil and args[1] or spellinfo(args[1])
  LIB_CACHE.cancast[info.name:lower()] = $timems + info.duration

  return __FUNCTIONS.CAST(...)
end

printf("Leonardo\'s library loaded, version: %s", LIBS.LEONARDO)
