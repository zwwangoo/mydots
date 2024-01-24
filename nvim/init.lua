vim.g.mapleader = ';'
vim.g.maplocalleader = ';'
vim.api.nvim_set_keymap('n', '<leader>q', ':q<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>1', ':q!<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>w', ':w<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>w', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>m', ':nohl<CR>', { noremap = true, silent = true })

-- bootstrap lazy
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- install plugins
require("lazy").setup("plugins")

-- config
vim.opt.termguicolors = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.showcmd = true
vim.opt.scrolloff = 18
vim.opt.showmatch = true
vim.opt.hlsearch = true
vim.opt.smartindent = true
vim.opt.cindent = true
vim.opt.mouse = ""
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.showcmd = true
vim.opt.autowrite = true
vim.opt.foldlevelstart = 99

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.api.nvim_create_autocmd('FileType', {pattern = {'scheme', 'lisp', 'racket', 'yaml'}, callback = function()
    vim.bo.tabstop = 2
    vim.bo.softtabstop = 2
    vim.bo.shiftwidth = 2
end})

local colorscheme = "vorange"
vim.api.nvim_command("colorscheme " .. colorscheme)

if vim.fn.has("syntax") then
    vim.cmd('syntax on')
    vim.g.python_highlight_all = 1
end

-- 记录上次访问的位置
vim.api.nvim_create_autocmd('BufReadPost', {callback = function()
    local line = vim.fn.line('\'"')
    if line > 1 and line <= vim.fn.line('$') then
        vim.cmd.normal('g\'"')
    end
end})
