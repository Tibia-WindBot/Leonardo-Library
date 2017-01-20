function unequipitem(slot, bp, amount)
  slot = slotNames[slot:lower()]

  if slot then
    item = slot()

    if item.obj.id > 0 then
      if type(bp) == 'number' then
        amount = bp
        bp = '0-15'
      elseif not amount then
        amount = item.obj.count
      end

      return moveitems(item.obj.id, bp, item.name, amount or item.obj.count)
    end
  end
end

-- ALISASES
unequip = unequip or unequipitem
dequip = dequip or unequip
dequipitem = dequipitem or dequip
