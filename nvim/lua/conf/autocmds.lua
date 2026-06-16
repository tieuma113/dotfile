vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focus = false,
      scope = "cursor",
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      source = "if_many",
    })
  end,
})
