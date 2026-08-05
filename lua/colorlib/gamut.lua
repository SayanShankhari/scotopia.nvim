local in_limit = require ("colorlib.mathx").in_limit;

-- Helper to check if a linear RGB color fits in the [0, 1] gamut
local function in_gamut (lr, lg, lb)
  local eps = 0.00001;
  return in_limit (lr, -eps, 1 + eps)
    and in_limit (lg, -eps, 1 + eps)
    and in_limit (lb, -eps, 1 + eps);
end

-- Reduces Chroma until Oklch fits into the sRGB gamut
function fit_to_lrgb_gamut (L, C, h)
  -- 1. If L is at extremes, return black or white
  if L >= 1.0 then return 1.0, 1.0, 1.0 end;
  if L <= 0.0 then return 0.0, 0.0, 0.0 end;

  -- 2. Check if the initial color is already inside the gamut
  local l, a, b = oklch_to_oklab (L, C, h);
  local lr, lg, lb = oklab_to_lrgb (l, a, b);

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
    local test_l, test_a, test_b = oklch_to_oklab (L, mid_chroma, h);
    local test_lr, test_lb, test_lg = oklab_to_lrgb (test_l, test_a, test_b);

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
