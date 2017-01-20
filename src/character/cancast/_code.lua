function cancast(spell, cre)
  spell = ("userdata|table"):find(type(spell)) ~= nil and spell or spellinfo(spell)

  local cool, strike = LIB_CACHE.cancast[spell.name:lower()] or 0, false

  if cre then
    cre = type(cre) == 'userdata' and cre or findcreature(cre)

    if spell.castarea ~= 'None' and spell.castarea ~= '' then
      strike = spell.words
    end
  end

  return (not strike or isonspellarea(cre, strike, $self.dir)) and $timems >= cool and $level >= spell.level and $mp >= spell.mp and $soul >= spell.soul and cooldown(spell.words) == 0
end
