return {
  "nvim-treesitter/nvim-treesitter",
  branch = "main",
  build = ":TSUpdate",
  lazy = false, -- load at startup so the FileType autocmd is registered early

  config = function()
    local ts = require("nvim-treesitter")
    local ts_config = require("nvim-treesitter.config")

    -- main-branch setup() only takes { install_dir }; keep the default.
    ts.setup({})

    local ensure_installed = {
      "c", "cpp", "python",
    }

    -- Install the listed parsers (async; no-op for already-installed ones).
    ts.install(ensure_installed)

    -- Highlighting + indentation + auto-install, enabled per buffer.
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype
        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then return end

        local function enable()
          if not vim.api.nvim_buf_is_valid(buf) then return end
          -- Highlighting (provided by Neovim).
          pcall(vim.treesitter.start, buf, lang)
          -- Indentation (provided by nvim-treesitter; experimental upstream).
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end

        if vim.tbl_contains(ts_config.get_installed("parsers"), lang) then
          enable()
        elseif vim.tbl_contains(ts.get_available(), lang) then
          -- auto_install: fetch the parser, then enable on completion.
          ts.install({ lang }):await(function()
            vim.schedule(enable)
          end)
        end
      end,
    })

    -- Apply to any buffer already open at startup (e.g. `nvim file.c`),
    -- whose FileType event may have fired before this plugin loaded.
    vim.schedule(function()
      vim.cmd("silent! doautoall FileType")
    end)
  end,
}
