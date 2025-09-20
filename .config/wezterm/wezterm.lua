-- Pull in the wezterm API
local wezterm = require 'wezterm'

local act = wezterm.action
local config = {}

config.hyperlink_rules = {}
for _, rule in ipairs(wezterm.default_hyperlink_rules()) do
  table.insert(config.hyperlink_rules, rule)
end

-- Add custom rule for URLs without schema
table.insert(config.hyperlink_rules, {
  regex = [[\b\w+\.\w+(\.\w+)*(/\S+)?]],
  format = 'https://$0',
})


-- Check if work config exists and apply it if it does
local work_ok, work = pcall(require, 'work')
if work_ok and work.apply_to_config then
  work.apply_to_config(config)
end

wezterm.log_info(config)

-- wezterm.config_builder()

config.swallow_mouse_click_on_window_focus = true




config.window_frame = {
  inactive_titlebar_bg = '00000000',
  active_titlebar_bg = '00000000',
  inactive_titlebar_fg = '00000000',
  active_titlebar_fg = '00000000',
--   inactive_titlebar_border_bottom = '#2b2042',
--   active_titlebar_border_bottom = '#2b2042',
--   button_fg = '#cccccc',
--   button_bg = '#2b2042',
--   button_hover_fg = '#ffffff',
--   button_hover_bg = '#3b3052',
}

local bg_dir_root = ''

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
  config.launch_menu = {}
  config.default_prog = {"ubuntu2404.exe"}
  table.insert(config.launch_menu, {
    label = 'Command line',
    args = { 'ubuntu2404.exe' },
  })
  bg_dir_root = 'C:/Users/jolammi/'

  config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
  config.integrated_title_buttons = { 'Hide', 'Maximize', 'Close' }
  config.use_fancy_tab_bar = true
  config.show_tabs_in_tab_bar = false
  config.show_new_tab_button_in_tab_bar = false
  config.hide_tab_bar_if_only_one_tab = false
  config.show_tab_index_in_tab_bar = false
  config.window_padding = {
    left = 10,
    right = 10,
    top = 0,
    bottom = 5,
  }
end

if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then
  local home = os.getenv("HOME")
  bg_dir_root = home .. '/'
  config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
  config.integrated_title_buttons = { 'Hide', 'Maximize', 'Close' }
  config.use_fancy_tab_bar = true
  config.show_tabs_in_tab_bar = false
  config.show_new_tab_button_in_tab_bar = false
  config.hide_tab_bar_if_only_one_tab = true
  config.show_tab_index_in_tab_bar = false
  config.window_padding = {
    left = 2,
    right = 2,
    top = 10,
    bottom = 0,
  }
end

config.keys = {
    -- paste from the system clipboard with ctrl v
    { key = 'v', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },
  {
    key = 'w',
    mods = 'CTRL',
    action = wezterm.action.CloseCurrentTab { confirm = false },
  },
  }


-- local bg_path = bg_dir_root .. '.config/wezterm/white.jpg'
local bg_path = bg_dir_root .. '.config/wezterm/monsteradeliciosa_dark.jpg'

config.window_background_image = bg_path
config.window_close_confirmation = 'NeverPrompt'


-- config.mouse_bindings = {

--   }


config.colors = {
    -- The default text color
    foreground = '#D4BE98',
    -- The default background color
    background = '#251B1B',

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    cursor_bg = '#A89984',
    -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = 'black',
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    cursor_border = '#52ad70',

    -- the foreground color of selected text
    selection_fg = '#32302f',
    -- the background color of selected text
    selection_bg = '#D4BE98',

    -- The color of the scrollbar "thumb"; the portion that represents the current viewport
    scrollbar_thumb = '00000000',

    -- The color of the split lines between panes
    split = '#444444',

    ansi = {
      '#665C54',
      '#EA6962',
      '#A9B665',
      '#E78A4E',
      '#7DAEA3',
      '#D3869B',
      '#89B482',
      '#D4BE98',
    },
    brights = {
      '#928374',
      '#EA6962',
      '#A9B665',
      '#D8A657',
      '#7DAEA3',
      '#D3869B',
      '#89B482',
      '#D4BE98',
    },
}

config.font = wezterm.font("FiraCode Nerd Font", {weight="DemiBold", stretch="Normal", style="Normal"})
config.font_size=10
config.adjust_window_size_when_changing_font_size = false

return config
