-- 1. use backdoor
local PRIVATE_DATA_KEY = "__enum_raw_data" 

local function createEnum(tbl)
  return setmetatable ({}, {
    __index = function(_, key)
      -- ADD THIS: Let your obj_dump tool bypass the lock
        if key == PRIVATE_DATA_KEY then return tbl end

        if tbl[key] ~= nil then
          return tbl[key]
        else
          error("Unknown enum key: " .. tostring(key), 2)
        end
    end,
    __newindex = function()
      error("Cannot modify a read-only enum", 2)
    end,
    __metatable = false
  })
end

--[[

local function scanTable(t)
  -- Your existing loop
  for k, v in pairs(t) do
    -- ... your dump logic ...
  end

  -- Check for the secret backdoor key
  local rawData = t["__enum_raw_data"] 
  if rawData and type(rawData) == "table" then
    for k, v in pairs(rawData) do
      print("[Enum Key]", k, "->", v)
    end
  end
end
--]]

-- 2. use global
_G.EnumRegistry = _G.EnumRegistry or {}

local original_createEnum = createEnum
createEnum = function(tbl)
  local proxy = original_createEnum(tbl)
  -- Map the proxy table pointer to the raw data table
  _G.EnumRegistry[proxy] = tbl
  return proxy
end

local function scanTable(t)
  -- Your existing loop
  for k, v in pairs(t) do
    -- ... your dump logic ...
  end

  -- Look up the table pointer in the registry
  if _G.EnumRegistry and _G.EnumRegistry[t] then
    local rawData = _G.EnumRegistry[t]
    for k, v in pairs(rawData) do
      print("[Enum Key]", k, "->", v)
    end
  end
end
