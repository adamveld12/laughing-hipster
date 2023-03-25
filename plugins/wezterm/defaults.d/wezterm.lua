local wezterm = require 'wezterm';

local config = {};

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder();
end

config.default_prog = {"/bin/bash", "--login"};
config.default_cwd = "~/projects";

config.font = wezterm.font('Pragmata Pro Mono Liga');

config.color_scheme = 'Aura (Gogh)';
--config.color_scheme = 'Batman';

config.window_padding = {
  left = 10,
  right = 10,
  top = 10,
  bottom = 10,
};

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.8,
};

config.window_background_opacity = 0.5;

config.keys = {
    -- This will create a new split and run your default program inside it
    {
        key="s",
        mods="CTRL|SHIFT",
        action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}
    },
    {
        key="i",
        mods="CTRL|SHIFT",
        action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}
    },
    {
        key="j",
        mods="CTRL|SHIFT",
        action=wezterm.action{AdjustPaneSize={"Down", 2}}
    },
    {
        key="k",
        mods="CTRL|SHIFT",
        action=wezterm.action{AdjustPaneSize={"Up", 2}}
    },
    {
        key="h",
        mods="CTRL|SHIFT",
        action=wezterm.action{AdjustPaneSize={"Left", 2}}
    },
    {
        key="l",
        mods="CTRL|SHIFT",
        action=wezterm.action{AdjustPaneSize={"Right", 2}}
    },
    {
        key="h",
        mods="CTRL|SHIFT",
        action=wezterm.action{ActivatePaneDirection="Left"}
    },
    {
        key="l",
        mods="CTRL|SHIFT",
        action=wezterm.action{ActivatePaneDirection="Right"}
    },
    {
        key="j",
        mods="CTRL|SHIFT",
        action=wezterm.action{ActivatePaneDirection="Down"}
    },
    {
        key="k",
        mods="CTRL|SHIFT",
        action=wezterm.action{ActivatePaneDirection="Up"}
    },
    {
        key="w",
        mods="CTRL",
        action=wezterm.action{CloseCurrentTab={confirm=false}}
    }
};

return config;

