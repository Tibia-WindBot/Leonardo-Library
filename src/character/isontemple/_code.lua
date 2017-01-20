function isontemple()
  local temp = isinsidearea(unpack(cityTemples))

  if $connected then
    LIB_CACHE.isontemple = temp
    return $pzone and temp
  else
    return LIB_CACHE.isontemple
  end
end
