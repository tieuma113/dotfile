return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile" },
  keys = {
    { "<leader>e", "<cmd>NvimTreeToggle<cr>", desc = "Toggle file tree" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("nvim-tree").setup {}
  end,
}
