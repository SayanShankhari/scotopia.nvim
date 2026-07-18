local math_utils = require ("scotopia.utils.math_utils");

--- @class ColorUtils
--- @field normalize_channel fun(channel:number,bit_depth?:integer):number
--- @field quantize_channel fun(channel:number,bit_depth?:integer):number
--- @field normalize_rgb fun(r:number,g:number,b:number,bit_depth:integer):number,number,number
--- @field quantize_rgb fun(r:number,g:number,b:number,bit_depth:number):number,number,number
--- @field compress_gamma_math fun(channel:number):number
--- @field compress_gamma_fast fun(bit_depth:number,channel:number):number
--- @field compress_gamma_approx fun(channel:number):number
--- @field expand_gamma fun(channel:number):number
local C = {};


-- Normalize channel to fixed range
--- @param channel number [0-255/1023/65535]
--- @param bit_depth number [8/10/16]
--- @return number standard_channel_value [0-1]
function C.normalize_channel (channel, bit_depth)
  -- short-circuit to set default value
  bit_depth = bit_depth or 8;
  -- calculate max possible value
  local max = 2 ^ bit_depth - 1;
  -- normalize color channels
  local c = channel / max;
  if c < 0 then c = 0 elseif c > 1 then c = 1 end;
  return c;
end

--- @param bit_depth number [8/10/16]
--- @param channel number [0-1]
--- @return number quantized_channel [0-255/1023/65535]
function C.quantize_channel (channel, bit_depth)
  -- short-circuit to set default value
  bit_depth = bit_depth or 8;
  -- core logic
  local max = 2 ^ bit_depth - 1;
  return math_utils.round (channel * max);
end

-- Normalize RGB channel to fixed range
--- @param red number [0-255/1023/65535]
--- @param green number [0-255/1023/65535]
--- @param blue number [0-255/1023/65535]
--- @param bit_depth number [8/10/16]
--- @return number standard_red [0-1]
--- @return number standard_green [0-1]
--- @return number standard_blue [0-1]
function C.normalize_rgb (red, green, blue, bit_depth)
  -- short-circuit to set default value
  bit_depth = bit_depth or 8;
  -- calculate max possible value
  local max = 2 ^ bit_depth - 1;
  -- normalize color channels
  local r = red / max;
  local g = green / max;
  local b = blue / max;

  return r, g, b;
end

-- Quantize (integer) RGB from standard RGB (fraction)
--- @param red number [0-255/1023/65535]
--- @param green number [0-255/1023/65535]
--- @param blue number [0-255/1023/65535]
--- @param bit_depth number [8/10/16]
--- @return number standard_red [0-1]
--- @return number standard_green [0-1]
--- @return number standard_blue [0-1]
function C.quantize_rgb (red, green, blue, bit_depth)
  -- short-circuit to set default value
  bit_depth = bit_depth or 8;
  -- calculate max possible value
  local max = 2 ^ bit_depth - 1;
  -- normalize color channels
  local r = math_utils.round (red * max);
  local g = math_utils.round (green * max);
  local b = math_utils.round (blue * max);

  return r, g, b;
end

-- apply/correct gamma curve on linear color value
--- @param channel number [0-1] normalized channel value
--- @return number perceived_non_linear_value
function C.compress_gamma_math (channel)
  if channel <= 0.0031308 then
    return channel * 12.92;
  else
    -- return 1.055 * (channel ^ (1 / 2.4)) - 0.055;
    -- pre-divided gamma exponent: (1 / 2.4) = 0.41666666666667
    return 1.055 * (channel ^ 0.41666666666667) - 0.055;
  end
end

-- pre calculated gamma lookup table
-- works only for integers
-- Gamma LookUp Table
local GLUT = {
  [8] = {},
  [10] = {},
  -- [16] = {}, -- avoid populating, consumes over 2MB of RAM
};
local function populate_GLUT ()
  local depths = { 8, 10 }; -- using 16 bit will consume lot of ram
  for _, depth in ipairs (depths) do
    local max = 2 ^ depth - 1;
    local lut = GLUT [depth]; -- refer blazing fast array
    lut [0] = 0; -- ∵ c = 0/max = 0 < 0.0031308; ∴ 12.92 * c = 0
    for i = 1, max, 1 do
      local c = i / max;
      if c <= 0.0031308 then
        lut [i] = 12.92 * c;
      else
        lut [i] = 1.055 * (c ^ 0.41666666666667) - 0.055;
      end
    end
  end
end

populate_GLUT();

-- apply (compress) Gamma curve from linear value
--- @param bit_depth number [8/10/16]
--- @param channel number [0-1]
--- @return number gamma_corrected_channel [0-1]
function C.compress_gamma_fast (bit_depth, channel)
  -- 1. Clamp input strictly to [0-1] to prevent floating-point overruns
  if channel < 0 then channel = 0 elseif channel > 1 then channel = 1 end
  -- 2. Execute pipeline based on bit depth
  if bit_depth == 8 or bit_depth == 10 then
    return GLUT [bit_depth][C.quantize_channel (bit_depth, channel)];
  elseif bit_depth == 16 then
    return C.compress_gamma_math (channel);
  else
    error ("Wrong bit_depth, provide only 8, 10 or 16");
  end
end

-- square root approximation curve, visually unnoticeable
--- @param channel number [0-1]
--- @return number gamma_corrected_channel [0-1]
C.compress_gamma_approx = function (channel)
  if channel <= 0.0031308 then
    return channel * 12.92;
  else
    -- uses approximated 2.4 root curve
    -- visually unnoticeable
    return 1.13005 * math.sqrt (channel) - 0.072945 * channel - 0.05711;
  end
end

-- revoke Gamma curve (non-linear) to get linear value
--- @param channel number [0-1] normalized channel value
--- @return number linear_value [0-1]
function C.expand_gamma (channel)
  -- 0.0031308 * 12.92 = 0.040449936 ≈ 0.04045
  if channel <= 0.04045 then
    return channel / 12.92;
  else
    return ((channel + 0.055) / 1.055) ^ 2.4;
  end
end


-- metatable/blueprint
C.MetaMethods = {
  normalize_channel = function (self, bit_depth)
    return C.normalize_channel (self._value, bit_depth);
  end,
  quantize_channel = function (self, bit_depth)
    return C.quantize_channel (self._value, bit_depth);
  end,
}

setmetatable (C, {
  __call = function (_, value)
    return setmetatable ({ _value = value }, C.MetaMethods);
  end
});


return C;
