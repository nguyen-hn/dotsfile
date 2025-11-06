return {
    'nvim-treesitter/nvim-treesitter', build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    opts = {
        ensure_installed = { 'bash', 'c', 'html','lua', 'markdown','vim', 'vimdoc', 'cpp', 'python', 'make', 'cmake', 'latex'},
        auto_install = true,
        ignore_install = {},
        highlight = {
            enable = true,
            disable = function(lang, buf)
                local max_filesize = 100*1024
                local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                if ok and stats and stats.size > max_filesize then
                    return true
                end
            end,
            additional_vim_regex_highlighting = false,
        },
        indent = {enable = true, disable = {} }
    },
    config = function(_, opts)
        require('nvim-treesitter.install').prefer_git = true,
        require('nvim-treesitter.configs').setup(opts)
    end,
}
