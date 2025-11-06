-- Set custom mapping <leader>
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local keymap = vim.keymap
local default_opts = {noremap = true, silent = true}

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

-- go to start/end line in insert mode
keymap.set("i", "<C-A>", "<HOME>", {desc = "Go to start of line"})
keymap.set("i", "<C-E>", "<END>")
-- keymap.set("n", "<C-S>", "<cmd>w<cr>")

-- keymap.set({"n", "x"}, "h", "^")
-- keymap.set({"n", "x"}, "l", "g_")

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

keymap.set("n", "<leader>ct", '<cmd>ColorizerToggle<cr>', opts)


keymap.set("n", "<c-t>", "<cmd>ToggleTerm direction=float name=desktop<CR>", {silent = true, desc = "Open terminal"})

keymap.set("n", "<tab>", ":tabnext<Return>", default_opts)
keymap.set("n", "<S-tab>", ":tabprev<Return>", default_opts)

-- keymap.set("n", '<F2>', '<cmd>ClangdSwitchSourceHeader<cr>', opts)
-- keymap.set("n", "<leader>ct", '<cmd>ColorizerToggle<cr>', opts)

keymap.set("n", "<leader>fp", function()
    print(vim.fn.expand('%:p'))
end, {silent = true, desc = " show full file path."})

keymap.set("v", "<leader>db", function()
    if vim.bo.filetype == "cpp" then
        local macro = vim.fn.input("Macro name (default: DEBUG): ")
        if macro == "" then
            macro = "DEBUG"
        end
        local start_line = vim.fn.line("'<")
        local end_line = vim.fn.line("'>")
        print(start_line)
        print(end_line)
        vim.fn.append(start_line - 1, "#ifdef " .. macro)
        vim.fn.append(end_line + 1, "#endif // " .. macro)
    else
        print("current file is not C++")
    end
end, {silent = true, desc = "add block in define cpp"})

keymap.set("n", "<F5>", function() 
    vim.cmd('w') -- save the file
    local file_base = vim.fn.expand("%:r")
    local source_file = vim.fn.expand("%")
    local build_command = string.format("g++ -fsplit-stack -Wall -Wextra -Wshadow -O2 %s -o %s -std=c++17 -I .", 
        vim.fn.shellescape(source_file), 
        vim.fn.shellescape(file_base)
    )
    vim.cmd("split | resize 10 | terminal " .. build_command)
    vim.cmd("startinsert")

    vim.api.nvim_create_autocmd("TermOpen", {
        buffer = 0,
        once = true,
        callback = function()
            vim.keymap.set('t', '<CR>', '<C-\\><C-n>:close<CR>', { buffer = true, silent = true})
        end
    })

end, {silent = true, desc = "Build current C++ file with g++"})

keymap.set("n", "<F6>", function() 
    vim.cmd('w') -- save the file
    local file_base = vim.fn.expand("%:t:r")
    local build_dir = "./output"
    local build_command = string.format("cd %s && make %s", 
        vim.fn.shellescape(build_dir), 
        vim.fn.shellescape(file_base)
    )
    vim.cmd("split | resize 10 | terminal " .. build_command)
    vim.cmd("startinsert")

    vim.api.nvim_create_autocmd("TermOpen", {
        buffer = 0,
        once = true,
        callback = function()
            vim.keymap.set('t', '<CR>', '<C-\\><C-n>:close<CR>', { buffer = true, silent = true})
        end
    })
end, {silent = true, desc = "Build current C++ file with g++"})
keymap.set("n", "<F8>", function()
    local cwd = vim.fn.expand("%:p:h")
    local cmake_file = cwd .. "/CMakeLists.txt"
    if vim.fn.filereadable(cmake_file) == 0 then
        vim.notify("No CMakeLists.txt found in current directory", vim.log.level.WARN)
        return
    end

    if vim.fn.filereadable(cwd .. "/build.sh") == 0 then
        vim.notify("No build.sh found in current directory", vim.log.level.ERROR)
        return
    end

    vim.cmd("split | resize 10 | terminal ./build.sh")
    vim.cmd("startinsert")
    vim.api.nvim_create_autocmd("TermOpen", {
        buffer = 0,
        once = true,
        callback = function()
            vim.keymap.set('t', '<CR>', '<C-\\><C-n>:close<CR>', { buffer = true, silent = true})
        end
    })
end, { silent = true, desc = "Run build.sh if CMakeLists.txt exist"})
