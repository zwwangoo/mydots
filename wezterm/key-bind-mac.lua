local wezterm = require 'wezterm';
local platform = require('utils.platform')()
local act = wezterm.action
local mod = {}

if platform.is_mac then
   mod.SUPER = 'SUPER'
   -- mod.SUPER_REV = 'SUPER|CTRL'
   mod.SUPER_REV = 'SUPER'
elseif platform.is_win then
   mod.SUPER = 'ALT' -- to not conflict with Windows key shortcuts
   mod.SUPER_REV = 'ALT|CTRL'
end

function keyBind()
    keys = {
    { key = 'h', mods = mod.SUPER_REV, action = wezterm.action.DisableDefaultAssignment },
    { -- 控制左右移动面板
        key = 'LeftArrow',
        mods = 'ALT',
        action = wezterm.action {
            ActivateTabRelative = -1
        }
    }, {
        key = 'RightArrow',
        mods = 'ALT',
        action = wezterm.action {
            ActivateTabRelative = 1
        }
    }, { -- 搜索
        key = 'f',
        mods = 'CMD',
        action = wezterm.action.Search {
            CaseInSensitiveString = '' -- 大小写不敏感
            -- CaseSensitiveString = ''-- 大小写敏感
        }
    }, { -- 关闭当前窗口
        key = 'w',
        mods = 'CMD',
        action = wezterm.action.CloseCurrentTab {
            confirm = true
        }
    }, { -- 展示启动器
        key = 'm',
        mods = 'CMD',
        action = wezterm.action.ShowLauncher
    }, { -- 新建窗口
        key = 'n',
        mods = 'CMD',
        action = wezterm.action.SpawnCommandInNewTab {
            label = 'Fish-NewWindow',
            args = {'/usr/local/bin/fish', '-l'}
        }
    }, { -- 快速移动到行首行尾
        key = 'LeftArrow',
        mods = 'CMD',
        action = wezterm.action.SendKey {
            key = 'Home',
            mods = 'NONE'
        }
    }, {
        key = 'RightArrow',
        mods = 'CMD',
        action = wezterm.action.SendKey {
            key = 'End',
            mods = 'NONE'
        }
    },
	-- panes: split panes
    {
        key = 'p',
        mods = mod.SUPER_REV,
        action = act.SplitVertical({ domain = 'CurrentPaneDomain' }),
    },
    {
        key = 'n',
        mods = mod.SUPER_REV,
        action = act.SplitHorizontal({ domain = 'CurrentPaneDomain' }),
    },

    { key = 'k', mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Up') },
    { key = 'j', mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Down') },
    { key = 'h', mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Left') },
    { key = 'l', mods = mod.SUPER_REV, action = act.ActivatePaneDirection('Right') },
}
    return keys
end
