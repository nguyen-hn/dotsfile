return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        opts = {
            options = {
                icon_enabled = false,
                theme = 'tokyonight',
                component_separators = { left = '', right = '' },
                section_separators = { left = '', right = '' },
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                    refresh_time = 16,
                    events = {
                        'WinEnter',
                        'BufEnter',
                        'BufWritePost',
                        'SessionLoadPost',
                        'FileChangedShellPost',
                        'VimResized',
                        'Filetype',
                        'CursorMoved',
                        'CursorMovedI',
                        'ModeChanged',
                    },
                },
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_x = {'encoding', 'fileformat', 'filetype'},
                lualine_y = {'progress'},
                lualine_z = {'location'},
            },
            tabline = {
                lualine_a = {'buffers'},
                lualine_b = {'branch'},
                lualine_c = {'filename'},
                lualine_x = {},
                lualine_y = {},
                lualine_z = {'tabs'}
            },
            winbar = {
                --lualine_a = {},
                --lualine_b = {},
                --lualine_c = {'filename'},
                --lualine_x = {},
                --lualine_y = {},
                --lualine_z = {}
            },
        },
    },
    --{
    --    'ya2s/nvim-cursorline',
    --    config = function()
    --        require('nvim-cursorline').setup({
    --            cursorline = {
    --                enable = true,
    --                timeout = 1000,
    --                number = false,
    --            },
    --            cursorword = {
    --                enable = true,
    --                min_length = 3,
    --                hl = {underline = true},
    --            }
    --        })
    --    end
    --}
}
