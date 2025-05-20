return {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- load the plugin before saving
    config = function()
        local conform = require("conform")

        conform.setup({
            formatters_by_ft = {
                python = function(bufnr)
                    if require("conform").get_formatter_info("ruff_format", bufnr).available then
                        return { "ruff_organize_imports", "ruff_format" }
                    else
                        return { "isort", "black" }
                    end
                end,
                lua = { "stylua" },
                yaml = { "prettier" },
            },

            -- when no formatter is setup for a filetype, fallback to formatting
            -- via the LSP. This is relevant e.g. for taplo (toml LSP), where the
            -- LSP can handle the formatting for us
            format_on_save = { timeout_ms = 500, lsp_format = "fallback", async = false },
        })
    end,
}
