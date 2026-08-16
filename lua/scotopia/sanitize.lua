-- Create Level 2 (Section proxy for keys like S.ui.bg)
local function create_section_proxy (default_section, user_section)
  return setmetatable ({}, {
    __index = function (_, key)
      local default_val = default_section [key];
      -- Reject unknown property keys
      if default_val == nil then return nil end;

      local user_val = user_section and user_section [key];
      if user_val ~= nil then return user_val end;

      return default_val;
    end,
  })
end

-- Create Level 1 (Top proxy for sections like S.ui)
local function create_spec_proxy (default_specs, user_specs)
  return setmetatable ({}, {
    __index = function (_, section_key)
      local default_section = default_specs [section_key];

      -- Reject unknown section keys (e.g. S.invalid_section)
      if default_section == nil then return nil end;

      local user_section = user_specs and user_specs [section_key];
      return create_section_proxy (default_section, user_section);
    end,
  })
end

-- 3. Main Constructor API
return function (default_specs, user_specs)
  if not user_specs or type (user_specs) ~= "table" then
    return default_specs;
  end;
  return create_spec_proxy (default_specs, user_specs);
end
