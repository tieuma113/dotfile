return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  event = "BufReadPost",

  config = function()
    require("ibl").setup({
      scope = {
        enabled = true,
        show_start = true,
        show_end = false,
      },
    })
  end,
}
