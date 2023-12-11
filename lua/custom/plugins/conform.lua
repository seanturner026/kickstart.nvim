-- Formatting client: conform.nvim
-- - configured to use black & isort in python
-- - use the taplo-LSP for formatting in toml
-- - Formatting is triggered via `<leader>f`, but also automatically on save
return {
    "stevearc/conform.nvim",
    event = "BufWritePre",     -- load the plugin before saving
    keys = {
        {
            "<leader>f",
            function() require("conform").format({ lsp_fallback = true }) end,
            desc = "Format",
        },
    },
    opts = {
        formatters_by_ft = {
            -- first use isort and then black
            python = { "isort", "black" },
            -- "inject" is a special formatter from conform.nvim, which
            -- formats treesitter-injected code. Basically, this makes
            -- conform.nvim format python codeblocks inside a markdown file.
            markdown = { "inject" },
        },
        -- enable format-on-save
        format_on_save = {
            -- when no formatter is setup for a filetype, fallback to formatting
            -- via the LSP. This is relevant e.g. for taplo (toml LSP), where the
            -- LSP can handle the formatting for us
            lsp_fallback = true,
        },
    },
}
