--------------------------------------------------------
-- Analysis
--------------------------------------------------------

local A = {};


-- Calculate the Relative Luminance of a color
-- Fits WCAG 2.x specifications using Rec. 709 coefficients.
---@param color string|table Hex string or an array of normalized [r, g, b]
---@param is_lrgb? boolean Set to true if the input table is already in normalized linear-RGB
---@return number luminance Value between 0.0 (pure black) and 1.0 (pure white)
function A.relative_luminance (color, is_lrgb)
  local ok, err = color:valid();
  if not ok then error (err) end;
  local lr, lg, lb = 0, 0, 0;
  -- Rec. 709 linear luma coefficients
  return 0.2126 * lr + 0.7152 * lg + 0.0722 * lb;
end

--- Calculate the WCAG 2.x Contrast Ratio between two colors
---@param color_1 string Hex color string
---@param color_2 string Hex color string
---@return number ratio Value between 1.0 (no contrast) and 21.0 (maximum contrast)
function A.contrast_ratio (color_1, color_2)
  local l1 = A.relative_luminance (color_1)
  local l2 = A.relative_luminance (color_2)

  -- Formula: (L1 + 0.05) / (L2 + 0.05)
  -- L1 is the lighter color, more luminance
  if l1 > l2 then
    return (l1 + 0.05) / (l2 + 0.05)
  else
    return (l2 + 0.05) / (l1 + 0.05)
  end
end

--- Determine if a color is perceptually dark
--- Useful for dynamically flipping text foregrounds between white and black.
---@param color string Hex color string
---@param threshold? number Threshold value (0.0 to 1.0). Defaults to 0.179 (standard WCAG cutoff)
---@return boolean is_dark True if the color is dark, false if light
function A.is_dark (color, threshold)
  threshold = threshold or 0.179
  return A.relative_luminance(color) < threshold
end

--- Calculate Perceptual Color Distance using the CIE76 Delta E formula
--- Values below 1.0 are unnoticeable to humans; values above 100 are completely opposite.
---@param color_1 string Hex color string
---@param color_2 string Hex color string
---@return number distance Perceptual Euclidean distance value
function A.delta_e (color_1, color_2)
  local L1, a1, b1 = A.hex_to_lab (color_1)
  local L2, a2, b2 = A.hex_to_lab (color_2)

  local dL = L1 - L2
  local da = a1 - a2
  local db = b1 - b2

  -- Standard Euclidean distance in CIELAB space
  return math.sqrt (dL * dL + da * da + db * db)
end


return A;
