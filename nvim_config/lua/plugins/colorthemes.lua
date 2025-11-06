return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    init = function()
        vim.cmd.colorscheme 'tokyonight-storm'
        vim.cmd.hi 'Comment gui=none'
    end,
    config = function ()
        require("tokyonight").setup({
            style = "moon",
            light_style = "day",
            transparent = false,
            terminal_colors = true,
            styles = {
                comments = {italic = true},
                keywords = {italic = true},
                functions = {},
                variables = {},
                sidebars = "dark",
                floats = "dark",
            },
            sidebars = {"qf", "help"},
            day_brightness = 0.3,
            hide_inactive_statusline = false,
            dim_inactive = false,
            lualine_bold = false,
            on_colors = function (colors)
                colors.hint = colors.green
                colors.error = "#ff0000"
            end,
            on_highlights = function (hl, c)
                hl.CursorLine = {
                    bg = "#333666",
                    fg = "#bbbbbb",
                    underline = false,
                }
            end,
        })
    end
}
