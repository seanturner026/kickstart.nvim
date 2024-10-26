return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
        { "williamboman/mason.nvim",           opts = true },
        { "williamboman/mason-lspconfig.nvim", opts = true },
    },
    opts = {
        ensure_installed = {
            "black",    -- formatter
            "isort",    -- organize imports
            "ruff-lsp", -- linter for python (includes flake8, pep8, etc.)
            "taplo",    -- LSP for toml (for pyproject.toml files)
        },
    },
}
