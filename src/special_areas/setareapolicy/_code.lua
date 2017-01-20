function setareapolicy(name, policy)
  local polType = type(policy)

  if polType == 'string' and not table.find({"cavebot", "cavebot & targeting", "targeting", "none"}, policy:lower()) then
    policy = "None"
  elseif polType == 'number' and policy > 0 and policy <= 3 then
    policy = SA_POLICY[policy]
  else
    policy = "None"
  end

  return setareasetting(name, 'Policy', policy)
end
