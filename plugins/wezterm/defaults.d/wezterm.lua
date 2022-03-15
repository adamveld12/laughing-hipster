local wez = require 'wezterm';

return {
    font = wez.font('Fira Code'),
    default_prog = {"/bin/bash", "--login"},
    keys = {
        -- This will create a new split and run your default program inside it
        { 
            key="s", 
            mods="CTRL|SHIFT|ALT", 
            action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}
        },
        { 
            key="i", 
            mods="CTRL|SHIFT|ALT", 
            action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}
        },
    }

}
