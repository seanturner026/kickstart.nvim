-- Formatting client: conform.nvim
-- - configured to use black & isort in python
-- - use the taplo-LSP for formatting in toml
-- - Formatting is triggered via `<leader>f`, but also automatically on save
return {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- load the plugin before saving
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                python = { "isort", "black" },
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

        conform.formatters.black = {
            prepend_args = {
                "--preview",
                "--enable-unstable-feature=string_processing",
            },
        }

        conform.formatters.isort = {
            prepend_args = {
                "--profile",
                "black",
            },
        }
    end,
}
