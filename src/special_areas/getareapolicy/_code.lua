function getareapolicy(name)
  local setting = getareasetting(name, 'Policy')

  return setting or POLICY_NONE
end
