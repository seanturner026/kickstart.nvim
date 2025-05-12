return {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
        require("oil").setup({
            default_file_explorer = false,
            delete_to_trash = true,
            skip_confirm_for_simple_edits = true,
            view_options = {
                show_hidden = true,
                natural_order = true,
                is_always_hidden = function(name, _)
                    return name == ".." or name == ".git"
                end,
            },
            float = {
                padding = 2,
                max_width = 90,
                max_height = 0,
            },
            win_options = {
                wrap = true,
                winblend = 0,
            },
            keymaps = {
                ["q"] = "actions.close",
                ["<C-c>"] = false,
                ["<C-s>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
                ["<C-v>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
            },
            vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" }),
        })
    end,
}
