-- NOTE: Requires vim.diagnostic.config({ virtual_text = false })
return {
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "VeryLazy",
    config = function()
        require("tiny-inline-diagnostic").setup()
    end,
}
