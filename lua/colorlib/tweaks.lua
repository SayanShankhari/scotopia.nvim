-- =========================================================
-- 4. COLOR TWEAKS & VARIATIONS
-- =========================================================

local mathx = require ("colorlib.mathx");
local registry = require ("colorlib.registry");
local core = require ("colorlib.core");
local composting = require ("colorlib.composting");

local Variations = {};


Variations.darken = function (color, amount, profile)
  if not amount then amount = 0.5 end;
  if amount < 0 or amount > 1 then error ("amount should be in range [0,1] (i.e. in percentage value)") end;
  amount = mathx.clamp (amount or 0, 0, 1);
  profile = string.lower (profile or "xrgb");

  local ok, err = color:valid();
  if not ok then error (err) end;

  -- mix towards pure black
  local target_black = {
    r = 0, g = 0, b = 0, bit_depth = 8,
    lr = 0, lg = 0, lb = 0,
    sr = 0, sg = 0, sb = 0,
    h = 0, s = 0, l = 0, i = 0, v = 0,
  }
  -- overwrite
  target_black = core.create (registry.Profile.xRGB, { xrgb="#000000" }, { bit_depth=8 });
  local final_color = composting.mix_colors (color, target_black, amount, registry.Profile.xRGB);
  if not final_color then error ("unable to generate!!!") end;

  return final_color;
  --return final_color.channels.xrgb;

--[[
  if #profile <= 4 and profile:find ("rgb", 1, true) then -- RECTANGULAR
    if profile == "lrgb" or profile == "srgb" or profile == "rgb" then
      return Variations.mix_colors (color, target_black, amount, profile);
    else
      error ("Error: darken => Unknown color-space!");
    end
  elseif profile:find ("hs", 1, true) then
    if profile == "hsl" or profile == "hsi" or profile == "hsv" then
      return Variations.mix_colors (color, target_black, amount, profile);
    else
      error();
    end
  else
    error ("Error: darken => Unknown color-space!");
  end
--]]
--[[
-- ALTERNATIVE
    local v = color.values
    if profile == "hsl" then
        return { h = v.h, s = v.s, l = clamp(v.l * (1.0 - amount), 0, 100), bit_depth = v.bit_depth }
    else
        local factor = 1.0 - clamp(amount, 0.0, 1.0)
        return { r = math.floor(v.r * factor), g = math.floor(v.g * factor), b = math.floor(v.b * factor), bit_depth = v.bit_depth }
    end
--]]

end

Variations.lighten = function (color, amount, profile)
  if not amount then amount = 0.5 end;
  if amount < 0 or amount > 1 then error ("amount should be in range [0,1] (i.e. in percentage value)") end;
  amount = mathx.clamp (amount or 0, 0, 1);
  profile = string.lower (profile or "xrgb");

  local ok, err = color:valid();
  if not ok then error (err) end;

  -- mix towards pure black
  local target_white = core.create (registry.Profile.xRGB, { xrgb="#ffffff" }, { bit_depth=8 });
  local final_color = composting.mix_colors (color, target_white, amount, registry.Profile.xRGB);
  if not final_color then error ("unable to generate!!!") end;

  return final_color;
  --return final_color.channels.xrgb;

--[[
  amount = mathx.clamp (amount or 0, 0, 1);
  profile = string.lower (profile or "rgb");

  -- mix towards pure black
  local target_white = {
    r = 255, g = 255, b = 255, bit_depth = 8,
    lr = 1, lg = 1, lb = 1,
    sr = 1, sg = 1, sb = 1,
    h = 0, s = 0, l = 1, i = 1, v = 1,
  }

  if #profile <= 4 and profile:find ("rgb", 1, true) then -- RECTANGULAR
    if profile == "lrgb" or profile == "srgb" or profile == "rgb" then
      return Variations.mix_colors (color, target_white, amount, profile);
    else
      error ("Error: darken => Unknown color-space!");
    end
  elseif profile:find ("hs", 1, true) then
    if profile == "hsl" or profile == "hsi" or profile == "hsv" then
      return Variations.mix_colors (color, target_white, amount, profile);
    else
      error();
    end
  else
    error ("Error: darken => Unknown color-space!");
  end
--]]
--[[
-- ALTERNATIVE
    local v = color.values
    if profile == "hsl" then
        return { h = v.h, s = v.s, l = clamp(v.l + (100 - v.l) * amount, 0, 100), bit_depth = v.bit_depth }
    else
        local max_val = (2 ^ v.bit_depth) - 1
        return {
            r = math.floor(v.r + (max_val - v.r) * amount),
            g = math.floor(v.g + (max_val - v.g) * amount),
            b = math.floor(v.b + (max_val - v.b) * amount),
            bit_depth = v.bit_depth
        }
    end
--]]
end

Variations.rotate_hue = function (color, degrees)
  -- expects HSL/V/I color profile
  -- 1. Identify your dynamic third channel key (l, v, or i)
  local k3 = color.l and "l" or (color.v and "v" or "i");
  -- 2. Return a fresh table keeping original channels intact
  return {
    h = (color.h + degrees) % 360,
    s = color.s,
    [k3] = color [k3],
  };
end

Variations.adjust_saturation = function (color, factor)
  local r, g, b = color.r, color.g, color.b;

  -- Rec. 709 luma coeffecients
  local luma = 0.2126 * r + 0.7152 * g + 0.0722 * b;

  -- linear interpolation
  -- new = luma + factor * (original - luma)
  local new_r = luma + factor * (r - luma);
  local new_g = luma + factor * (g - luma);
  local new_b = luma + factor * (b - luma);

  return { r = new_r, g = new_g, b = new_b };
--[[
-- Expects HSL profile color
    local s = clamp(color.values.s * factor, 0, 100)
    return { h = color.values.h, s = s, l = color.values.l, bit_depth = color.values.bit_depth }
--]]

end

-- TODO: use lrgb with tint/shade
-- TODO: use nhsl with lighten/darken

-- Art Theory Variations: Tint (+White), Shade (+Black), Tone (+Gray)

Variations.tint = function (color, amount, profile)
  Variations.lighten (color, amount, profile);
--[[
-- Mixes color with pure White
    local max_val = (2 ^ color.values.bit_depth) - 1
    local white = { values = { r = max_val, g = max_val, b = max_val, bit_depth = color.values.bit_depth } }
    return ops.mix_colors(color, white, amount, profile)
--]]
end

Variations.shade = function (color, amount, profile)
  Variations.darken (color, amount, profile);
--[[
-- Mixes color with pure Black
    local black = { values = { r = 0, g = 0, b = 0, bit_depth = color.values.bit_depth } }
    return ops.mix_colors(color, black, amount, profile)
--]]
end

Variations.tone = function (base_color, weight, profile)
  profile = profile or "lrgb";
  local color_mid = { r = 128, g = 128, b = 128, bit_depth = 8 };
  return Variations.mix_colors(base_color, color_mid, weight, profile);
--[[
-- Mixes color with 50% neutral Gray
    local mid_val = math.floor(((2 ^ base_color.values.bit_depth) - 1) / 2)
    local gray = { values = { r = mid_val, g = mid_val, b = mid_val, bit_depth = base_color.values.bit_depth } }
    return ops.mix_colors(base_color, gray, weight, profile)
--]]
end


return Variations;
