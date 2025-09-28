-- https://www.lunarvim.org/docs/configuration

-- https://www.lunarvim.org/docs/configuration/language-features/linting-and-formatting#formatting-on-save
lvim.format_on_save.enabled = true

-- https://www.lunarvim.org/docs/configuration/appearance/statusline
lvim.builtin.lualine.on_config_done = function(lualine)
  local config = lualine.get_config()
  config.sections.lualine_c = {
    { "filename", path = 1 } }
  lualine.setup(config)
end
