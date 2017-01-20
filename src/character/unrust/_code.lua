function unrust(ignore, drop, value)
  print('`unrust` is deprecated as of version 2.0.0, please check [[URL]]')
  local IgnoreCommon = ignore or true
  local DropTrash = drop or true
  local MinValue = math.max(value or 0, 0)

  if itemcount(9016) == 0 and clientitemhotkey(9016, "crosshair") == 'not found' then
    return nil
  end

  local Amount, Trash = {}, {}

  for _, Item in ipairs({3357, 3358, 3359, 3360, 3362, 3364, 3370, 3371, 3372, 3377, 3381, 3382, 3557, 3558, 8063}) do
    if itemvalue(Item) >= MinValue then
      Amount[Item] = itemcount(Item)
    else
      table.insert(Trash, Item)
    end
  end

  local RustyItems = IgnoreCommon and {8895, 8896, 8898, 8899} or {8894, 8895, 8896, 8897, 8898, 8899}

  for _, Item in ipairs(RustyItems) do
    if itemcount(Item) > 0 then
      pausewalking(itemcount(Item) * 2000)
      useitemon(9016, Item, '0-15') waitping(1, 1.5)
      increaseamountused(9016, 1)
      pausewalking(0)
    end
  end

  if DropTrash then
    for _, Item in ipairs(Trash) do
      if itemcount(Item) > 0 then
        pausewalking(2000)
        moveitems(Item, "ground") waitping(1, 1.5)
        pausewalking(0)
      end
    end
  end

  for Item, Count in pairs(Amount) do
    local Current = itemcount(Item)

    if Current > Count then
      Amount[Item] = Current

      increaseamountlooted(Item, Current - Count)
    end
  end
end
