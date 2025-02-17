return {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
        { "williamboman/mason.nvim", opts = true },
        { "williamboman/mason-lspconfig.nvim", opts = true },
    },
    opts = {
        ensure_installed = {
            "taplo", -- LSP for toml (for pyproject.toml files)
        },
    },
}
