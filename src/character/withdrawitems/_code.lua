function withdrawitems(where, to, ...)
  print('`withdrawitems` is deprecated as of 2.0.0, please check [[URL]].')
  local items = {...}
  local tempType = type(where)
  local waitFunc = function()
    return waitping(1.5, 2)
  end

  if tempType == 'string' then
    where = where:lower()

    if where:find('depot') or where:find('box') then
      -- user input depot
      where = itemname(depotindextoid($favoritedepot))
    elseif where:find('inbox') then
      -- used input inbox, but the correct name is 'Your Inbox'
      where = 'Your Inbox'
    else
      -- used input any container name
      local lootdest = getlootingdestination(where)
      where = lootdest ~= '' and lootdest or itemname(where)
    end
  elseif tempType == 'userdata' and where.objtype == 'container' then
    -- user input any container object, we only want the name
    where = where.name
  else
    return false
  end

  tempType = type(to)

  if tempType == 'table' then
    -- user input a table of items
    table.insert(items, 1, to)
    to = '0-15'
  elseif tempType == 'string' then
    if getcontainer(to).name == '' and tonumber(to:sub(1,1)) == nil then
      -- used input a invalid container and invalid index
      return false
    end

    to = getlootingdestination(to) or itemname(to)
  elseif tempType == 'userdata' and to.objtype == 'container' then
    -- used input a container object, we only want the name
    to = to.name
  end

  if type(items[#items]) == 'function' then
    waitFunc = table.remove(items)
  end

  for _, item in ipairs(items) do
    tempType = type(item)

    if tempType == 'table' then
      local bp, id, amount = itemname(item.backpack or item.bp or item[1]), item.name or item[2], item.amount or item.count or item[3] or 100

      if id and bp and amount then
        moveitemsupto(id, amount, bp, where) waitFunc()
      end
    elseif tempType == 'number' or tempType == 'string' then
      moveitems(item, to, where) waitFunc()
    end
  end

  return true
end
