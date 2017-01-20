function setareatype(name, areatype)
  local t = type(areatype)

  if t == 'string' then
    areatype = areatype:lower()

    if areatype:match('filled') then
      areatype = AREA_SQUARE_FILLED
    elseif areatype:match('border') then
      areatype = AREA_SQUARE_BORDER
    elseif areatype:match('double') then
      areatype = AREA_SQUARE_DOUBLE_BORDER
    else
      return printerrorf("bad argument #2 to 'setareatype' ('Filled', 'Border', 'Double', 'Square (Filled)', 'Square (Border Only)' or 'Square (Double Border)' expected, got %s)", areatype)
    end
  elseif t == 'number' and areatype >= 1 or areatype <= 3 then
    areatype = SA_TYPE[areatype]
  else
    return printerrorf("bad argument #2 to 'setareatype' (string or number (1-3) expected, got %s%s)", t, not table.find({1,2,3}, areatype) and " different than the value expected" or '')
  end

  return setareasetting(name, 'Type', areatype)
end
