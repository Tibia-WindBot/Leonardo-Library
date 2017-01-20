function isinsidearea(...)
  local SpecialAreas = {...}

  if #SpecialAreas == 5 and type(SpecialAreas[1]) == 'number' then
    SpecialAreas = {SpecialAreas}
  end

  for i, area in ipairs(SpecialAreas) do
    if #area == 5 then
      local a,b,c,d,e = unpack(area)

      if $posz == e and $posx <= b and $posx >= a and $posy <= d and $posy >= c then
        return true
      end
    end
  end

  return false
end
