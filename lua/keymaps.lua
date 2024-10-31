-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Easy find and replace.
vim.keymap.set({ "v" }, "<leader>re", '"hy:%s/<C-r>h/<C-r>h/gc<left><left><left>',
    { desc = "Open search and replace for currently selected text" })
vim.keymap.set({ "n" }, "<leader>re", ":%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>",
    { desc = "Open search and replace for word under cursor" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gkzz' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gjzz' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Remap for smooth vertical jumps
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center cursor after moving up a half-page" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center cursor after moving down a half-page" })

-- Keybinds to make split navigation easier, use CTRL+<hjkl> to switch between windows
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })
--
-- -- Disable arrow keys in normal mode
-- vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move"<CR>')
-- vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move"<CR>')
-- vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move"<CR>')
-- vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move"<CR>')

-- Register blackholes
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "c", '"_c')

vim.keymap.set("n", "dd", function()
    if vim.fn.getline("."):match("^%s*$") then
        return '"_dd'
    end
    return "dd"
end, { expr = true })

-- Preserve cursor position when yanking https://nanotipsforvim.prose.sh/sticky-yank
local cursorPreYank

vim.keymap.set({ "n", "x" }, "y", function()
    cursorPreYank = vim.api.nvim_win_get_cursor(0)
    return "y"
end, { expr = true })

vim.keymap.set("n", "Y", function()
    cursorPreYank = vim.api.nvim_win_get_cursor(0)
    return "y$"
end, { expr = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        if vim.v.event.operator == "y" and cursorPreYank then
            vim.api.nvim_win_set_cursor(0, cursorPreYank)
        end
    end,
})
