vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.python3_host_prog = "/Users/sean/.rye/shims/python"

vim.opt.list = true
vim.opt.listchars:append({ lead = "·" })
vim.opt.listchars:append({ leadmultispace = "┊ " })
vim.opt.listchars:append({ space = "·" })
vim.opt.listchars:append({ tab = "➞ " })
vim.opt.listchars:append({ trail = "·" })

vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.textwidth = 120
vim.opt.formatoptions = "c"

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.inccommand = "split"

-- See `:help vim.o`
vim.o.hlsearch = false -- Set highlight on search
vim.o.mouse = "a" -- Enable mouse mode
vim.o.clipboard = "unnamedplus" -- Sync clipboard between OS and Neovim.
vim.o.breakindent = false -- Disable break indent
vim.o.undofile = true -- Save undo history
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.o.smartcase = true
vim.wo.signcolumn = "yes" -- Keep signcolumn on by default
vim.o.updatetime = 250 -- Decrease update time
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience
vim.o.termguicolors = true

vim.wo.number = true -- Make line numbers default

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
