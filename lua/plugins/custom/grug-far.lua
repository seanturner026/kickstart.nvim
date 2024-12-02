return {
    "MagicDuck/grug-far.nvim",
    config = function()
        require("grug-far").setup()
        vim.api.nvim_set_keymap("n", "<leader>fr", "<cmd>GrugFar<cr>", { desc = "[F]ind [R]eplace (with grug-far)" })
    end,
}
