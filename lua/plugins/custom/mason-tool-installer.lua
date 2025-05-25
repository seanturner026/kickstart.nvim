return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
        { "mason-org/mason.nvim", opts = true },
        { "mason-org/mason-lspconfig.nvim", opts = true },
    },
    opts = {
        ensure_installed = {
            "taplo", -- LSP for toml (for pyproject.toml files)
        },
    },
}
