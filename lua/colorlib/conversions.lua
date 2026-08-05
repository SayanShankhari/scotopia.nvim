--------------------------------------------------------
-- Conversions
--------------------------------------------------------

local mathx = require ("colorlib.mathx");
local xforms = require ("colorlib.xforms");

local Conversions = {};


-- RGB (Red-Green-Blue) to sRGB (standard Red-Green-Blue)
--- @param red integer [0-255/1023/65565]
--- @param green integer [0-255/1023/65565]
--- @param blue integer [0-255/1023/65565]
--- @param bit_depth integer [8/10/16]
--- @return number sr [0-1]
--- @return number sg [0-1]
--- @return number sb [0-1]
function Conversions.rgb_to_srgb (red, green, blue, bit_depth)
  bit_depth = bit_depth or 8;
  local sr, sg, sb = xforms.normalize_rgb (red, green, blue, bit_depth);
  return sr, sg, sb;
end

-- lRGB (linear Red-Green-Blue) to sRGB (standard Red-Green-Blue)
-- linear-RGB to standard-RGB (gamma corrected)
-- real intensity to eye perceived value
--- @param lr number [0-1]
--- @param lg number [0-1]
--- @param lb number [0-1]
--- @return number sr [0-1]
--- @return number sg [0-1]
--- @return number sb [0-1]
function Conversions.lrgb_to_srgb (lr, lg, lb)
  local sr = xforms.compress_gamma_math (lr);
  local sg = xforms.compress_gamma_math (lg);
  local sb = xforms.compress_gamma_math (lb);
  return sr, sg, sb;
end

-- lRGB (linear Red-Green-Blue) to sRGB (standard Red-Green-Blue)
-- linear-RGB to standard-RGB (gamma corrected)
-- real intensity to eye perceived value
--- @param bit_depth number 8/10/16
--- @param lr number [0-1]
--- @param lg number [0-1]
--- @param lb number [0-1]
--- @return number sr [0-1]
--- @return number sg [0-1]
--- @return number sb [0-1]
function Conversions.lrgb_to_srgb_LUT (bit_depth, lr, lg, lb)
  local sr = xforms.compress_gamma_fast (bit_depth, lr);
  local sg = xforms.compress_gamma_fast (bit_depth, lg);
  local sb = xforms.compress_gamma_fast (bit_depth, lb);
  return sr, sg, sb;
end

-- lRGB (linear Red-Green-Blue) to sRGB (standard Red-Green-Blue)
-- linear-RGB to standard-RGB (gamma corrected)
-- real intensity to eye perceived value
--- @param lr number [0-1]
--- @param lg number [0-1]
--- @param lb number [0-1]
--- @return number sr [0-1]
--- @return number sg [0-1]
--- @return number sb [0-1]
function Conversions.lrgb_to_srgb_approx (lr, lg, lb)
  local sr = xforms.compress_gamma_approx (lr);
  local sg = xforms.compress_gamma_approx (lg);
  local sb = xforms.compress_gamma_approx (lb);
  return sr, sg, sb;
end

-- sRGB (standard Red-Green-Blue) to lRGB (linear Red-Green-Blue)
-- standard-RGB to linear-RGB (gamma reverted)
-- eye perceived value to real intensity
--- @param sr number [0-1]
--- @param sg number [0-1]
--- @param sb number [0-1]
--- @return number lr [0-1]
--- @return number lg [0-1]
--- @return number lb [0-1]
function Conversions.srgb_to_lrgb (sr, sg, sb)
  local lr = xforms.expand_gamma (sr);
  local lg = xforms.expand_gamma (sg);
  local lb = xforms.expand_gamma (sb);
  return lr, lg, lb;
end

function Conversions.srgb_to_rgb (sr, sg, sb, bit_depth)
  bit_depth = bit_depth or 8;
  -- calcualte maximum possible value
  local max = 2 ^ bit_depth - 1;
  -- quantize the channels
  local r = mathx.round (max * sr);
  local g = mathx.round (max * sg);
  local b = mathx.round (max * sb);
  -- return the values
  return r, g, b;
end

-- RGB to linear RGB
--- @param lr number [0-255/1023/65535]
--- @param lg number [0-255/1023/65535]
--- @param lb number [0-255/1023/65535]
--- @param bit_depth? integer 8/10/16
--- @return number lr [0-1]
--- @return number lg [0-1]
--- @return number lb [0-1]
function Conversions.lrgb_to_rgb (lr, lg, lb, bit_depth)
  bit_depth = bit_depth or 8;
  if bit_depth ~= 8 and bit_depth ~= 10 and bit_depth ~= 16 then
    error ("invalid bit_depth");
  end
  local sr, sg, sb = Conversions.lrgb_to_srgb (lr, lg, lb);
  local r, g, b = Conversions.srgb_to_rgb (bit_depth, sr, sg, sb);
  return r, g, b;
end

-- RGB to hex RGB
--- @param r number [0-255/1023/65535]
--- @param g number [0-255/1023/65535]
--- @param b number [0-255/1023/65535]
--- @param bit_depth? integer 8/10/16
--- @return string xrgb #rrggbb/#rrrgggbbb/#rrrrggggbbbb
function Conversions.rgb_to_xrgb (r, g, b, bit_depth)
  bit_depth = bit_depth or 8;
  if bit_depth ~= 8 and bit_depth ~= 10 and bit_depth ~= 16 then
    error ("invalid bit_depth");
  end
  -- calcualte maximum possible value
  local max = 2 ^ bit_depth - 1;
  -- check inputs
  if
    r < 0 or r > max
    or g < 0 or g > max
    or b < 0 or b > max
  then
    error ("Input out of bounds [0-255]!");
  end
  if r % 1 ~= 0 or g % 1 ~= 0 or b % 1 ~= 0 then
    error ("Inputs should be integers!");
  end

  local xrgb;

  if bit_depth == 8 then
    xrgb = string.format ("%02x%02x%02x", r, g, b);
  elseif bit_depth == 10 then
    xrgb = string.format ("%03x%03x%03x", r, g, b);
  elseif bit_depth == 16 then
    xrgb = string.format ("%04x%04x%04x", r, g, b);
  else
    error ("Invalid bit depth! only 8, 10 or 16 is allowed!");
  end

  return "#" .. xrgb;
end

-- normalize HSL (Hue-Saturation-Lightness)
--- @param hue number [0-360)
--- @param saturation number [0-100]
--- @param lightness number [0-100]
--- @return number nh [0-360)
--- @return number ns [0-1]
--- @return number nl [0-1]
function Conversions.hsl_to_nhsl (hue, saturation, lightness)
  -- filter inputs
  -- lua addresses negative numbers
  hue = (hue % 360);
  saturation = mathx.clamp (saturation, 0, 100);
  lightness = mathx.clamp (lightness, 0, 100);

  -- calculate refined values
  local nh = hue;
  local ns = saturation / 100;
  local nl = lightness / 100;

  return nh, ns, nl;
end

-- denormalize nHSL (normalized Hue-Saturation-Lightness)
--- @param nh number [0-360)
--- @param ns number [0-1]
--- @param nl number [0-1]
--- @return number hue [0-360)
--- @return number saturation [0-100]
--- @return number lightness [0-100]
function Conversions.nhsl_to_hsl (nh, ns, nl)
  -- filter inputs
  nh = mathx.clamp (nh, 0, 360);
  ns = mathx.clamp (ns, 0, 1);
  nl = mathx.clamp (nl, 0, 1);

  -- calculate refined values
  local hue = mathx.round (nh % 360);
  local saturation = mathx.round (100 * ns);
  local lightness = mathx.round (100 * nl);

  return hue, saturation, lightness;
end

-- denormalize nHSL (normalized Hue-Saturation-Lightness)
--- @param lr number [0-1]
--- @param lg number [0-1]
--- @param lb number [0-1]
--- @return number nh [0-360)
--- @return number ns [0-100]
--- @return number nl [0-100]
function Conversions.lrgb_to_nhsl (lr, lg, lb)
  -- refine inputs
  -- clamp to reduce accidental 1.0000000000000002 or -0.3
  lr = mathx.clamp (lr, 0, 1);
  lg = mathx.clamp (lg, 0, 1);
  lb = mathx.clamp (lb, 0, 1);

  -- calculate M (max) and m (min)
  local max = math.max (lr, lg, lb);
  local min = math.min (lr, lg, lb);

  -- C (chroma or delta) = range (R,G,B) = M - m
  local chroma = max - min;

  -- calculate H’ (hue_prime) and H (hue)
  local hue_prime = 0; -- default if C=0 as in R=G=B
  if chroma == 0 then
    hue_prime = 0; -- undefined | zero
  elseif max == lr then
    hue_prime = ((lg - lb) / chroma) % 6;
  elseif max == lg then
    hue_prime = ((lb - lr) / chroma) + 2;
  elseif max == lb then
    hue_prime = ((lr - lg) / chroma) + 4;
  end

  -- H = 60°⋅H’
  local hue = 60 * hue_prime; -- in degrees

  -- L (lightness) = mid(R,G,B) = (M+m)/2
  local lightness = (max + min) / 2;

  -- calculate saturation
  local saturation = 0; -- default, if L=0 or L=1
  -- if lightness ~= 0 and lightness ~= 1 then
  if chroma ~= 0 then
    saturation = chroma / (1 - math.abs (2 * lightness - 1));
  end

  -- refine outputs
  -- local nh = (hue % 360 + 360) % 360; -- handles greater and negative values
  local nh = hue % 360; -- lua handles above negative modulus
  local ns = mathx.clamp (saturation, 0, 1);
  local nl = mathx.clamp (lightness, 0, 1);

  return nh, ns, nl;
end

-- nHSL (normalize Hue-Saturation-Lightness) to lRGB (linear Red-Green-Blue)
--- @param nh number [0-360)
--- @param ns number [0-1]
--- @param nl number [0-1]
--- @return number lr [0-1]
--- @return number lg [0-1]
--- @return number lb [0-1]
function Conversions.nhsl_to_lrgb (nh, ns, nl)
  -- refine inputs
  local hue = nh;
  local saturation = mathx.clamp (ns, 0, 1);
  local lightness = mathx.clamp (nl, 0, 1);

  -- calculate C (chroma)
  local chroma = (1 - math.abs (2 * lightness - 1)) * saturation;
  -- H’=H/60°
  local hue_prime = hue / 60;
  -- x (intermediate value) = second largest component
  local x = chroma * (1 - math.abs (hue_prime % 2 - 1));

  -- piecewise function for (R1, G1, B1)
  local lr1, lg1, lb1;
  if hue_prime >= 0 and hue_prime < 1 then
    lr1, lg1, lb1 = chroma, x, 0;
  elseif hue_prime >= 1 and hue_prime < 2 then
    lr1, lg1, lb1 = x, chroma, 0;
  elseif hue_prime >= 2 and hue_prime < 3 then
    lr1, lg1, lb1 = 0, chroma, x;
  elseif hue_prime >= 3 and hue_prime < 4 then
    lr1, lg1, lb1 = 0, x, chroma;
  elseif hue_prime >= 4 and hue_prime < 5 then
    lr1, lg1, lb1 = x, 0, chroma;
  elseif hue_prime >= 5 and hue_prime < 6 then
    lr1, lg1, lb1 = chroma, 0, x;
  end

  -- match lightness factor ml=L-C/2
  local ml = lightness - chroma / 2;
  -- (R,G,B) = (R1+ml,G1+ml,B1+ml)
  local lr, lg, lb = lr1 + ml, lg1 + ml, lb1 + ml;

  -- refine outputs
  lr = mathx.clamp (lr, 0, 1);
  lg = mathx.clamp (lg, 0, 1);
  lb = mathx.clamp (lb, 0, 1);

  return lr, lg, lb;
end

function Conversions.hsl_to_xrgb (h, s, l)
  local nh, ns, nl = Conversions.hsl_to_nhsl (h, s, l);
  local lr, lg, lb = Conversions.nhsl_to_lrgb (nh, ns, nl);
  local sr, sg, sb = Conversions.lrgb_to_srgb (lr, lg, lb);
  local r, g, b = xforms.quantize_rgb (sr, sg, sb);
  local xrgb = Conversions.rgb_to_xrgb (r, g, b);
  return xrgb;
end

function Conversions.xrgb_to_rgb (xrgb, bit_depth)
  bit_depth = bit_depth or 8;

  if type (xrgb) ~= "string" then
    error ("Error! @color_space.xrgb_to_rgb => 'xrgb' expected as string");
  end
  -- remove leading octothorpe/pound/hash if exists
  if xrgb:byte(1) == string.byte("#") then
    xrgb = xrgb:sub(2);
  end
  -- check for length and match bit depth
  -- length = 3 × ⌈ bit_depth / 4 ⌉
  -- unit = 4 bit => 3 × ⌈ 4/4 ⌉ = 3
  -- 8|10|16 bit => 3 × ⌈ (8|10|16)/4 ⌉ = 6|9|12
  local expected_length = 3 * math.ceil (bit_depth / 4);
  if #xrgb ~= expected_length then
    error (string.format ("Error! @conversion.xrgb_to_rgb => Invalid string length, should be %d!", expected_length));
  end

  -- lookup table
  local allowedBytes = {};
  -- add ASCII bytes for '0' through '9'
  for i = string.byte ("0"), string.byte ("9") do
    allowedBytes [i] = true;
  end
  -- add ASCII bytes for 'a' through 'f'
  for i = string.byte ("a"), string.byte ("f") do
    allowedBytes [i] = true;
  end
  -- add ASCII bytes for 'A' through 'F'
  for i = string.byte ("A"), string.byte ("F") do
    allowedBytes [i] = true;
  end
  -- scan for invalid characters
  for i = 1, #xrgb do
    local char_byte = xrgb:byte (i)
    if not allowedBytes [char_byte] then
      error (string.format ("%c is not a valid hexadecimal nibble character!", string.char (char_byte)));
    end
  end

  -- process if all clear
  local channel_length = math.floor (expected_length / 3);
  local start_index = 1;
  local end_index = start_index + channel_length - 1;
  local r = mathx.hex_to_int (xrgb:sub (start_index, end_index), bit_depth);
  start_index = end_index + 1;
  end_index = start_index + channel_length - 1;
  local g = mathx.hex_to_int (xrgb:sub (start_index, end_index), bit_depth);
  start_index = end_index + 1;
  end_index = start_index + channel_length - 1;
  local b = mathx.hex_to_int (xrgb:sub (start_index, end_index), bit_depth);

  return r, g, b;
end

function Conversions.xrgb_to_hsl (xrgb)
  local r, g, b = Conversions.xrgb_to_rgb (xrgb);
  local sr, sg, sb = xforms.normalize_rgb (r, g, b);
  local lr, lg, lb = Conversions.srgb_to_lrgb (sr, sg, sb);
  local nh, ns, nl = Conversions.lrgb_to_nhsl (lr, lg, lb);
  local h, s, l = Conversions.nhsl_to_hsl (nh, ns, nl);
  return math.floor(h), math.floor(s), math.floor(l);
end

function Conversions.rgb_to_lrgb (r, g, b, bit_depth)
  bit_depth = bit_depth or 8;
  local sr, sg, sb = Conversions.rgb_to_srgb (r, g, b, bit_depth);
  local lr, lg, lb = Conversions.srgb_to_lrgb (sr, sg, sb);
  return lr, lg, lb;
end

function Conversions.xrgb_to_lrgb (xrgb, bit_depth)
  bit_depth = bit_depth or 8;
  local r, g, b = Conversions.xrgb_to_rgb (xrgb, bit_depth);
  local sr, sg, sb = Conversions.rgb_to_srgb (r, g, b, bit_depth);
  local lr, lg, lb = Conversions.srgb_to_lrgb (sr, sg, sb);
  return lr, lg, lb;
end

function Conversions.lrgb_to_xrgb (lr, lg, lb, bit_depth)
  bit_depth = bit_depth or 8;
  local sr, sg, sb = Conversions.lrgb_to_srgb (lr, lg, lb);
  local r, g, b = Conversions.srgb_to_rgb (sr, sg, sb, bit_depth);
  local xrgb = Conversions.rgb_to_xrgb (r, g, b, bit_depth);
  return xrgb;
end



-- OkLAB & OkLCH
function Conversions.lrgb_to_oklab (lr, lg, lb)
  -- 1. Linear RGB to LMS
  local l_cone = 0.4122214708 * lr + 0.5363325363 * lg + 0.0514459929 * lb;
  local m_cone = 0.2119034982 * lr + 0.6806995451 * lg + 0.1073969566 * lb;
  local s_cone = 0.0883024619 * lr + 0.2817188376 * lg + 0.6299787005 * lb;

  -- 2. Non-linear cube root activation
  local l_prime = mathx.cube_root (l_cone);
  local m_prime = mathx.cube_root (m_cone);
  local s_prime = mathx.cube_root (s_cone);

  -- 3. LMS' to Oklab
  local l = 0.2104542553 * l_prime + 0.7936177850 * m_prime - 0.0040720468 * s_prime;
  local a = 1.9779984951 * l_prime - 2.4285922050 * m_prime + 0.4505937099 * s_prime;
  local b = 0.0259040371 * l_prime + 0.7827717662 * m_prime - 0.8086757983 * s_prime;

  return l, a, b;
end


function Conversions.oklab_to_lrgb (l, a, b)
  -- 1. Oklab to LMS'
  local l_prime = l + 0.3963377774 * a + 0.2158037573 * b;
  local m_prime = l - 0.1055613458 * a - 0.0638541728 * b;
  local s_prime = l - 0.0894841775 * a - 1.2914855480 * b;

  -- 2. Cube
  local l_cone = l_prime * l_prime * l_prime;
  local m_cone = m_prime * m_prime * m_prime;
  local s_cone = s_prime * s_prime * s_prime;

  -- 3. LMS to Linear RGB
  local lr = 4.0767416621 * l_cone - 3.3077115913 * m_cone + 0.2309699292 * s_cone;
  local lg = -1.2684380046 * l_cone + 2.6097574011 * m_cone - 0.3413193965 * s_cone;
  local lb = -0.0041960863 * l_cone - 0.7034186147 * m_cone + 1.7076147010 * s_cone;

  return lr, lg, lb;
end

function Conversions.oklab_to_oklch (l, a, b)
  local c = mathx.hypot (a, b); -- linear distance
  local h = (mathx.atan2 (b, a) * 180) / math.pi;
  if (h < 0) then h = h + 360 end;
  return l, c, h;
end

function Conversions.oklch_to_oklab (l, c, h)
  local hRad = (h * math.pi) / 180;
  local a = c * math.cos (hRad);
  local b = c * math.sin (hRad);
  return l, a, b;
end

function Conversions.xrgb_to_oklch (xrgb)
  local lr, lg, lb = Conversions.xrgb_to_lrgb (xrgb);
  local l, a, b = Conversions.lrgb_to_oklab (lr, lg, lb);
  local L, c, h = Conversions.oklab_to_oklch (l, a, b);
  return L, c, h;
end

-- Helper to check if a linear RGB color fits in the [0, 1] gamut
local function in_gamut (lr, lg, lb)
  local eps = 0.00001;
  return mathx.in_limit (lr, -eps, 1 + eps)
    and mathx.in_limit (lg, -eps, 1 + eps)
    and mathx.in_limit (lb, -eps, 1 + eps);
end
--[[
-- Reduces Chroma until Oklch fits into the sRGB gamut
local function fit_to_lrgb_gamut (L, a, b)
  -- 1. If L is at extremes, return black or white
  if L >= 1.0 then return 1.0, 1.0, 1.0 end;
  if L <= 0.0 then return 0.0, 0.0, 0.0 end;
  -- 2. Check if the initial color is already inside the gamut
  local l, a, b = Conversions.oklch_to_oklab (L, C, h);
  local lr, lg, lb = Conversions.oklab_to_lrgb (l, a, b);
  if in_gamut (lr, lg, lb) then
    return lr, lg, lb; -- Fits as-is!
  end
  -- 3. Binary Search for the highest valid Chroma
  local min_chroma = 0.0;
  local max_chroma = C;
  local best_lr, best_lb, best_lb = lr, lg, lb;
  -- 8 iterations provide high precision (~0.4% error margin)
  for _ = 1, 8 do
    local mid_chroma = (min_chroma + max_chroma) * 0.5; -- mean
    local test_l, test_a, test_b = Conversions.oklch_to_oklab (L, mid_chroma, h);
    local test_lr, test_lb, test_lg = Conversions.oklab_to_lrgb (test_l, test_a, test_b);
    if in_gamut (test_lr, test_lg, test_lb) then
      best_lr, best_lg, best_lb = test_lr, test_lg, test_lb;
      min_chroma = mid_chroma -- Try finding a higher chroma
    else
      max_chroma = mid_chroma -- Still out of gamut, drop chroma lower
    end
  end
  -- 4. Clamp as a final safety check for floating-point precision
  local final_lr = mathx.clamp (best_lr, 0, 1);
  local final_lg = mathx.clamp (best_lg, 0, 1);
  local final_lb = mathx.clamp (best_lb, 0, 1);
  return final_lr, final_lg, final_lb;
end
--]]
-- Reduces Chroma by scaling (a, b) towards 0 until Oklab fits into the sRGB gamut
local function fit_to_lrgb_gamut (L, a, b)
  -- 1. Handle extreme lightness boundary conditions
  if L >= 1.0 then return {1.0, 1.0, 1.0} end;
  if L <= 0.0 then return {0.0, 0.0, 0.0} end;
  -- 2. Check if the color is already in gamut
  local lr, lg, lb = Conversions.oklab_to_lrgb (L, a, b);
  if in_gamut (lr, lg, lb) then
    return lr, lg, lb; -- fits as is
  end
  -- 3. Binary Search for maximum in-gamut scale factor [0.0, 1.0]
  local min_scale = 0.0;
  local max_scale = 1.0;
  local best_lr, best_lg, best_lb = lr, lg, lb;
  -- 8 iterations provides high precision (~0.4% tolerance)
  for _ = 1, 8 do
    local mid_scale = (min_scale + max_scale) * 0.5; -- mean
    local test_l, test_a, test_b = L, a * mid_scale, b * mid_scale;
    local test_lr, test_lg, test_lb = Conversions.oklab_to_lrgb (test_l, test_a, test_b);
    if in_gamut (test_lr, test_lg, test_lb) then
      best_lr, best_lg, best_lb = test_lr, test_lg, test_lb;
      min_scale = mid_scale; -- Try higher scale (more saturation)
    else
      max_scale = mid_scale; -- Out of gamut, reduce scale
    end
  end
    -- 4. Final safety clamp for floating-point tolerance
  local final_lr = mathx.clamp (best_lr, 0, 1);
  local final_lg = mathx.clamp (best_lg, 0, 1);
  local final_lb = mathx.clamp (best_lb, 0, 1);
  return final_lr, final_lg, final_lb;
end

function Conversions.oklch_to_xrgb (l, c, h)
  if l > 100 then l = l % 100 end;
  if l > 1 then l = l / 100 end;
  local L, a, b = Conversions.oklch_to_oklab (l, c, h);
  local lr, lg, lb = fit_to_lrgb_gamut (L, a, b);
  local xrgb = Conversions.lrgb_to_xrgb (lr, lg, lb);
  return xrgb;
end


--[[
Conversions.Mappings = {
  ["rgb_to_srgb"]  = Conversions.rgb_to_srgb,
  ["lrgb_to_srgb"] = Conversions.lrgb_to_srgb,
  ["srgb_to_lrgb"] = Conversions.srgb_to_lrgb,
  ["srgb_to_rgb"]  = Conversions.srgb_to_rgb,
  ["lrgb_to_rgb"]  = Conversions.lrgb_to_rgb,
  ["rgb_to_xrgb"]  = Conversions.rgb_to_xrgb,
  ["hsl_to_nhsl"]  = Conversions.hsl_to_nhsl,
  ["nhsl_to_hsl"]  = Conversions.nhsl_to_hsl,
  ["lrgb_to_nhsl"] = Conversions.lrgb_to_nhsl,
  ["nhsl_to_lrgb"] = Conversions.nhsl_to_lrgb,
  ["hsl_to_xrgb"]  = Conversions.hsl_to_xrgb,
  ["xrgb_to_rgb"]  = Conversions.xrgb_to_rgb,
  ["xrgb_to_hsl"]  = Conversions.xrgb_to_hsl,
  ...
}
--]]

-- auto-create a mappings
local mappings = {};
for fn_nam, fn_ref in pairs (Conversions) do
  mappings [fn_nam] = fn_ref;
end
Conversions.Mappings = mappings;

--local dump = require ("scotopia.utils.obj_dump");
--dump (mappings);


-- TEST:

--local xrgb = Conversions.rgb_to_xrgb (255, 64, 32);
--print (xrgb);


return Conversions;
