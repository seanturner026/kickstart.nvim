local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    error("Error cloning lazy.nvim:\n" .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Git related plugins
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",
  -- Install Mason stuff that doesn"t have a keyword
  "WhoIsSethDaniel/mason-tool-installer.nvim",
  "stevearc/conform.nvim",
  { import = "plugins.custom" },
})
