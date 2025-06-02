vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

vim.o.number = true
vim.opt.relativenumber = true

vim.o.mouse = "a" -- Enable mouse mode

--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
    vim.o.clipboard = "unnamedplus"
end)

vim.o.breakindent = false -- Disable break indent
vim.o.undofile = true -- Save undo history
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.o.smartcase = true
vim.o.signcolumn = "yes" -- Keep signcolumn on by default
vim.o.updatetime = 250 -- Decrease update time
vim.o.timeoutlen = 300

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.list = true
vim.opt.listchars = {
    lead = "·",
    leadmultispace = "┊ ",
    space = "·",
    tab = "➞ ",
    trail = "·",
}

vim.opt.inccommand = "split"
vim.opt.incsearch = true
vim.opt.hlsearch = false

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true

vim.opt.tabstop = 4
vim.opt.textwidth = 120
vim.opt.formatoptions = "c"

vim.o.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience
vim.o.termguicolors = true

-- Transparent folds
vim.o.foldtext = ""
vim.o.fillchars = "fold: "

vim.opt.spell = true
vim.opt.spelllang = "en_us"

vim.filetype.add({
    extension = {
        hcl = "terraform",
        hujson = "jsonc",
        json5 = "jsonc",
        tf = "terraform",
    },
})

vim.lsp.set_log_level("off") -- Prevents LSP client log too large errors
