local U = {}

-- wrapper for highlight function (vim.api.nvim_set_hl)
---@function paint
---@param group string
---@param styles string|table
---@param ns_id number -- [Optional] namespace-id
function U.paint (group, styles, ns_id)
  if type (styles) == "string" then
    -- Easily link one group to another
    vim.api.nvim_set_hl (ns_id or 0, group, { link = styles })
  else
    -- Apply colors, or clear the group entirely if styles is {}
    vim.api.nvim_set_hl (ns_id or 0, group, styles or {})
  end
end

return U;
