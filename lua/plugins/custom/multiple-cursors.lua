return {
    "brenton-leighton/multiple-cursors.nvim",
    version = "*", -- Use the latest tagged version
    opts = {},     -- This causes the plugin setup function to be called
    keys = {
        { "<C-j>",         "<Cmd>MultipleCursorsAddDown<CR>" },
        { "<C-Down>",      "<Cmd>MultipleCursorsAddDown<CR>",          mode = { "n", "i" } },
        { "<C-k>",         "<Cmd>MultipleCursorsAddUp<CR>" },
        { "<C-Up>",        "<Cmd>MultipleCursorsAddUp<CR>",            mode = { "n", "i" } },
        { "<C-LeftMouse>", "<Cmd>MultipleCursorsMouseAddDelete<CR>",   mode = { "n", "i" } },
        { "<Leader>a",     "<Cmd>MultipleCursorsAddMatches<CR>",       mode = { "n", "x" } },
        { "<C-n>",         "<Cmd>MultipleCursorsAddJumpNextMatch<CR>", mode = { "n", "x" } },
    },
}
