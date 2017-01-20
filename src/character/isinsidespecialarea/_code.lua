function isinsidespecialarea(...)
  local specialAreas = {...}

  for _, area in pairs(specialAreas) do
    local areaPos = getareaposition(area)
    local areaSize = getareasize(area)

    if $posz == areaPos.z and $posx <= areaPos.x + areaSize.w - 1 and $posx >= areaPos.x and $posy <= areaPos.y + areaSize.h - 1 and $posy >= areaPos.y then
      return true
    end
  end

  return false
end
