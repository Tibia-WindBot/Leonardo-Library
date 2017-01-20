function isabletocast(spell)
  spell = ("userdata|table"):find(type(spell)) ~= nil and spell or spellinfo(spell)

  return spell.cancast
end
