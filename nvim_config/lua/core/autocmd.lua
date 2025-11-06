
if vim.fn.has "nvim-0.7" then
    -- print 'vim 0.7'
    local api = vim.api
    -- highlight on yank
    local yankGrp = api.nvim_create_augroup("YankHighlight", {clear = true})
    api.nvim_create_autocmd("TextYankPost", {
        pattern = "*",
        group = yankGrp,
        callback = function()
            -- api.nvim_set_hl(0, "YankColor", {fg = "#34495E", bg = "#2ECC71", ctermfg = 59, ctermbg = 41})
            vim.highlight.on_yank({ timeout = 300 })
        end,
        desc = "Briefly highlight yanked text",
    })

    -- don't auto comment new line
    api.nvim_create_augroup("NoAutoComments", { clear = true })
    api.nvim_create_autocmd("BufEnter", {
        group = "NoAutoComments",
        pattern = "*",
        command = "set formatoptions-=cro",
    })

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
