function sprintf(str, ...)
  return #{...} > 0 and tostring(str):format(...) or tostring(str)
end
