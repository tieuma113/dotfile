return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    options = {
      theme = "tokyonight",
      globalstatus = true,
      section_separators = "",
      component_separators = "|",
    },
    -- Use the tabline as a buffer bar so <S-l>/<S-h> have a visual list.
    tabline = {
      lualine_a = { { "buffers", mode = 2 } },
      lualine_z = { "tabs" },
    },
  },
}
