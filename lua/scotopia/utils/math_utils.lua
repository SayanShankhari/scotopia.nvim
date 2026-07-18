--- @class MathUtils
--- @field atan2 fun(y:number,x:number):number 2 parameter missing arc-tangent math function
--- @field round fun(num:number,decimal_places?:number):number
--- @field cube_root fun(x:number):number
--- @field clamp fun(value:number,minimum:number,maximum:number):number
--- @field int_to_hex fun(n:number,bit_depth:number):string
--- @field hex_to_int fun(h:string,bit_depth:number):number
local M = {};

-- Alternative to atan(y/x), which loose coordinates information during division
--- @param y number
--- @param x number
--- @return number
function M.atan2 (y, x)
  -- 1. handle edge cases where x is zero (vertical lines)
  if x == 0 then
    if y > 0 then return math.pi / 2 end;
    if y < 0 then return -math.pi / 2 end;
    return 0; -- x and y are both 0
  end
  -- 2. calculate the base arc tangent using the single-argument version
  local angle = math.atan (y / x);
  -- 3. adjust the angle based on the quadrant (signs of x and y)
  if x < 0 then
    if y >= 0 then
      return angle + math.pi;  -- quadrant II (-,+)
    else
      return angle - math.pi;  -- quadrant III (-,-)
    end
  end

  return angle;  -- quadrant I (+,+) and IV (+,-)
end

-- Round up the fractions to desired length
--- @param num number
--- @param decimal_places? integer [0-11]
--- @return number
function M.round (num, decimal_places)
  -- 1. handle non-number input gracefully
  if type (num) ~= "number" or (decimal_places and type (decimal_places) ~= "number") then
    error("ERROR @\"math_util.round\": One or more inputs is not a number!")
  end
  if type (num) ~= "number" then
    error ("ERROR @\"math_util.round\": One or more input is not a number!");
  end
  -- 2. Format decimal places
  -- already integer?
  decimal_places = math.max (0, math.floor (decimal_places or 0));
  if decimal_places == 0 and num % 1 == 0 then return num end;
  -- mitigate floating-point inaccuracies (e.g., 0.1 + 0.2 != 0.3)
  -- add microscopic epsilon to prevent truncing
  -- 3. Standardize floating-point precision handling
  local mult = 10 ^ decimal_places;
  local epsilon = 1e-14; -- smol (0.00000000000001), IEEE uses 15-17 digits total
  -- Edge Case 4 & 5: Symmetric Rounding (Handling Negative Numbers Correctly)
  -- avoid breaking on negative numbers (-1.5 + 0.5 = -1, which rounds UP)
  -- 4. Symmetric Rounding (Corrected negative handling)
  if num >= 0 then
    return math.floor (num * mult + 0.5 + epsilon) / mult;
  else
    -- Adding epsilon shifts negative numbers closer to zero to counteract truncation
    return math.ceil (num * mult - 0.5 + epsilon) / mult;
  end
end

-- Alternative faster cube-root implementation
--- @param x number
--- @return number
function M.cube_root (x)
  -- get |x|
  local abs_x = math.abs (x);
  -- pre-calculate power 1/3 = 0.3333333333333333
  local root = abs_x ^ 0.3333333333333333;
  -- return signed computed value, ternary operation immitation
  return root * (x < 0 and -1 or 1);
end

-- Clamp the numbers to a fix range. specially very close to threshold maximum or minimum
-- avoid tiny calculation error handles tiny overflow and underflow
--- @param value number
--- @param minimum number
--- @param maximum number
--- @return number
function M.clamp (value, minimum, maximum)
  return math.max (minimum, math.min (maximum, value));
end

-- fixed range integer (decimal) to hexadecimal
--- @param bit_depth integer [8/10/16]
--- @param n number [0-255]
--- @return string ["00"-"ff"]
function M.int_to_hex (n, bit_depth)
  bit_depth = bit_depth or 8;

  if bit_depth ~= 8 and bit_depth ~= 10 and bit_depth ~= 16 then
    error ("ERROR @\"math_util.int_to_hex\": Unknown bit-depth! only 8, 10 or 16 accepted!");
  end

  local max = (2 ^ bit_depth) - 1;

  if n < 0 or n > max then
    error (string.format ("Number our of [0-%d] range!", max));
  end

  if type (n) ~= "number" or n % 1 ~= 0 then
    error ("Input error: must be an Integer (whole number)!");
  end

  return string.format ("%02x", n);
end

-- fixed range hexadecimal to integer (decimal)
--- @param h string ["00"-"ff"]
--- @param bit_depth integer [8/10/16]
--- @return number [0-255/1023/65535]
function M.hex_to_int (h, bit_depth)
  bit_depth = bit_depth or 8;

  if bit_depth ~= 8 and bit_depth ~= 10 and bit_depth ~= 16 then
    error ("ERROR! @\"math_utils.hex_to_int\": bit depth out of bound!");
  end

  local n = tonumber (h, 16);

  if not n then
    error ("Invalid hex byte!");
  end

  local max = 2 ^ bit_depth - 1;
  if n < 0 or n > max then
    error (string.format ("Out of [0-%d] range!", max));
  end

  return n;
end


-- metatable/blueprint
M.MetaMethods = {
  -- override clamp accepting "dot with self" or "colon" format
  clamp = function (self, minimum, maximum)
    local mt = getmetatable (self); -- set to caller master table
    return setmetatable ( { _value = M.clamp (self._value, minimum, maximum), mt } );
  end,
  -- override tostring
  __tostring = function (self)
    return tostring (self._value);
  end
}


return M;
