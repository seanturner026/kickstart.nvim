return {
    "allaman/kustomize.nvim",
    requires = "nvim-lua/plenary.nvim",
    ft = "yaml",
    opts = { enable_key_mappings = false },
    config = function(opts)
        require("kustomize").setup({ opts })
        vim.api.nvim_set_keymap("n", "<leader>kb", "<cmd>KustomizeBuild --enable-helm --load-restrictor=LoadRestrictionsNone<cr>", { desc = "Build Kustomize" })
        vim.api.nvim_set_keymap("n", "<leader>kd", "<cmd>KustomizeDeprecations<cr>", { desc = "Check API deprecations" })
        vim.api.nvim_set_keymap("n", "<leader>kk", "<cmd>KustomizeListKinds<cr>", { desc = "List Kubernetes Kinds" })
        vim.api.nvim_set_keymap("n", "<leader>kl", "<cmd>KustomizeListResources<cr>", { desc = "List resources" })
        vim.api.nvim_set_keymap("n", "<leader>kp", "<cmd>KustomizePrintResources<cr>", { desc = "Print resources" })
        vim.api.nvim_set_keymap("n", "<leader>kv", "<cmd>KustomizeValidate<cr>", { desc = "Validate file" })
    end,
}
