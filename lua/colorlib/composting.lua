-- =========================================================
-- 3. COMPOSITING, BLENDING & GRADIENTS
-- =========================================================

local mathx = require ("colorlib.mathx");
local conversions = require ("colorlib.conversions");
local registry = require ("colorlib.registry");
local core = require ("colorlib.core");
local lerps = require ("colorlib.lerps");
--local dump = require ("scotopia.utils.obj_dump");


local Compostings = {};

-- interpolate two colors in a specific color space
--- Generically mixes two colors based on a factor t and a target color space.
--- @param color_1 table {r, g, b} normalized between 0 and 1
--- @param color_2 table {r, g, b} normalized between 0 and 1
--- @param t number Interpolation factor clamped between 0 and 1 (0 = color_1, 1 = color_2)
--- @param output_profile string "rgb", "hsl", or "hsv" (defaults to "rgb")
--- @return table {r, g, b} Mixed color output normalized between 0 and 1
function Compostings.mix_colors (color_1, color_2, t, output_profile)
  local ok, err = color_1:valid();
  if not ok then error (err) end;

  ok, err = color_2:valid();
  if not ok then error (err) end;

  -- Ensure t (time/steps/weight) is safely bounded
  if not t then t = 0.5 end;
  t = mathx.clamp (t, 0, 1);

  output_profile = string.lower (output_profile or "xrgb")

  local c1, c2;

  -- convert to lRGB if alredy not
  if color_1.metadata.profile ~= registry.Profile.lRGB then
    local fn_name = color_1.metadata.profile .. "_to_lrgb";
    local fn = conversions.Mappings [fn_name];
    if not fn then error ("conversion not possible/available") end;
    c1 = core.wind (registry.Channels [registry.Profile.lRGB], fn (core.unwind (registry.Channels [color_1.metadata.profile], color_1.channels)));
  end;
  if color_2.metadata.profile ~= registry.Profile.lRGB then
    local fn_name = color_2.metadata.profile .. "_to_lrgb";
    local fn = conversions.Mappings [fn_name];
    if not fn then error ("conversion not possible/available") end;
    c2 = core.wind (registry.Channels [registry.Profile.lRGB], fn (core.unwind (registry.Channels [color_2.metadata.profile], color_2.channels)));
  end;

  --dump (c1, "lRGB color_1");
  --dump (c2, "lRGB color_2");

  local c = { lr=0, lg=0, lb=0 }

  -- calculate on linear normal space
  c.lr = lerps.lerp (c1.lr, c2.lr, t);
  c.lg = lerps.lerp (c1.lg, c2.lg, t);
  c.lb = lerps.lerp (c1.lb, c2.lb, t);

  --dump (c, "Result");
--[[
  local sr, sg, sb = conversions.lrgb_to_srgb (c.lr, c.lg, c.lb);
  print (sr, sg, sb);
  local r, g, b = conversions.srgb_to_rgb (sr, sg, sb);
  print (r, g, b);
  local xrgb = conversions.rgb_to_xrgb (r, g, b);
  print (xrgb);
--]]
  local fn_name = registry.Profile.lRGB .. "_to_xrgb";
  local fn = conversions.Mappings [fn_name];
  if not fn then error ("conversion not possible/available") end;
  local x = core.wind (registry.Channels [registry.Profile.xRGB], fn (core.unwind (registry.Channels [registry.Profile.lRGB], c)));
  --dump (x, "Final");

  local color = core.create (registry.Profile.xRGB, x, { bit_depth=8 });
--[[
  if #profile <= 4 and string.find (profile, "rgb", 1, true) then -- RECTANGULAR
    local lr1, lg1, lb1;
    local lr2, lg2, lb2;

    if profile == "lrgb" then
      lr1, lg1, lb1 = color_1.lr, color_1.lg, color_1.lb;
      lr2, lg2, lb2 = color_2.lr, color_2.lg, color_2.lb;
    elseif profile == "srgb" then
      lr1, lg1, lb1 = conversions.srgb_to_lrgb (color_1.sr, color_1.sg, color_1.sb);
      lr2, lg2, lb2 = conversions.srgb_to_lrgb (color_2.sr, color_2.sg, color_2.sb);
    elseif profile == "rgb" then
      lr1, lg1, lb1 = conversions.rgb_to_lrgb (color_1.bit_depth, color_1.r, color_1.g, color_1.b);
      lr2, lg2, lb2 = conversions.rgb_to_lrgb (color_1.bit_depth, color_2.r, color_2.g, color_2.b);
    else
      error ("Error: mix_colors => Unknown color-space!");
    end

    -- calculate on linear normal space
    local lr = Compostings.lerp (lr1, lr2, t);
    local lg = Compostings.lerp (lg1, lg2, t);
    local lb = Compostings.lerp (lb1, lb2, t);

    -- convert back to original
    if profile == "lrgb" then
      return { lr = lr, lg = lg, lb = lb };
    elseif profile == "srgb" then
      local sr, sg, sb = conversions.lrgb_to_srgb (lr, lg, lb);
      return { sr = sr, sg = sg, sb = sb };
    elseif profile == "rgb" then
      local r, g, b = conversions.lrgb_to_rgb (lr, lg, lb, 8);
      return { r = r, g = g, b = b };
    end
  elseif #profile == 3 and string.find (profile, "hs", 1, true) then -- CYLINDRICAL
    local nh1, ns1, nl1, ni1, nv1;
    local nh2, ns2, nl2, ni2, nv2;

    -- calculate
    local nh = Compostings.lerp_angle (nh1, nh2, t);
    local ns = Compostings.lerp (ns1, ns2, t);

    if profile == "hsl" then
      local nl = Compostings.lerp (nl1, nl2, t);
      local h, s, l = conversions.nhsl_to_hsl (nh, ns, nl);
      return { h = h, s = s, l = l };
    elseif profile == "hsi" then
      local ni = Compostings.lerp (ni1, ni2, t);
      --local h, s, l = C.nhsi_to_hsi (nh, ns, ni);
      --return { h = h, s = s, i = i };
    elseif profile == "hsv" then
      local nv = Compostings.lerp (nv1, nv2, t);
      --local h, s, v = C.nhsv_to_hsv (nh, ns, nv);
      --return { h = h, s = s, v = v };
    end
  else
    error ("Unsupported color space: " .. tostring(profile));
    return {};
  end
--]]

  return color;
end

Compostings.blend = function (foreground, background, alpha)
  -- Porter-Duff Alpha Compositing over background
  alpha = mathx.clamp (alpha, 0, 1);
  return mathx.round (foreground * alpha + background * (1 - alpha));
end

Compostings.gradient = function (color_1, color_2, steps)
  local G = {};
  for i = 2, steps do
    G[i] = Compostings.mix_colors (color_1, color_2, i / (steps - 1), color_1);
  end
  return G;
--[[
-- ALTERNATIVE
local result = {}
    if steps <= 1 then
        table.insert(result, color_1)
        return result
    end

    for i = 0, steps - 1 do
        local t = i / (steps - 1)
        local blended_vals = ops.mix_colors(color_1, color_2, t, color_1.profile)
        table.insert(result, blended_vals)
    end

    return result
--]]
end


-- TEST:

--[[
local c1 = core.create (registry.Profile.xRGB, { xrgb="#ff4020" }, { bit_depth=8 })
c1:display();
local c2 = core.create (registry.Profile.xRGB, { xrgb="#FFFF00" });
c2:display();
local c3 = Compostings.mix_colors (c1, c2, 1, registry.Profile.xRGB);
c3:display();
--]]


return Compostings;
