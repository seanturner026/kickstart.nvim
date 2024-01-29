-- See `:help vim.keymap.set()`
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Easy find and replace.
vim.keymap.set({ "v" }, "<leader>re", '"hy:%s/<C-r>h/<C-r>h/gc<left><left><left>', { desc = "Open search and replace for currently selected text" })
vim.keymap.set({ "n" }, "<leader>re", ":%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>", { desc = "Open search and replace for word under cursor" })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gkzz' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gjzz' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- Remap for smooth vertical jumps
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Center cursor after moving up a half-page" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Center cursor after moving down a half-page" })

-- Register blackholes
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "c", '"_c')

vim.keymap.set("n", "dd", function()
    if vim.fn.getline("."):match("^%s*$") then
        return '"_dd'
    end
    return "dd"
end, { expr = true })
