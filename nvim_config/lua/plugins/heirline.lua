return {
    {
        'rebelot/heirline.nvim'
        local WinBars = 
        config = function() 
            require("heirline").setup({
                statusline = {...},
                winbar = {...},
                tabline = {...},
                statuscolumn = {...},
                opts = {

                }
            })
        end
    }
}
