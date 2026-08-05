local Registry = {};
Registry.__index = Registry; -- fallback, if any key not found, checks in metatable

-- available profiles
Registry.Profile = {
  RGB   = "rgb",
  sRGB  = "srgb",
  lRGB  = "lrgb",
  xRGB  = "xrgb",
  HSL   = "hsl",
  HSV   = "hsv",
  HSI   = "hsi",
  nHSL  = "nhsl",
  nHSV  = "nhsv",
  nHSI  = "nhsi",
  OkLAB = "oklab",
  OkLCH = "oklch",
  CMYK  = "cmyk",
}

--[[
Registry.conversionsLUT = {
  ["rgb_to_srgb"]  = conversions.rgb_to_srgb,
  ["lrgb_to_srgb"] = conversions.lrgb_to_srgb,
  ["srgb_to_lrgb"] = conversions.srgb_to_lrgb,
  ["srgb_to_rgb"]  = conversions.srgb_to_rgb,
  ["lrgb_to_rgb"]  = conversions.lrgb_to_rgb,
  ["rgb_to_xrgb"]  = conversions.rgb_to_xrgb,
  ["hsl_to_nhsl"]  = conversions.hsl_to_nhsl,
  ["nhsl_to_hsl"]  = conversions.nhsl_to_hsl,
  ["lrgb_to_nhsl"] = conversions.lrgb_to_nhsl,
  ["nhsl_to_lrgb"] = conversions.nhsl_to_lrgb,
  ["hsl_to_xrgb"]  = conversions.hsl_to_xrgb,
  ["xrgb_to_rgb"]  = conversions.xrgb_to_rgb,
  ["xrgb_to_hsl"]  = conversions.xrgb_to_hsl,
}
--]]

Registry.Channels = {
  [ Registry.Profile.RGB ]   = { "r", "g", "b" },
  [ Registry.Profile.sRGB ]  = { "sr", "sg", "sb" },
  [ Registry.Profile.lRGB ]  = { "lr", "lg", "lb" },
  [ Registry.Profile.xRGB ]  = { "xrgb" },
  [ Registry.Profile.HSL ]   = { "h", "s", "l" },
  [ Registry.Profile.HSV ]   = { "h", "s", "v" },
  [ Registry.Profile.HSI ]   = { "h", "s", "i" },
  [ Registry.Profile.nHSL ]  = { "nh", "ns", "nl" },
  [ Registry.Profile.nHSV ]  = { "nh", "ns", "nv" },
  [ Registry.Profile.nHSI ]  = { "nh", "hs", "ni" },
  [ Registry.Profile.OkLAB ] = { "l", "a", "b" },
  [ Registry.Profile.OkLCH ] = { "l", "c", "h" },
  [ Registry.Profile.CMYK ]  = { "c", "m", "y", "k" },
}


return Registry;
