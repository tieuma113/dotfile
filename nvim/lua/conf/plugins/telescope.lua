return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  keys = {
    { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find git files" },
    { "<leader>fr", "<cmd>Telescope live_grep<cr>", desc = "Live grep" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find files" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Find buffers" },
    { "<leader>fh", "<cmd>Telescope find_files hidden=true<cr>", desc = "Find files (hidden)" },
    {
      "<leader>ft",
      function()
        local ext = vim.fn.input("Grep in file type (e.g. lua, cpp, py): ")
        if ext == "" then return end
        require("telescope.builtin").live_grep({ glob_pattern = "*." .. ext })
      end,
      desc = "Live grep by file type",
    },
  },
  config = function()
    require("telescope").setup({})
  end,
}
