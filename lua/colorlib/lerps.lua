-- =========================================================
-- 2. LINEAR INTERPOLATION & MATH HELPERS
-- =========================================================

local mathx = require ("colorlib.mathx");

local L = {};


-- Not color-specific
-- find a smooth, proportional value between two points, A and B
-- linearly interpolate between two numbers
L.lerp = function (a, b, t)
  t = t or 0.5; -- in case t (time/step/weight/factor) not provided
  t = mathx.clamp (t, 0, 1); -- in case t gets out of range
  return a * (1 - t) + b * t; -- weight direction is from a to b
end

-- lerp with angular color channel
L.lerp_angle = function (a, b, t)
  t = t or 0.5;
  local diff = (b - a) % 360
  local shortest = (2 * diff) % 360 - diff;
  return (a + shortest * mathx.clamp (t, 0, 1)) % 360
end


return L;
