local plugins = {
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
        'Yggdroot/indentLine',
        lazy = true,
        event = "BufReadPre",
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
}

if not vim.g.vscode then
    table.insert(plugins, {
        {
            -- 打标签
            'kshenoy/vim-signature',
            lazy = false,
            event = "BufReadPre",
            enabled = true,
            config = function()
                vim.g.SignatureForceRemoveGlobal = 1
            end
        },
        -- 命令行搜索工具 brew install fzf 
        -- 使用telescope替代
        {
            'junegunn/fzf.vim',
            event = 'VeryLazy',
            -- enabled = false,  -- 暂不启用
            keys = {
                {'<leader>b', ':Buffers<CR>', mode = {'n'}},
                {'<C-g>', ':Files<CR>', mode = {'n'}},
                {'<C-n>', ':Marks<CR>', mode = {'n'}},
                -- {'<C-h>', ':History<CR>', mode = {'n'}},
                -- {'<C-f>', ':Ag<Space>', mode = {'n'}},
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
            dependencies = {
                "nvim-lua/plenary.nvim", -- Lua 开发模块
                -- "BurntSushi/ripgrep", -- 文字查找
                -- "sharkdp/fd" -- 文件查找
            },
            config = require('configs.telescope'),
        },
        -- git
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
            'vim-scripts/indentpython.vim',
            lazy = false,
            enabled = true,
            event = "BufReadPost",
        },
        {
            -- 安装后 TSInstall lua python
            "nvim-treesitter/nvim-treesitter",
            lazy = true,
            event = "BufReadPre",
            build = ":TSUpdate",
            config = function () 
                local configs = require("nvim-treesitter.configs")

                configs.setup({
                    ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "python" },
                    sync_install = false,
                    highlight = { enable = true },
                    indent = { enable = true },  
                })
            end
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
        },
        {
            -- 状态栏
            "ojroques/nvim-hardline",
            config = function()
                require('hardline').setup {}
            end
        },
        {
            "iamcco/markdown-preview.nvim",
            enabled = false,  -- 暂不启用
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            ft = { "markdown" },
            build = function()
                vim.fn["mkdp#util#install"]()
            end,
        },
        -- GO
        {
            "ray-x/go.nvim",
            dependencies = {  -- optional packages
                "ray-x/guihua.lua",
                "neovim/nvim-lspconfig",
                "nvim-treesitter/nvim-treesitter",
            },
            config = function()

                require("go").setup({
                })
                local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
                vim.api.nvim_create_autocmd("BufWritePre", {
                    pattern = "*.go",
                    callback = function()
                        require('go.format').gofmt()
                    end,
                    group = format_sync_grp,
                })
            end,
            event = {"CmdlineEnter"},
            ft = {"go", 'gomod'},
            build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
        },
        {
            "github/copilot.vim",
            lazy = false,
            cmd = {
                "Copilot",
            },
            config = function()
                vim.g.copilot_enabled = 1
                vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
                    expr = true,
                    replace_keycodes = false
                })
                vim.g.copilot_no_tab_map = true
            end
        },
    })
end

return plugins
