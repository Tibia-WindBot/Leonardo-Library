function checklocation(dist, label, section)
  local t = type(dist)
  dist = (t == 'number' and dist > 0) and dist or false

  if t == 'number' and not ($posx <= $wptx + dist and $posx >= $wptx-dist and $posy <= $wpty + dist and $posy >= $wpty - dist and $posz == $wptz) then
    if not (label and section) then
      return false
    else
      return gotolabel(label, section)
    end
  elseif t == 'boolean' and not dist then
    if not (label and section) then
      return false
    else
      return gotolabel(label, section)
    end
  end

  return true
end
