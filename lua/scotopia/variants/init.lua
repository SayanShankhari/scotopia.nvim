local mahogany = require ("scotopia.variants.mahogany"); -- Warm dark timber canvas
local hazelnut = require ("scotopia.variants.hazelnut"); -- Warm glare-reduced amber wood canvas

local defaults = mahogany;

--- @param variant string|nil give optional variant name
return function (variant)
  -- fallback defaults
  if variant == nil or type (variant) ~= "string" then return defaults end;
  if type (variant) ~= "string" then return defaults end;

  -- resolve named variants
  if variant == "mahogany" or variant == "dark" then return mahogany end;
  if variant == "hazelnut" or variant == "light" then return hazelnut end;

  return defaults;
end
