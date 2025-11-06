return {
    {
        "folke/flash.nvim",
        event = "VeryLazy",
        enabled = false,
        opts = {
            search = {forward = true, multi_window = false, wrap = false, incremental = true},
        },
        keys = {
            {"s", mode = {"n", "x", "o"}, function() require("flash").jump() end, desc = "Flash"},
            {"S", mode = {"n", "x", "o"}, function() require("flash").treesitter() end, desc = "Flash Treesitter"},
            {"r", mode = {"o"}, function() require("flash").remote() end, desc = "Remote Flash"},
            {"R", mode = {"c"}, function() require("flash").treesitter_search() end, desc = "Treesitter Search"},
            {"<c-s>", mode = {"c"}, function() require("flash").toggler() end, desc = "Toggle Flash Search"},
        },
    },
}
