local dump = require ("scotopia.utils.obj_dump");
--local analysis = require ("colorlib.analysis");
--local composting = require ("colorlib.composting");
local conversions = require ("colorlib.conversions");
local core = require ("colorlib.core");
--local lerps = require ("colorlib.lerps");
--local mathx = require ("colorlib.mathx");
local registry = require ("colorlib.registry");
--local tweaks = require ("colorlib.tweaks");
--local xforms = require ("colorlib.xforms");
local inherit = require ("colorlib.inherit");
local variants = require ("colorlib.variants");

--dump(registry);

--[[
local Color = {};
-- make Color inherit from Core
-- if a key isn't found in Color, search in Core
setmetatable (Color, { __index = core });
Color.__index = Color; -- fallback, if any key not found, checks in own metatable
--]]

local Color = inherit ({}, core); -- Color now has all of Core's functions

--[[
Color.conversionsLUT = {
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


-- TODO: automate validations

--[[
Color.valid = function (self)
  if self.profile == nil then
    return false;
  elseif self.profile == self.Profile.RGB then
    if self.values.bit_depth
      and (self.values.bit_depth ~= 8 or self.values.bit_depth ~= 10 or self.values.bit_depth ~= 16) then
      return false;
    end
    local max = 2 ^ self.values.bit_depth - 1;
    return (type (self.values.r) == "number" and in_limit (self.values.r, 0, max) and self.values.r % 1 == 0)
      and (type (self.values.g) == "number" and in_limit (self.values.r, 0, max) and self.values.g % 1 == 0)
      and (type (self.values.b) == "number" and in_limit (self.values.r, 0, max) and self.values.b % 1 == 0);
  elseif self.profile == self.Profile.lRGB then
    return (type (self.values.lr) == "number" and in_limit (self.values.lr, 0, 1))
      and (type (self.values.lg) == "number" and in_limit (self.values.lr, 0, 1))
      and (type (self.values.lb) == "number" and in_limit (self.values.lr, 0, 1));
  elseif self.profile == self.Profile.sRGB then
    return (type (self.values.sr) == "number" and in_limit (self.values.sr, 0, 1))
      and (type (self.values.sg) == "number" and in_limit (self.values.sr, 0, 1))
      and (type (self.values.sb) == "number" and in_limit (self.values.sr, 0, 1));
  elseif self.profile == self.Profile.xRGB then
    if type (self.values.xrgb) ~= "string" then return false, "not a string" end;
    local xrgb, _ = self.values.xrgb:gsub ("#", ""); -- beware, DO NOT directly use lower on dual returning gsub, 2nd unnamed return is count
    xrgb = xrgb:lower();
    if #xrgb ~= 6 and #xrgb ~= 9 and #xrgb ~= 12 then
      return false, "invalid length";
    end
    if string.find (xrgb, "[^0-9a-f]") then
      return false, "invalid characters";
    end
    return true;
  elseif self.profile == self.Profile.HSL then
    return (type (self.values.h) == "number" and in_limit (self.values.h, 0, 360))
      and (type (self.values.s) == "number" and in_limit (self.values.s, 0, 100))
      and (type (self.values.l) == "number" and in_limit (self.values.l, 0, 100));
  elseif self.profile == self.Profile.HSV then
    return (type (self.values.h) == "number" and in_limit (self.values.h, 0, 360))
      and (type (self.values.s) == "number" and in_limit (self.values.s, 0, 100))
      and (type (self.v) == "number" and in_limit (self.v, 0, 100));
  elseif self.profile == self.Profile.HSI then
    return (type (self.values.h) == "number" and in_limit (self.values.h, 0, 360))
      and (type (self.values.s) == "number" and in_limit (self.values.s, 0, 100))
      and (type (self.values.i) == "number" and in_limit (self.values.i, 0, 100));
  elseif self.profile == self.Profile.nHSL then
    return (type (self.values.nh) == "number" and in_limit (self.values.nh, 0, 360))
      and (type (self.values.ns) == "number" and in_limit (self.values.ns, 0, 1))
      and (type (self.values.nl) == "number" and in_limit (self.values.nl, 0, 1));
  elseif self.profile == self.Profile.nHSV then
    return (type (self.values.nh) == "number" and in_limit (self.values.nh, 0, 360))
      and (type (self.values.ns) == "number" and in_limit (self.values.ns, 0, 1))
      and (type (self.values.nv) == "number" and in_limit (self.values.nv, 0, 1));
  elseif self.profile == self.Profile.nHSI then
    return (type (self.values.nh) == "number" and in_limit (self.values.nh, 0, 360))
      and (type (self.values.ns) == "number" and in_limit (self.values.ns, 0, 1))
      and (type (self.values.ni) == "number" and in_limit (self.values.ni, 0, 1));
  end
end
--]]
--[[
  { from = Color.Profile.xRGB, to = Color.Profile.HSL, func = conversions.xrgb_to_hsl },
  { from = "hsl", to = "xrgb", func = conversions.hsl_to_xrgb }

-- Fast index lookup cache created from your LUT
local FastCache = {}
for _, entry in ipairs (Color.conversionLUT) do
  local key = entry.from .. "_" .. entry.to;
  FastCache [key] = entry.func;
end
--]]

Color.convert_to = function (self, new_profile)
  if not self:valid() then
    error ("Invalid Color object input!");
  end
  if self.profile == new_profile then return self end;

  local fn_name = self.metadata.profile .. "_to_" .. new_profile;
  local fn = conversions.Mappings [fn_name]; -- dispatcher function
  if not fn then error ("required funtion not found") end;

  local values = core.wind (registry.Channels [new_profile], fn (core.unwind (registry.Channels [self.metadata.profile], self.channels)));
  local new_color = Color.create (new_profile, values);
  return new_color;
end

--Color.valid = core.valid;
--Color.display = core.display;

--[[
Color.display = function (self)
--  local ok, err = self:valid();
--  if not ok then print (err) end;
  if not self:valid() then error ("invalid color data!") end;
  if self.profile == Color.Profile.RGB then
    print (string.format ("Color [RGB]: R=%d, G=%d, B=%d", self.values.r, self.values.g, self.values.b));
  elseif self.profile == Color.Profile.lRGB then
    print (string.format ("Color [lRGB]: R=%f, G=%f, B=%f", self.values.lr, self.values.lg, self.values.lb));
  elseif self.profile == Color.Profile.sRGB then
    print (string.format ("Color [sRGB]: R=%f, G=%f, B=%f", self.values.sr, self.values.sg, self.values.sb));
  elseif self.profile == Color.Profile.xRGB then
    print (string.format ("Color [xRGB]: %s", self.values.xrgb));
  elseif self.profile == Color.Profile.HSL then
    print (string.format ("Color [HSL]: H=%f, S=%f, L=%f", self.values.h, self.values.s, self.values.l));
  elseif self.profile == Color.Profile.nHSL then
    print (string.format ("Color [nHSL]: H=%f, S=%f, L=%f", self.values.nh, self.values.ns, self.values.nl));
  end
end
--]]

-- import API functions
Color.generate_variants = variants.generate;
Color.hsl_to_xrgb = conversions.hsl_to_xrgb;

-- constructor
--Color.create = core.create;
Color.create = function (profile, channels)
  local self = core.create (profile, channels);
  return setmetatable (self, Color); -- flat 1-level metatable
end

-- TEST:

--print (string.format("xRGB(%s)", C.hsl_to_xrgb (30, 100, 50)));
--print (string.format ("HSL(%d°,%d%%,%d%%)", C.xrgb_to_hsl ("#ffbc00")));

-- Color.Profile.HSL is evaluated to "hsl"
--local c1 = Color.create ("hsl", { h=120, s=50, l=50 });
--dump (c1, "color");
--dump (getmetatable(c1), "color metatable");
--local ok, err = core.valid (c1);
--if ok then print ("OK") else print (err) end;
--c1:display();

--local c2 = c1:convert_to (Color.Profile.xRGB);
--obj_dump (color2);
--if not c2 then error("unable to convert") end;
--c2:display();


return Color;
