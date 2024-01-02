return {
    "mg979/vim-visual-multi",
    lazy = false,
    config = function()
        vim.g.VM_maps = {  -- necessary for vim-visual-multi https://github.com/mg979/vim-visual-multi/issues/172#issuecomment-1092293500
            ["I BS"] = "", -- disable backspace mapping
        }
    end,
}
