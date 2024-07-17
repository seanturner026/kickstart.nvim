vim.cmd.colorscheme("tokyonight-moon")
require("tokyonight").load()

-- Set relative line number as orange (do this after loading theme)
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "grey" })
vim.api.nvim_set_hl(0, "LineNr", { fg = "orange" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "grey" })
