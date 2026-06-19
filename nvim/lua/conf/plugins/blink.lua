return {
  "saghen/blink.cmp",
  -- Use a release tag so the prebuilt fuzzy-matcher binary is downloaded
  -- (no Rust toolchain required).
  version = "1.*",
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    -- Keep the same keymaps you had under nvim-cmp.
    keymap = {
      preset = "none",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      ["<C-e>"] = { "hide", "fallback" },
      -- Accept only an explicitly selected item; otherwise insert a newline
      -- (matches your old `confirm { select = false }`).
      ["<CR>"] = { "accept", "fallback" },
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
    },

    appearance = { nerd_font_variant = "mono" },

    -- Native snippet support + path/buffer sources, all built in.
    -- `lazydev` feeds vim/plugin API completions when editing Lua config.
    sources = {
      default = { "lazydev", "lsp", "path", "snippets", "buffer" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          -- Rank lazydev results above LSP so vim API shows first in Lua.
          score_offset = 100,
        },
      },
    },

    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 200 },
      menu = {
        draw = {
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "source_name" },
          },
        },
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
