local tweaks = require ("colorlib.tweaks")
local core = require ("colorlib.core");
local registry = require ("colorlib.registry");
local dump = require ("scotopia.utils.obj_dump");

local Variants = {};

local function vary_color (base_color, user_options)
  local ok, err = base_color:valid();
  if not ok then error (err) end;
  user_options = user_options or {};
  local options = {
    dark_shift = user_options.dark_shift or 0.18,
    light_shift = user_options.light_shift or 0.12,
    pale_shift = user_options.pale_shift or 0.28,
  };
  return {
    dark = tweaks.darken (base_color, options.dark_shift),
    base = base_color,
    light = tweaks.lighten (base_color, options.light_shift),
    pale = tweaks.lighten (base_color, options.pale_shift),
  }
end

Variants.generate = function (base_color_code, user_options)
  local color = core.create (registry.Profile.xRGB, { xrgb=base_color_code }, { bit_depth=8 });

  local color_palette, err = vary_color (color, user_options);
  if not color_palette then error (err) end;

  local raw_palette = {
    dark = color_palette.dark.channels.xrgb,
    base = color_palette.base.channels.xrgb,
    light = color_palette.light.channels.xrgb,
    pale = color_palette.pale.channels.xrgb,
  };

  return raw_palette;
end


-- TEST:

--[[
local c = core.create ("xrgb", { xrgb="#ff4020" }, { bit_depth=8 });
local dump = require ("scotopia.utils.obj_dump");
--dump (c);
local ok, err = c:valid();
if not ok then error (err) end;
--core.display (c);


local c2 = tweaks.darken (c, 0.18);
c2:display();
local c3 = tweaks.lighten (c, 0.10);
c3:display();
local c4 = tweaks.lighten (c, 0.90);
c4:display();


local v = variants.generate (c);
v.dark:display();
v.base:display();
v.light:display();
v.pale:display();
--]]

--local v = Variants.generate ("#ff4020");
--dump(v);


return Variants;
