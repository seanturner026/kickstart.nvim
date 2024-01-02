return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
        "nvim-lua/plenary.nvim",
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
                return vim.fn.executable("make") == 1
            end,
        },
        -- {
        --     "nvim-telescope/telescope-frecency.nvim",
        --     config = function()
        --         require("telescope").load_extension("frecency")
        --     end,
        -- },
    },
    extensions = {
        -- frecency = {
        --     auto_validate = true,
        --     ignore_patterns = { "*.git/*", "*/tmp/*" },
        -- }
    },
}
