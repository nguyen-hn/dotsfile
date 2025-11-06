local keymap = vim.keymap
local default_opts = {noremap = true, silent = true}
-- Set custom mapping <leader>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- save key strokes
keymap.set({"n", "x"}, ";", ":")

-- turn word under cursor to upper case
keymap.set("i", "<c-u>", "<Esc>viwUea")

-- save and quit
keymap.set("n", "<leader>w",  "<cmd>update<cr>", {silent = true, desc = "save buffer"})

-- quit without save
keymap.set("n", "<leader>q", "<cmd>x<cr>", {silent = true, desc = "quit current window"})

-- quit all opened buffers
keymap.set("n", "<leader>Q", "<cmd>qa!<cr>", {silent = true, desc = "quit nvim"})

-- insert blank line without move cursor
keymap.set("n", "<space>o", "printf('m`%so<ESC>``', v:count1)", {expr = true, desc = "insert line below"})
keymap.set("n", "<space>O", "printf('m`%sO<ESC>``', v:count1)", {expr = true, desc = "insert line above"})

-- no history command pane
keymap.set("n", "q:", "<nop>", { silent = true, desc = ""})

-- center search result
keymap.set("n", "n", "nzz", default_opts)
keymap.set("n", "N", "Nzz", default_opts)

-- cancel highlight search with ESC
keymap.set("n", "<ESC>", ":nohlsearch<Bar>:echo<cr>", default_opts)

-- switch window
-- keymap.set("n", "<left>", "<c-w>h")
-- keymap.set("n", "<right>", "<c-w>l")
-- keymap.set("n", "<up>", "<c-w>k")
-- keymap.set("n", "<down>", "<c-w>j")

keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]error messages' })
keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- keymap.set("n", "y", "myy")

-- go to start/end line in insert mode
keymap.set("i", "<C-A>", "<HOME>")
keymap.set("i", "<C-E>", "<END>")
keymap.set("n", "<C-S>", "<cmd>w<cr>")

keymap.set({"n", "x"}, "H", "^")
keymap.set({"n", "x"}, "L", "g_")

keymap.set("n", "<leader>sv", function()
    vim.cmd([[
        update $MYVIMRC
        source $MYVIMRC
    ]])
    vim.notify("Nvim config successfully reloaded!", vim.log.levels.INFO, {title = "nvim-config"})
end, {silent = true, desc = "reload init.lua"}
    )

keymap.set("c", "<C-A>", "<HOME>")

-- use <ESC> to quit builtin terminal
keymap.set("t", "<ESC>", [[<c-\><c-n>]])

-- New tab
keymap.set("n", "ss", ":split<Return><C-w>w", {silent = true})
keymap.set("n", "sv", ":vsplit<Return><C-w>w", {silent = true})
keymap.set("n", "te", ":tabedit<Return>", {silent = true})

-- Select all
keymap.set("n", "<C-A>", "gg<S-v>G")

-- switch buffer
keymap.set("n", "<S-h>", ":bprevious<cr>", default_opts)
keymap.set("n", "<S-l>", ":bnext<cr>", default_opts)

-- toggle set spell
-- keymap.set("n", "<F11>", "<cmd>set spell!<cr>", {desc = "toggle spell"})
-- keymap.set("i", "<F11>", "<cmd>set spell!<cr>", {desc = "toggle spell"})

-- copy/paste clipboard
keymap.set({"n", "x"}, "gy", '"+y')
keymap.set({"n", "x"}, "gp", '"+p')

keymap.set("n", '<F2>', '<cmd>ClangdSwitchSourceHeader<cr>', opts)
keymap.set("n", "<leader>ct", '<cmd>ColorizerToggle<cr>', opts)

keymap.set("n", '<leader>th', ':call InsertTemplate("competitive.skeleton")<cr>', default_opts)

function InsertTemplate(filename)
    local template_path = vim.fn.expand('~/.config/nvim/templates/' .. filename)
    vim.cmd('0r ' .. template_path)
end

function SurroundWithDebug()
    local start_line = vim.fn.line("'<")
    local end_line = vim.fn.line("'>")

    vim.fn.append(start_line - 1, "#ifdef DEBUG")
    vim.fn.append(end_line + 1, "#endif")
end

keymap.set("v", "<leader>d", SurroundWithDebug, default_opts)
