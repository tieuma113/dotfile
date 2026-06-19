return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "saghen/blink.cmp",
  },

  config = function()
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local function map(lhs, rhs, desc)
          vim.keymap.set('n', lhs, rhs, { buffer = event.buf, desc = desc })
        end

        map('K', vim.lsp.buf.hover, 'Hover docs')
        map('<leader>k', vim.diagnostic.open_float, 'Line diagnostics')
        map('gd', '<cmd>Telescope lsp_definitions<cr>', 'Go to definition')
        map('gD', vim.lsp.buf.declaration, 'Go to declaration')
        map('gi', '<cmd>Telescope lsp_implementations<cr>', 'Go to implementation')
        map('go', '<cmd>Telescope lsp_type_definitions<cr>', 'Go to type definition')
        map('gr', '<cmd>Telescope lsp_references<cr>', 'List references')
        map('gs', vim.lsp.buf.signature_help, 'Signature help')
        map('<F2>', vim.lsp.buf.rename, 'Rename symbol')
        map('<F4>', vim.lsp.buf.code_action, 'Code action')
      end,
    })

    -- Give every server blink's completion capabilities by default.
    vim.lsp.config('*', {
      capabilities = require("blink.cmp").get_lsp_capabilities(),
    })

    -- mason-lspconfig v2 auto-enables every installed server via
    -- `vim.lsp.enable()` (automatic_enable = true by default), so no
    -- handlers block is needed here.
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls" },
    })

    -- clangd is installed system-wide, configure + enable it directly.
    -- (capabilities come from the '*' config above.)
    vim.lsp.config('clangd', {
      cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    })
    vim.lsp.enable('clangd')
  end
}
