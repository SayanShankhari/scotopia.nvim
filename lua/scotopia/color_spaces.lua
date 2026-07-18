local utils = require ("scotopia.utils");

-- declarations
--- @class ColorSpaces
--- @field rgb { red: number, green: number, blue: number }
--- @field lrgb { lr: number, lg: number, lb: number }
--- @field srgb { sr: number, sg: number, sb: number }
--- @field hsl { h: number, s: number, l: number }
--- @field hsv { h: number, s: number, v: number }
--- @field hsi { h: number, s: number, i: number }
--- @field cmyk { c: number, m: number, y: number, k: number }
-- functions
--- @field rgb_to_lrgb fun (bit_depth: integer, red: integer, green: integer, blue: integer): number, number, number
--- @field rgb_to_srgb fun (bit_depth: integer, red: integer, green: integer, blue: integer): number, number, number
--- @field lrgb_to_srgb fun (lr: number, lg: number, lb: number): number, number, number
--- @field srgb_to_lrgb fun (sr: number, sg: number, sb: number): number, number, number
--- @field srgb_to_rgb fun (bit_depth: integer, sr: number, sg: number, sb: number): integer, integer, integer
--- @field rgb_to_xrgb fun (r: integer, g: integer, b: integer, bit_depth?: integer): string
--- @field xrgb_to_rgb fun (xrgb: string, bit_depth?: integer): integer, integer, integer
--- @field srgb_to_hsl fun (sr: number, sg: number, sb: number): number, number, number
--- @field hsl_to_srgb fun (h: number, s: number, l: number): number, number, number
--- @field hsl_to_xrgb fun (r: number, g: number, b: number, bit_depth?: integer): string
local C = {
  rgb = { bit_depth = 8, red = 0, green = 0, blue = 0 }
  , lrgb = { lr = 0, lg = 0, lb = 0 }
  , srgb = { sr = 0, sg = 0, sb = 0 }
  , hsl = { h = 0, s = 0, l = 0 }
  , hsv = { h = 0, s = 0, v = 0 }
  , hsi = { h = 0, s = 0, i = 0 }
  , cmyk = { c = 0, m = 0, y = 0, k = 0 }
}

-- RGB (Red-Green-Blue) to sRGB (standard Red-Green-Blue)
--- @param bit_depth integer [8/10/16]
--- @param red integer [0-255/1023/65565]
--- @param green integer [0-255/1023/65565]
--- @param blue integer [0-255/1023/65565]
--- @return number sr [0-1]
--- @return number sg [0-1]
--- @return number sb [0-1]
function C.rgb_to_srgb (bit_depth, red, green, blue)
  local sr = utils.normalize_channel (bit_depth, red);
  local sg = utils.normalize_channel (bit_depth, green);
  local sb = utils.normalize_channel (bit_depth, blue);

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
function C.lrgb_to_srgb (lr, lg, lb)
  local sr = utils.compress_gamma_math (lr);
  local sg = utils.compress_gamma_math (lg);
  local sb = utils.compress_gamma_math (lb);

  return sr, sg, sb;
end

-- lRGB (linear Red-Green-Blue) to sRGB (standard Red-Green-Blue)
-- linear-RGB to standard-RGB (gamma corrected)
-- real intensity to eye perceived value
--- @param bit_depth 8/10/16
--- @param lr number [0-1]
--- @param lg number [0-1]
--- @param lb number [0-1]
--- @return number sr [0-1]
--- @return number sg [0-1]
--- @return number sb [0-1]
function C.lrgb_to_srgb_LUT (bit_depth, lr, lg, lb)
  local sr = utils.compress_gamma_fast (bit_depth, lr);
  local sg = utils.compress_gamma_fast (bit_depth, lg);
  local sb = utils.compress_gamma_fast (bit_depth, lb);

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
function C.lrgb_to_srgb_approx (lr, lg, lb)
  local sr = utils.compress_gamma_approx (lr);
  local sg = utils.compress_gamma_approx (lg);
  local sb = utils.compress_gamma_approx (lb);

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
function C.srgb_to_lrgb (sr, sg, sb)
  local lr = utils.expand_gamma (sr);
  local lg = utils.expand_gamma (sg);
  local lb = utils.expand_gamma (sb);

  return lr, lg, lb;
end

function C.srgb_to_rgb (sr, sg, sb, bit_depth)
  -- calcualte maximum possible value
  local max = 2 ^ bit_depth - 1;
  -- quantize the channels
  local r = utils.round (max * sr);
  local g = utils.round (max * sg);
  local b = utils.round (max * sb);
  -- return the values
  return r, g, b;
end

-- RGB to hex RGB
--- @param bit_depth integer 8/10/16
--- @param r number [0-255/1023/65535]
--- @param g number [0-255/1023/65535]
--- @param b number [0-255/1023/65535]
--- @return string xrgb #rrggbb/#rrrgggbbb/#rrrrggggbbbb
function C.rgb_to_xrgb (r, g, b, bit_depth)
  bit_depth = bit_depth or 8;

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

  return xrgb;
end

-- normalize HSL (Hue-Saturation-Lightness)
--- @param hue number [0-360)
--- @param saturation number [0-100]
--- @param lightness number [0-100]
--- @return number nh [0-360)
--- @return number ns [0-1]
--- @return number nl [0-1]
function C.hsl_to_nhsl (hue, saturation, lightness)
  -- filter inputs
  -- lua addresses negative numbers
  hue = (hue % 360);
  saturation = utils.clamp (saturation, 0, 100);
  lightness = utils.clamp (lightness, 0, 100);

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
function C.nhsl_to_hsl (nh, ns, nl)
  -- filter inputs
  nh = utils.clamp (nh, 0, 360);
  ns = utils.clamp (ns, 0, 1);
  nl = utils.clamp (nl, 0, 1);

  -- calculate refined values
  local hue = utils.round (nh % 360);
  local saturation = utils.round (100 * ns);
  local lightness = utils.round (100 * nl);

  return hue, saturation, lightness;
end

-- denormalize nHSL (normalized Hue-Saturation-Lightness)
--- @param lr number [0-1]
--- @param lg number [0-1]
--- @param lb number [0-1]
--- @return number nh [0-360)
--- @return number ns [0-100]
--- @return number nl [0-100]
function C.lrgb_to_nhsl (lr, lg, lb)
  -- refine inputs
  -- clamp to reduce accidental 1.0000000000000002 or -0.3
  lr = utils.clamp (lr, 0, 1);
  lg = utils.clamp (lg, 0, 1);
  lb = utils.clamp (lb, 0, 1);

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
  local ns = utils.clamp (saturation, 0, 1);
  local nl = utils.clamp (lightness, 0, 1);

  return nh, ns, nl;
end

-- nHSL (normalize Hue-Saturation-Lightness) to lRGB (linear Red-Green-Blue)
--- @param nh number [0-360)
--- @param ns number [0-1]
--- @param nl number [0-1]
--- @return number lr [0-1]
--- @return number lg [0-1]
--- @return number lb [0-1]
function C.nhsl_to_lrgb (nh, ns, nl)
  -- refine inputs
  local hue = nh;
  local saturation = utils.clamp (ns, 0, 1);
  local lightness = utils.clamp (nl, 0, 1);

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
  lr = utils.clamp (lr, 0, 1);
  lg = utils.clamp (lg, 0, 1);
  lb = utils.clamp (lb, 0, 1);

  return lr, lg, lb;
end

function C.hsl_to_xrgb (h, s, l)
  local nh, ns, nl = C.hsl_to_nhsl (h, s, l);
  local lr, lg, lb = C.nhsl_to_lrgb (nh, ns, nl);
  local sr, sg, sb = C.lrgb_to_srgb (lr, lg, lb);
  local r, g, b = utils.quantize_rgb (sr, sg, sb);
  local xrgb = C.rgb_to_xrgb (r, g, b);

  return "#" .. xrgb;
end

function C.xrgb_to_rgb (xrgb, bit_depth)
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
    error (string.format ("Error! @color_space.xrgb_to_rgb => Invalid string length, should be %d!", expected_length));
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
  local r = utils.hex_to_int (xrgb:sub (start_index, end_index), bit_depth);
  start_index = end_index + 1;
  end_index = start_index + channel_length - 1;
  local g = utils.hex_to_int (xrgb:sub (start_index, end_index), bit_depth);
  start_index = end_index + 1;
  end_index = start_index + channel_length - 1;
  local b = utils.hex_to_int (xrgb:sub (start_index, end_index), bit_depth);

  return r, g, b;
end

function C.xrgb_to_hsl (xrgb)
  local r, g, b = C.xrgb_to_rgb (xrgb);
  local sr, sg, sb = utils.normalize_rgb (r, g, b);
  local lr, lg, lb = C.srgb_to_lrgb (sr, sg, sb);
  local nh, ns, nl = C.lrgb_to_nhsl (lr, lg, lb);
  local h, s, l = C.nhsl_to_hsl (nh, ns, nl);

  return math.floor(h), math.floor(s), math.floor(l);
end

print (string.format("xRGB(%s)", C.hsl_to_xrgb (30, 100, 50)));
print (string.format ("HSL(%d°,%d%%,%d%%)", C.xrgb_to_hsl ("#ffbc00")));


return C;
