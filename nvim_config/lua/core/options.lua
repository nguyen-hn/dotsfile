
local set = vim.opt

-- number
set.number = true -- Make line numbers
set.relativenumber = true -- set relative numbered lines
set.numberwidth = 4
set.wrap = false -- Display lines as one long line

set.encoding = "utf-8"
-- mouse
set.mouse = "a" -- enable mouse mode
set.mousefocus = true

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

set.laststatus = 2
-- no backup
set.backup = false
set.swapfile = false

-- search
set.ignorecase = true
set.smartcase = true
set.hlsearch = false

-- split
set.splitbelow = true
set.splitright = true
-- time
set.updatetime = 250 -- decrease update time (default: 4000)
set.timeoutlen = 500 -- time to wait for a mapped sequence to complete (in milliseconds) (default: 1000)
-- completion behavior
set.completeopt = "menu,menuone,noselect"

-- show command
set.showcmd = true
set.showmode = false
set.showtabline = 2
-- don't make noise
set.errorbells = false
set.visualbell = false

set.title = true
set.ruler = false

-- allow backspace everything
set.backspace = "indent,eol,start"

set.termguicolors = true
set.winblend = 0
set.wildoptions = 'pum'
set.pumblend = 5
set.pumheight = 10
set.background = 'dark'
set.signcolumn = "yes"
set.scrolloff = 5
set.sidescrolloff = 8
set.virtualedit = "block"
set.conceallevel = 0
-- clipboard
-- set.clipboard:append {'unnamed', "unnamedplus"}
-- set.clipboard=
set.hidden = true
set.cursorline = true
--set.autoread = true
--vim.wo.colorcolumn = '80'
--set.showmatch = true
--set.textwidth = 120
--set.linebreak = true
set.cmdheight = 2
