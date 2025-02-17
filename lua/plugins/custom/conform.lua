return {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- load the plugin before saving
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                cue = { "cueimports" },
                python = { "isort", "ruff_format" },
                lua = { "stylua" },
                -- "inject" is a special formatter from conform.nvim, which
                -- formats treesitter-injected code. Basically, this makes
                -- conform.nvim format python codeblocks inside a markdown file.
                markdown = { "inject" },
                yaml = { "prettier" },
            },

            -- when no formatter is setup for a filetype, fallback to formatting
            -- via the LSP. This is relevant e.g. for taplo (toml LSP), where the
            -- LSP can handle the formatting for us
            format_on_save = { timeout_ms = 500, lsp_format = "fallback", async = false },
        })
    end,
}
