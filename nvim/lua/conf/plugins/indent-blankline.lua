return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = { "BufReadPost", "BufNewFile", "BufWritePost" },
  config = function()
    local hooks = require("ibl.hooks")

    -- Re-apply colors on every colorscheme load so they survive theme switches.
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      -- Inactive indent guides: dim, blend into the background.
      vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2a2e3f", nocombine = true })
      -- Active scope guide: tokyonight blue, like VSCode's highlighted scope.
      vim.api.nvim_set_hl(0, "IblScope", { fg = "#7aa2f7", nocombine = true })
    end)

    require("ibl").setup({
      indent = { char = "│" },
      scope = {
        enabled = true,
        -- VSCode shows only the vertical line, no horizontal start/end markers.
        show_start = false,
        show_end = false,
      },
      exclude = {
        filetypes = {
          "help", "dashboard", "NvimTree", "lazy", "mason",
          "notify", "toggleterm", "lspinfo", "checkhealth", "man",
        },
      },
    })
  end,
}
