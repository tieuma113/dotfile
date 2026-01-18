local wezterm = require("wezterm")
local act = wezterm.action

return {
  -- font = wezterm.font_with_fallback({
  --   "JetBrainsMono Nerd Font",
  --   "FiraCode Nerd Font",
  -- }),
  font_size = 12.0,
  color_scheme = "Catppuccin Mocha", -- try "Gruvbox Dark", "Dracula", etc.
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  window_background_opacity = 0.95,
  window_padding = {
    left = 8,
    right = 8,
    top = 8,
    bottom = 8,
  },
  default_domain = wezterm.target_triple:find("windows") and "WSL:Ubuntu-24.04" or "DefaultDomain", -- auto-start into WSL Ubuntu on Windows
  keys = {
    -- Copy / Paste (match VSCode)
    { key = "C", mods = "CTRL|SHIFT", action = act.CopyTo("Clipboard") },
    { key = "V", mods = "CTRL|SHIFT", action = act.PasteFrom("Clipboard") },

    -- New Tab / Close Tab
    { key = "T", mods = "CTRL|SHIFT", action = act.SpawnTab("DefaultDomain") },
    { key = "W", mods = "CTRL|SHIFT", action = act.CloseCurrentTab({ confirm = false }) },

    -- Split panes similar to VSCode “Split Editor”
    { key = "|", mods = "CTRL|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
    { key = "_",  mods = "CTRL|SHIFT", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },

    -- Navigate between panes (VSCode uses Ctrl+Alt+Arrow)
    { key = "LeftArrow",  mods = "ALT", action = act.ActivatePaneDirection("Left") },
    { key = "RightArrow", mods = "ALT", action = act.ActivatePaneDirection("Right") },
    { key = "UpArrow",    mods = "ALT", action = act.ActivatePaneDirection("Up") },
    { key = "DownArrow",  mods = "ALT", action = act.ActivatePaneDirection("Down") },

    -- Zoom / Toggle Maximize Pane (match VSCode Ctrl+J / Ctrl+M or similar)
    { key = "M", mods = "CTRL|SHIFT", action = act.TogglePaneZoomState },

    -- Rename Tab (VSCode: rename editor tab)
    { key = "R", mods = "CTRL|SHIFT", action = act.PromptInputLine {
        description = "Rename current tab",
        action = wezterm.action_callback(function(window, pane, line)
          if line then window:active_tab():set_title(line) end
        end),
    }},

  },
}
