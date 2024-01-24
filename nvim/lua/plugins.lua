return {
    -- 命令行搜索工具 brew install fzf 
    -- 使用telescope替代
    {
        'junegunn/fzf.vim',
        event = 'VeryLazy',
        keys = {
            {'<leader>b', ':Buffers<CR>', mode = {'n'}},
            {'<C-g>', ':Files<CR>', mode = {'n'}},
            {'<C-n>', ':Marks<CR>', mode = {'n'}},
            {'<C-h>', ':History<CR>', mode = {'n'}},
            {'<C-f>', ':Ag<Space>', mode = {'n'}},
        },
        config = function()
            vim.opt.rtp:append("/usr/local/opt/fzf")
            vim.g.fzf_history_dir = "~/.local/share/fzf-history"
        end,
        dependencies = {
            { "junegunn/fzf", build = ":call fzf#install()" },
        },
    },
    {
        -- brew install ripgrep fd
        -- apt-get install ripgrep fd-find
        "nvim-telescope/telescope.nvim",
        enabled = false,  -- 暂不启用
        dependencies = {
            "nvim-lua/plenary.nvim", -- Lua 开发模块
            "BurntSushi/ripgrep", -- 文字查找
            "sharkdp/fd" -- 文件查找
        },
        config = require('configs.telescope'),
        -- 安装后 TSInstall lua python
    },
    -- git
    {
        'petertriho/nvim-scrollbar',
        event = 'BufReadPost',
        config = function()
            require('scrollbar').setup()
        end
    },
    {
        'lewis6991/gitsigns.nvim',
        lazy = true,
        event = { "CursorHold", "CursorHoldI" },
        dependencies = {
            'petertriho/nvim-scrollbar'
        },
        config = require('configs.gitsigns'),
    },
    {
        'tpope/vim-fugitive',
        lazy = true,
        event = "BufReadPre",
        cmd = { "Git", "G" },
        keys = {
            {'<leader>a', ':Git blame<CR>', mode = {'n'}}
        }
    },
    {
        'phaazon/hop.nvim', branch = 'v2',
        keys = {
            {'<leader>j', '<Cmd>HopWordAC<CR>', mode = 'n', silent = true},
            {'<leader>k', '<Cmd>HopWordBC<CR>', mode = 'n', silent = true},
            -- {'<leader>k', '<Cmd>HopLine<CR>', mode = 'n', silent = true},
            {'<leader>l', '<Cmd>HopWordCurrentLine<CR>', mode = 'n', silent = true},
        },
        config = function()
            require('hop').setup({
                keys = 'etovxqpdygfblzhckisuran',
                create_hl_autocmd = false,
            })
        end
    },
    {
        'numirias/semshi',
        lazy = true,
        event = "BufReadPre",
        build = ":UpdateRemotePlugins",
    },
    {
        'dense-analysis/ale',
        lazy = true,
        event = "BufReadPre",
        keys = {
            {'sp', '<Plug>(ale_previous_wrap)', mode = {'n'}},
            {'sn', '<Plug>(ale_next_wrap)', mode = {'n'}},
        },
        config = require('configs.ale')
    },
    {
        'neoclide/coc.nvim',
        lazy = true,
        cmd = { "CocInstall", "CocList", "CocConfig" },
        build = ":call coc#util#install()",
        event = "BufReadPost",
        keys = {
            {'<leader>g', '<Plug>(coc-definition)', mode = {'n'}},
            {'<leader>r', '<Plug>(coc-references)', mode = {'n'}},
        },
        config = require('configs.coc')
    },
    {
        'Yggdroot/indentLine',
        lazy = true,
        event = "BufReadPre",
    },
    {
        'vim-scripts/indentpython.vim',
        lazy = true,
        event = "InsertEnter",
    },
    {
        "dstein64/vim-startuptime",
        cmd = "StartupTime",
        enabled = false,
        init = function()
            vim.g.startuptime_tries = 10
        end,
    },
    {
        'kshenoy/vim-signature',
        lazy = true,
        event = "BufReadPost",
        config = function()
            vim.g.force_remove_global = true
        end
    },
    {
        'mbbill/undotree',
        lazy = false,
        cmd = {'UndotreeToggle'},
        config = function()
            if vim.fn.has("persistent_undo") then
                local target_path = vim.fn.expand('~/.undodir')

                -- create the directory and any parent directories
                -- if the location does not exist.
                if vim.fn.isdirectory(target_path) == 0 then
                    vim.fn.mkdir(target_path, "p", 0700)
                end

                vim.o.undodir = target_path
                vim.o.undofile = true
            end
        end
    },
    {
        "nvim-treesitter/nvim-treesitter",
        lazy = true,
        build = function()
            if #vim.api.nvim_list_uis() ~= 0 then
                vim.api.nvim_command([[TSUpdate]])
            end
        end,
        event = "BufReadPre",
        enabled = false,  -- 暂不启用
        config = require("configs.treesitter"),
        dependencies = {
            { "andymass/vim-matchup" },
            { "mfussenegger/nvim-treehopper" },
            { "nvim-treesitter/nvim-treesitter-textobjects" },
            {
                "abecodes/tabout.nvim",
                config = require("configs.tabout"),
            },
            {
                "windwp/nvim-ts-autotag",
                config = require("configs.autotag"),
            },
            {
                "NvChad/nvim-colorizer.lua",
                config = require("configs.colorizer"),
            },
            {
                "hiphish/rainbow-delimiters.nvim",
                config = require("configs.rainbow_delims"),
            },
            {
                "nvim-treesitter/nvim-treesitter-context",
                config = require("configs.ts-context"),
            },
            {
                "JoosepAlviste/nvim-ts-context-commentstring",
                config = require("configs.ts-context-commentstring"),
            },
        },
    },
    {
        'nvim-tree/nvim-tree.lua',
        lazy = true,
        cmd = {
            "NvimTreeToggle",
            "NvimTreeOpen",
            "NvimTreeFindFile",
            "NvimTreeFindFileToggle",
            "NvimTreeRefresh",
        },
        keys = {
            {'<leader>f', ':NvimTreeToggle<CR>', mode = 'n', silent = true},
        },
        config = require("configs.nvim-tree"),
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    }
}
