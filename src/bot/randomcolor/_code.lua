function randomcolor(options)
  options = options or {}
  local h, s, l = math.random(0, 360), math.random(0, 100) / 100, math.random(0, 100) / 100
  local monochrome = false

  if options.hue then
    local hueType = type(options.hue)

    if hueType == 'string' then
      options.hue = options.hue:lower()

      if defaultColors[options.hue] then
        if options.hue == 'monochrome' then
          h, s, monochrome = 0, 0, true
        else
          h = math.random(defaultColors[options.hue][1], defaultColors[options.hue][2])
        end
      end
    elseif hueType == 'number' and options.hue <= 360 and options.hue >= 0 then
      h = options.hue
    end
  end

  if (not monochrome) and options.saturation and options.saturation <= 100 and options.saturation >= 0 then
    s = options.saturation / 100
  end

  if options.brightness then
    local brightnessType = type(options.brightness)

    if brightnessType == 'string' then
      options.brightness = options.brightness:lower()

      if options.brightness == 'dark' then
        l = math.random(0, 33) / 100
      elseif options.brightness == 'light' then
        l = math.random(67, 100) / 100
      elseif options.brightness == 'medium' then
        l = math.random(34, 66) / 100
      end
    elseif brightnessType == 'number' and options.brightness <= 100 and options.brightness >= 0 then
      l = options.brightness / 100
    end
  end

  if options.amount then
    local tbl, opt = {}, table.copy(options)

    opt.amount = nil

    for i = 0, options.amount-1 do
      if options.gradient then
        table.insert(tbl, (i * 100 / options.amount) / 100)
      end

      table.insert(tbl, randomcolor(opt))
    end

    return unpack(tbl)
  end

  -- the code below was basically copied from here:
  -- http://stackoverflow.com/questions/10393134/converting-hsl-to-rgb

  h = h / 60
  local chroma = (1 - math.abs(2 * l - 1)) * s
  local x = (1 - math.abs(h % 2 - 1)) * chroma
  local r, g, b = 0, 0, 0

  if h < 1 then
    r, g, b = chroma, x, 0
  elseif h < 2 then
    r, b, g = x, chroma, 0
  elseif h < 3 then
    r, g, b = 0, chroma, x
  elseif h < 4 then
    r, g, b = 0, x, chroma
  elseif h < 5 then
    r, g, b = x, 0, chroma
  else
    r, g, b = chroma, 0, x
  end

  local m = l - chroma / 2

  return color((r + m) * 256, (g + m) * 256, (b + m) * 256, options.transparency)
end
