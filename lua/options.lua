vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.list = true
vim.opt.listchars:append({ lead = "·" })
vim.opt.listchars:append({ leadmultispace = "┊ " })
vim.opt.listchars:append({ space = "·" })
vim.opt.listchars:append({ tab = "➞ " })
vim.opt.listchars:append({ trail = "·" })

vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.textwidth = 120

vim.opt.splitbelow = true
vim.opt.splitright = true

vim.opt.scrolloff = 999

vim.opt.inccommand = "split"

-- See `:help vim.o`
vim.o.hlsearch = false                 -- Set highlight on search
vim.o.mouse = "a"                      -- Enable mouse mode
vim.o.clipboard = "unnamedplus"        -- Sync clipboard between OS and Neovim.
vim.o.breakindent = true               -- Enable break indent
vim.o.undofile = true                  -- Save undo history
vim.o.ignorecase = true                -- Case-insensitive searching UNLESS \C or capital in search
vim.o.smartcase = true
vim.wo.signcolumn = "yes"              -- Keep signcolumn on by default
vim.o.updatetime = 250                 -- Decrease update time
vim.o.timeoutlen = 300
vim.o.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience
vim.o.termguicolors = true

vim.wo.number = true -- Make line numbers default
