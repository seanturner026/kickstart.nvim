return {
    "navarasu/onedark.nvim",
    priority = 1000,
    config = function()
        require("onedark").setup({
            style = "darker",
        })
        vim.cmd.colorscheme("onedark")
        require("onedark").load()
        -- Set relative line number as orange (do this after loading theme)
        vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "grey" })
        vim.api.nvim_set_hl(0, "LineNr", { fg = "orange" })
        vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "grey" })
    end,
}
