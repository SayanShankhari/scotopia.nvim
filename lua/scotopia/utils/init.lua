-- local obj_dump = require ("obj_dump");

local U = {}

-- 1. List all the sub-module files to search through
local sub_modules = {
  "math_utils",
}

-- 2. Define the automatic lookup behavior (Lazy load)
-- master blueprint
local U_Prototype = {};
U_Prototype.__index = U_Prototype;

-- load modules
-- Object.assign() equivalent: mixing both method buckets into one U_Metatables
for _, name in ipairs (sub_modules) do
  local module = require ("scotopia.utils." .. name);
  -- obj_dump (module);
  for key, value in pairs (module) do
    U [key] = value;
  end
  for key, value in pairs (module.MetaMethods) do
    U_Prototype [key] = value;
  end
end

-- 3. Attach the metatable behavior to our utils module
setmetatable (U, {
  __call = function (_, value)
    return setmetatable ({ _value = value }, U_Prototype);
  end
});

-- obj_dump (U);


return U;
