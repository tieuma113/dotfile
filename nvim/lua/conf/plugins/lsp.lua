return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/nvim-cmp",
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
        map('gd', vim.lsp.buf.definition, 'Go to definition')
        map('gD', vim.lsp.buf.declaration, 'Go to declaration')
        map('gi', vim.lsp.buf.implementation, 'Go to implementation')
        map('go', vim.lsp.buf.type_definition, 'Go to type definition')
        map('gr', vim.lsp.buf.references, 'List references')
        map('gs', vim.lsp.buf.signature_help, 'Signature help')
        map('<F2>', vim.lsp.buf.rename, 'Rename symbol')
        map('<F4>', vim.lsp.buf.code_action, 'Code action')
      end,
    })


    -- Mason setup
    require("mason").setup({
      ensure_installed = {
      },
    })

    -- Mason-lspconfig setup
    require("mason-lspconfig").setup({
      handlers = {
        function(server_name)
          vim.lsp.enable(server_name)
        end,
      },
    })

    -- clangd is installed system-wide, configure it directly
    local capabilities = require("cmp_nvim_lsp").default_capabilities()
    vim.lsp.config('clangd', {
      cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
      capabilities = capabilities,
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    })
    vim.lsp.enable('clangd')

    local cmp = require("cmp")

    --   פּ ﯟ   some other good icons
    local kind_icons = {
      Text = "",
      Method = "m",
      Function = "",
      Constructor = "",
      Field = "",
      Variable = "",
      Class = "",
      Interface = "",
      Module = "",
      Property = "",
      Unit = "",
      Value = "",
      Enum = "",
      Keyword = "",
      Snippet = "",
      Color = "",
      File = "",
      Reference = "",
      Folder = "",
      EnumMember = "",
      Constant = "",
      Struct = "",
      Event = "",
      Operator = "",
      TypeParameter = "",
    }
    -- find more here: https://www.nerdfonts.com/cheat-sheet

    cmp.setup({
      sources = {
        {name = "nvim_lsp"},
      },

     mapping = {
       ["<C-k>"] = cmp.mapping.select_prev_item(),
       ["<C-j>"] = cmp.mapping.select_next_item(),
       ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
       ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
       ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
       ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
       ["<C-e>"] = cmp.mapping {
         i = cmp.mapping.abort(),
         c = cmp.mapping.close(),
       },
       -- Accept currently selected item. If none selected, `select` first item.
       -- Set `select` to `false` to only confirm explicitly selected items.
       ["<CR>"] = cmp.mapping.confirm { select = false },
       ["<Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
           cmp.select_next_item()
         else
           fallback()
         end
       end, {
         "i",
         "s",
       }),
       ["<S-Tab>"] = cmp.mapping(function(fallback)
         if cmp.visible() then
           cmp.select_prev_item()
         else
           fallback()
         end
       end, {
         "i",
         "s",
       }),
     },

    formatting = {
      fields = { "kind", "abbr", "menu" },
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
        -- vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        vim_item.menu = ({
          nvim_lsp = "[LSP]",
          --nvim_lsp_signature_help = "[LSP-Signature]",
          buffer = "[Buffer]",
          path = "[Path]",
        })[entry.source.name]
        return vim_item
      end,
    }
  })
  end
}

