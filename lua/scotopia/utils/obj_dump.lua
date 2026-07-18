local function obj_dump (object, label, indent, visited)
  indent = indent or 0;
  visited = visited or {};
  label = label or "";

  local whitespace = string.rep (" ", indent);
  local datatype = type (object);

  -- 1. handle non-table primitives instantly
  if datatype == "string" or datatype == "number" or datatype == "boolean" then
    local field_string = datatype == "string" and string.format ("\"%s\"", object) or tostring (object);
    print (whitespace .. label .. ": <" .. datatype .. "> " .. field_string);
    return;
  elseif datatype == "function" then
    print (whitespace .. label .. ": <function>");
    return;
  elseif datatype ~= "table" then -- others
    local field_string = datatype == "string" and string.format ("\"%s\"", object) or tostring (object);
    print (whitespace .. label .. ": <" .. datatype .. "> " .. field_string);
    return;
  end

  -- 2. Table: check for cycles FIRST before printing anything
  if visited [object] then
    local object_name = object.name or tostring (object);
    print (whitespace .. label .. ": <reference> " .. object_name .. ",");
    return;
  end

  -- 3. Table: mark visited and open brackets
  visited [object] = true;
  print (whitespace .. label .. ": <table> {");

  -- 4. pure loop through it's fields
  for key, value in pairs (object) do
    local key_string = type (key) == "string" and string.format ("[\"%s\"]", key) or string.format ("[%s]", tostring (key)); -- short-circuit ternary / if-else
    obj_dump (value, key_string, indent + 2, visited);
  end

  print (whitespace .. "}");
end

--[[
-- test
local data;
data = {
  id = 100;
  tags = { "colors", "math" };
  config = { active = false };
  fun = function() print ("it's a function"); end;
}
data.ref = data;

local metatable = {
  name = function ()
    print ("obj_dump");
  end
}

setmetatable (data, metatable);


obj_dump (data);
obj_dump (getmetatable (data));
--]]

return obj_dump;
