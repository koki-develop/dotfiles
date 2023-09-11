-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny

vim.opt.clipboard = ""

-- Formatters
lvim.format_on_save.enabled = true
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  {
    command = "prettier",
    filetypes = { "typescript", "typescriptreact", "graphql" }
  },
  {
    command = "goimports",
    filetypes = { "go" }
  },
  {
    command = "black",
    filetypes = { "python" }
  }
}

-- Treesitter
lvim.builtin.treesitter.auto_install = true

-- Angular
-- https://www.lunarvim.org/docs/features/supported-frameworks/angular
require("lvim.lsp.manager").setup("angularls")
require("lvim.lsp.manager").setup("emmet_ls")

-- Statusline
lvim.builtin.lualine.sections.lualine_a = { "mode" }

lvim.plugins = {
  { "github/copilot.vim" },
  { "tpope/vim-fugitive" },
  { "bronson/vim-trailing-whitespace" },
  {
    "klen/nvim-config-local",
    config = true,
  }
}

-- GitHub Copilot
-- https://github.com/LunarVim/LunarVim/issues/1856#issuecomment-954224770
vim.g.copilot_no_tab_map = true
vim.g.copilot_assume_mapped = true
vim.g.copilot_tab_fallback = ""
local cmp = require "cmp"
lvim.builtin.cmp.mapping["<Tab>"] = function(fallback)
  if cmp.visible() then
    cmp.select_next_item()
  else
    local copilot_keys = vim.fn["copilot#Accept"]()
    if copilot_keys ~= "" then
      vim.api.nvim_feedkeys(copilot_keys, "i", true)
    else
      fallback()
    end
  end
end
