return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
        { "williamboman/mason.nvim",           opts = true },
        { "williamboman/mason-lspconfig.nvim", opts = true },
    },
    opts = {
        ensure_installed = {
            -- "ruff-lsp", -- linter for python (includes flake8, pep8, etc.)
            -- "debugpy",  -- debugger
            "black", -- formatter
            "isort", -- organize imports
            "taplo", -- LSP for toml (for pyproject.toml files)
        },
    },
}
