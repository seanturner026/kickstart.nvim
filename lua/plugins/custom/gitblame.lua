---@diagnostic disable: missing-fields
return {
    "f-person/git-blame.nvim",
    config = function()
        require("gitblame").setup {
            enabled = true, --Note how the `gitblame_` prefix is omitted in `setup`
        }
    end,
}
