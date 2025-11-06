local fn = vim.fn
local api = vim.api
local set = vim.opt
local keymap = vim.keymap

vim.g.logging_level = "info"

-- custom mapping <leader>
vim.g.mapleader = ' '

-- use English as main language
vim.cmd[[language en_US.UTF-8]]

vim.g.mapleader = ' '
-- vim.g.did_load_filetypes = 1
vim.g.formatoptions = "qrn1"

--set.formatoptions:appends { 'r' }

set.encoding = "utf-8"

-- clipboard
set.clipboard:append {'unnamed', "unnamedplus"}

set.updatetime = 200
set.timeoutlen = 500

set.list = true
-- set.listchars = { tab = '>>', trail = '.', nbsp = '' }

set.inccommand = 'split'

set.termguicolors = true
set.winblend = 0
set.wildoptions = 'pum'
set.pumblend = 5
set.background = 'dark'

-- indent
set.tabstop = 4
set.expandtab = true
set.shiftwidth = 4
set.softtabstop = 4
set.preserveindent = true
set.copyindent = true
set.wrap = false
set.smartindent = true	
set.autoindent = true
set.smarttab = true
set.breakindent = true

-- mouse
set.mouse = "a"
set.mousefocus = true

set.signcolumn = "yes"
set.scrolloff = 5
set.virtualedit = "block"


-- fillchars
set.fillchars = {
	vert = "|",
	fold = " ",
	eob = " ",
	msgsep = " ",
	foldopen = "▾",
	foldsep = "|",
	foldclose = "▸"
}

-- number
set.number = true
set.relativenumber = true

set.title = true

set.ruler = false

-- search
set.ignorecase = true
set.smartcase = true
set.hlsearch = false


set.autoread = true
set.cursorline = true
vim.wo.colorcolumn = '80'
set.showmatch = true
set.textwidth = 120
set.linebreak = true
set.cmdheight = 2

-- split
set.splitbelow = true
set.splitright = true

-- completion behavior
set.completeopt = "menu,menuone,noselect"

-- show command
set.showcmd = true

-- don't make noise
set.errorbells = false
set.visualbell = false

-- allow backspace everything
set.backspace = "indent,eol,start"

set.hidden = true

-- no backup
set.backup = false
set.swapfile = false

set.laststatus = 2

-- spell
--set.spell = false
--set.spelllang = "en"
--set.spellsuggest = "5"

--vim.api.nvim_create_autocmd("InsertLeave", {
--    pattern = '*',
--    command = "set nopaste"
--})

local default_opts = {noremap = true, silent = true}
--local expr_opts = {noremap = true, expr = true, silent = true}
local abbrev = vim.cmd.abbrev
local opts = {noremap = true, silent = true}


if vim.fn.has "nvim-0.7" then
    print 'vim 0.7'
    local api = vim.api
    -- highlight on yank
    local yankGrp = api.nvim_create_augroup("YankHighlight", {clear = true})
    api.nvim_create_autocmd("TextYankPost", {
        command = "silent! lua vim.highlight.on_yank()",
        group = yankGrp
    })

    -- don't auto comment new line
    api.nvim_create_autocmd("BufEnter", {command = [[set formatoptions-=cro]]})

    local git_repo_check = api.nvim_create_augroup("git_repo_check", {clear = true})
    api.nvim_create_autocmd({'VimEnter', 'DirChanged'}, {
        command = "silent! lua print(repo check)",
        group = git_repo_check
    })

    -- go to last loc when opening buffer
    api.nvim_create_autocmd("BufReadPost", {
        command = [[ if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif ]]
    })

    api.nvim_create_autocmd({'BufEnter', 'BufNewFile'}, {
        pattern = {"*.cpp", "*.cc", ".h", ".hpp"},
        command = 'set filetype=cpp'
    })
    --api.nvim_create_autocmd({'BufEnter', 'BufNewFile'}, {
    --    pattern = {"CMakeLists.txt"},
    --    command = 'set filetype=cmake'
    --})
    api.nvim_create_autocmd({'BufEnter', 'BufNewFile'}, {
        pattern = {"*.lua"},
        command = 'set filetype=lua'
    })
    api.nvim_create_autocmd({'BufEnter', 'BufNewFile'}, {
        pattern = {"*.sh"},
        command = 'set filetype=bash'
    })
    api.nvim_create_autocmd({'BufEnter', 'BufNewFile'}, {
        pattern = {"*.py"},
        command = 'set filetype=python'
    })
    -- auto load plugin when changed
    --local packer_user_config = api.nvim_create_augroup("packer_user_config", {clear = true})
    --api.nvim_create_autocmd("BufWritePost", {
    --    pattern =   {"plugins.lua"},
    --    command = "source <afile> | PackerCompile",
    --    group = packer_user_config
    --})

else
    print("use vim cmd")
    local cmd = vim.cmd

    -- highlight on yank
    cmd [[
        augroup YankHighlight
        autocmd!
        autocmd TextYankPost * silent! lua vim.highlight.on_yank()
        augroup end
    ]]

    -- don't auto comment new line
    -- cmd [[autocmd BufEnter * set formatoptions-=cro]]
end
