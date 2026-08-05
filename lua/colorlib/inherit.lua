-- utils/class.lua
local function inherit (Subclass, Superclass)
  -- 1. Copy all parent methods into the subclass
  if Superclass then
    for key, value in pairs (Superclass) do
      if type (value) == "function" and key ~= "create" then
        Subclass [key] = value
      end
    end
  end

  -- 2. Bind instance lookup to itself (metatable)
  Subclass.__index = Subclass;
  return Subclass;
end

return inherit;
