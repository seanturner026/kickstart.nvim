return {
    "echasnovski/mini.files",
    version = false,
    keys = {
        { "-", "<cmd>lua require('mini.files').open(vim.api.nvim_buf_get_name(0))<CR>", { silent = true }, desc = "Open mini.files" },
        { "_", "<cmd>lua require('mini.files').open(vim.uv.cwd())<CR>", { silent = true }, desc = "Open mini.files (cwd)" },
    },
}
