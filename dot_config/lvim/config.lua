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

lvim.plugins = {
  { "nvim-treesitter/nvim-treesitter", commit = "42fc28ba918343ebfd5565147a42a26580579482" }, -- v0.10.0
  { "tpope/vim-fugitive",              commit = "96c1009fcf8ce60161cc938d149dd5a66d570756" }, -- v3.7
  { "github/copilot.vim",              commit = "206011a8bc5078a02560d5c44177e9849e8f8d6c" }, -- v1.58.0
}

vim.opt.clipboard = ""
vim.opt.wrap = true
