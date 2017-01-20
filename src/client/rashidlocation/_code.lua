function rashidlocation()
  local weekday = os.date("%w", os.time()-(86400-sstime()))

  return ({"Carlin", "Svargrond", "Liberty Bay", "Port Hope", "Ankrahmun", "Darashia", "Edron"})[weekday % 7 + 1]
end
