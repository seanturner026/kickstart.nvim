vim.api.nvim_create_user_command("OCU", require("gitblame").open_commit_url, {})
vim.api.nvim_create_user_command("TGB", require("gitblame").toggle, {})
