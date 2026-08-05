local registry = require ("colorlib.registry");
local conversions = require ("colorlib.conversions");
local dump = require ("scotopia.utils.obj_dump");

local Core = {};
Core.__index = Core; -- fallback, if any key not found, checks in metatable

--[[
Core.conversionsLUT = {
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

local function in_limit (x, min, max)
  return x >= min and x <= max;
end

-- validation
Core.valid = function (self)
  if self.metadata.profile == nil then
    return false, "profile not found";
  elseif self.metadata.profile == registry.Profile.RGB then
    if not self.metadata.bit_depth then return false, "bit_depth not found" end;
    if self.metadata.bit_depth
      and (self.metadata.bit_depth ~= 8 and self.metadata.bit_depth ~= 10 and self.metadata.bit_depth ~= 16) then
      return false, "invalid bit_depth";
    end
    local max = 2 ^ self.metadata.bit_depth - 1;
    return (type (self.channels.r) == "number" and in_limit (self.channels.r, 0, max) and self.channels.r % 1 == 0)
      and (type (self.channels.g) == "number" and in_limit (self.channels.r, 0, max) and self.channels.g % 1 == 0)
      and (type (self.channels.b) == "number" and in_limit (self.channels.r, 0, max) and self.channels.b % 1 == 0);
  elseif self.metadata.profile == registry.Profile.lRGB then
    return (type (self.channels.lr) == "number" and in_limit (self.channels.lr, 0, 1))
      and (type (self.channels.lg) == "number" and in_limit (self.channels.lr, 0, 1))
      and (type (self.channels.lb) == "number" and in_limit (self.channels.lr, 0, 1));
  elseif self.metadata.profile == registry.Profile.sRGB then
    return (type (self.channels.sr) == "number" and in_limit (self.channels.sr, 0, 1))
      and (type (self.channels.sg) == "number" and in_limit (self.channels.sr, 0, 1))
      and (type (self.channels.sb) == "number" and in_limit (self.channels.sr, 0, 1));
  elseif self.metadata.profile == registry.Profile.xRGB then
    local xrgb = (type (self.channels.xrgb) == "string" and self.channels.xrgb:gsub ("#", "") or ""):lower(); -- beware, DO NOT directly use lower on dual returning gsub
    if #xrgb ~= 6 and #xrgb ~= 9 and #xrgb ~= 12 then
      return false, "invalid code length";
    end
    if string.find (xrgb, "[^0-9a-f]") then
      return false, "invalid character found";
    end
    return true;
  elseif self.metadata.profile == registry.Profile.HSL then
    return (type (self.channels.h) == "number" and in_limit (self.channels.h, 0, 360))
      and (type (self.channels.s) == "number" and in_limit (self.channels.s, 0, 100))
      and (type (self.channels.l) == "number" and in_limit (self.channels.l, 0, 100));
  elseif self.metadata.profile == registry.Profile.HSV then
    return (type (self.channels.h) == "number" and in_limit (self.channels.h, 0, 360))
      and (type (self.channels.s) == "number" and in_limit (self.channels.s, 0, 100))
      and (type (self.v) == "number" and in_limit (self.v, 0, 100));
  elseif self.metadata.profile == registry.Profile.HSI then
    return (type (self.channels.h) == "number" and in_limit (self.channels.h, 0, 360))
      and (type (self.channels.s) == "number" and in_limit (self.channels.s, 0, 100))
      and (type (self.channels.i) == "number" and in_limit (self.channels.i, 0, 100));
  elseif self.metadata.profile == registry.Profile.nHSL then
    return (type (self.channels.nh) == "number" and in_limit (self.channels.nh, 0, 360))
      and (type (self.channels.ns) == "number" and in_limit (self.channels.ns, 0, 1))
      and (type (self.channels.nl) == "number" and in_limit (self.channels.nl, 0, 1));
  elseif self.metadata.profile == registry.Profile.nHSV then
    return (type (self.channels.nh) == "number" and in_limit (self.channels.nh, 0, 360))
      and (type (self.channels.ns) == "number" and in_limit (self.channels.ns, 0, 1))
      and (type (self.channels.nv) == "number" and in_limit (self.channels.nv, 0, 1));
  elseif self.metadata.profile == registry.Profile.nHSI then
    return (type (self.channels.nh) == "number" and in_limit (self.channels.nh, 0, 360))
      and (type (self.channels.ns) == "number" and in_limit (self.channels.ns, 0, 1))
      and (type (self.channels.ni) == "number" and in_limit (self.channels.ni, 0, 1));
  end
end

function Core.unwind (channel_sequence, object)
  local ordered_values = {};
  for i, channel in ipairs (channel_sequence) do
    ordered_values [i] = object [channel];
  end
  -- fix moved unpack in new lua version
  table.unpack = table.unpack or unpack;
  return table.unpack (ordered_values);
end

function Core.wind (channel_sequence, ...)
  local dictionary = {};
  -- fix missing pack in old lua version
  table.pack = table.pack or function(...) return { n = select("#", ...), ... } end;
  local input_values = table.pack (...);
  for i, channel in ipairs (channel_sequence) do
    dictionary [channel] = input_values [i];
  end
  return dictionary;
end

function Core:display()
  local ok, err = self:valid();
  if not ok then error (err) end;
  if self.metadata.profile == registry.Profile.RGB then
    print (string.format ("RGB: R=%d, G=%d, B=%d", self.channels.r, self.channels.g, self.channels.b));
  elseif self.metadata.profile == registry.Profile.sRGB then
    print (string.format ("sRGB: sR=%f, sG=%f, sB=%f", self.channels.sr, self.channels.sg, self.channels.sb));
  elseif self.metadata.profile == registry.Profile.lRGB then
    print (string.format ("lRGB: lR=%f, lG=%f, lB=%f", self.channels.lr, self.channels.lg, self.channels.lb));
  elseif self.metadata.profile == registry.Profile.xRGB then
    print (string.format ("xRGB: %s", self.channels.xrgb));
  elseif self.metadata.profile == registry.Profile.HSL then
    print (string.format ("HSL: H=%f, S=%f, L=%f", self.channels.h, self.channels.s, self.channels.l));
  elseif self.metadata.profile == registry.Profile.HSV then
    print (string.format ("HSV: H=%f, S=%f, V=%f", self.channels.h, self.channels.s, self.channels.v));
  elseif self.metadata.profile == registry.Profile.HSI then
    print (string.format ("HSI: H=%f, S=%f, I=%f", self.channels.h, self.channels.s, self.channels.i));
  elseif self.metadata.profile == registry.Profile.nHSL then
    print (string.format ("nHSL: nH=%f, nS=%f, nL=%f", self.channels.nh, self.channels.ns, self.channels.nl));
  elseif self.metadata.profile == registry.Profile.nHSV then
    print (string.format ("nHSV: nH=%f, nS=%f, nV=%f", self.channels.nh, self.channels.ns, self.channels.nv));
  elseif self.metadata.profile == registry.Profile.nHSI then
    print (string.format ("nHSI: nH=%f, nS=%f, nI=%f", self.channels.nh, self.channels.ns, self.channels.ni));
  end
end

-- constructor
Core.create = function (profile, channels, metadata)
  local core = setmetatable ({}, Core); -- attach all the attributes and functions
  core.metadata = metadata or {}; -- example: for RGB family { bit_depth = 8 }
  core.metadata.profile = profile; -- seed profile inside info
  core.channels = channels or {};
  return core;
end

-- TEST:

--[[
local c = Core.create (registry.Profile.RGB, { r=255, g=64, b=32 }, { bit_depth=8 });
dump (c, "table");
dump (getmetatable(c), "metatable");
c:display();
--]]

--[[
local ok, err = Core.valid (c);
if ok then print ("OK") else print ("ERR:", err) end;
c = Core.create (registry.Profile.xRGB, { xrgb="#ff8033" }, { bit_depth=8 });
dump (c);
ok, err = Core.valid (c);
if ok then print ("OK") else print ("ERR:", err) end;
--]]


return Core;
