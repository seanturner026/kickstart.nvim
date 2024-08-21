-- Remove trailing whitespaces
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = { "*" },
    command = [[%s/\s\+$//e]],
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

require("telescope").setup({
    defaults = {
        mappings = {
            i = {
                ["<C-u>"] = false,
                ["<C-d>"] = false,
                ["<C-j>"] = require("telescope.actions").move_selection_next,
                ["<C-k>"] = require("telescope.actions").move_selection_previous,
            },
        },
        file_ignore_patterns = {
            ".git",
            "node_modules",
        },
    },
    pickers = {
        find_files = {
            hidden = true,
        },
    },
})

require("telescope").load_extension("fzf")

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
    -- Use the current buffer's path as the starting point for the git search
    local current_file = vim.api.nvim_buf_get_name(0)
    local current_dir
    local cwd = vim.fn.getcwd()
    -- If the buffer is not associated with a file, return nil
    if current_file == "" then
        current_dir = cwd
    else
        -- Extract the directory from the current file's path
        current_dir = vim.fn.fnamemodify(current_file, ":h")
    end

    -- Find the Git root directory from the current file's path
    local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
    if vim.v.shell_error ~= 0 then
        print("Not a git repository. Searching on current working directory")
        return cwd
    end
    return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
    local git_root = find_git_root()
    if git_root then
        require("telescope.builtin").live_grep({
            search_dirs = { git_root },
        })
    end
end

vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "[?] Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "[ ] Find existing buffers" })
vim.keymap.set("n", "<leader>/", function()
    -- You can pass additional configuration to telescope to change theme, layout, etc.
    require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
        winblend = 10,
        previewer = false,
    }))
end, { desc = "[/] Fuzzily search in current buffer" })

local function telescope_live_grep_open_files()
    require("telescope.builtin").live_grep({ grep_open_files = true, prompt_title = "Live Grep in Open Files" })
end

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search [G]it [F]iles" })
vim.keymap.set("n", "<leader>s/", telescope_live_grep_open_files, { desc = "[S]earch [/] in Open Files" })
vim.keymap.set("n", "<leader>sb", require("telescope.builtin").buffers, { desc = "[S]earch [B]uffers" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "[S]earch [D]iagnostics" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "[S]earch [F]iles" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "[S]earch by [G]rep" })
vim.keymap.set("n", "<leader>sG", ":LiveGrepGitRoot<cr>", { desc = "[S]earch by [G]rep on Git Root" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "[S]earch [H]elp" })
vim.keymap.set("n", "<leader>sn", function()
    builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "[S]earch [N]eovim files" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "[S]earch [R]esume" })
vim.keymap.set("n", "<leader>ss", require("telescope.builtin").builtin, { desc = "[S]earch [S]elect Telescope" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "[S]earch current [W]ord" })

-- Open Telescope on start
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        if vim.fn.argv(0) == "" then
            require("telescope.builtin").find_files()
        end
    end,
})

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
    require("nvim-treesitter.configs").setup({
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = {
            "bash",
            "dockerfile",
            "dot",
            "go",
            "gomod",
            "gosum",
            "gowork",
            "hcl",
            "html",
            "json",
            "jsonc",
            "lua",
            "make",
            "python",
            "sql",
            "terraform",
            "toml",
            "javascript",
            "vim",
            "vimdoc",
            "yaml",
        },
        ignore_install = {},
        modules = {},
        sync_install = false,
        auto_install = true, -- Autoinstall languages that are not installed.
        highlight = { enable = true },
        indent = {
            enable = true,
            disable = { "yaml" },
        },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<c-space>",
                node_incremental = "<c-space>",
                scope_incremental = "<c-s>",
                node_decremental = "<M-space>",
            },
        },
        textobjects = {
            select = {
                enable = true,
                lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                keymaps = {
                    -- You can use the capture groups defined in textobjects.scm
                    ["aa"] = "@parameter.outer",
                    ["ia"] = "@parameter.inner",
                    ["af"] = "@function.outer",
                    ["if"] = "@function.inner",
                    ["ac"] = "@class.outer",
                    ["ic"] = "@class.inner",
                },
            },
            move = {
                enable = true,
                set_jumps = true, -- whether to set jumps in the jumplist
                goto_next_start = {
                    ["]m"] = "@function.outer",
                    ["]]"] = "@class.outer",
                },
                goto_next_end = {
                    ["]M"] = "@function.outer",
                    ["]["] = "@class.outer",
                },
                goto_previous_start = {
                    ["[m"] = "@function.outer",
                    ["[["] = "@class.outer",
                },
                goto_previous_end = {
                    ["[M"] = "@function.outer",
                    ["[]"] = "@class.outer",
                },
            },
            swap = {
                enable = true,
                swap_next = {
                    ["<leader>a"] = "@parameter.inner",
                },
                swap_previous = {
                    ["<leader>A"] = "@parameter.inner",
                },
            },
        },
    })
end, 0)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(client, bufnr)
    if client.name == "terraformls" then
        vim.bo.commentstring = "// %s"
        client.server_capabilities.semanticTokensProvider = nil
    end
    -- Create a function that lets us more easily define mappings specific for LSP related items. It sets the mode, buffer
    -- and description for us each time.
    local nmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
    end

    nmap("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
    -- Execute a code action, usually your cursor needs to be on top of an error or a suggestion from your LSP for
    -- this to activate.
    nmap("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
    nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
    -- Find references for the word under your cursor.
    nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
    -- Jump to the implementation of the word under your cursor.
    -- Useful when your language has ways of declaring types without an actual implementation.
    nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
    -- Jump to the type of the word under your cursor. Useful when you're not sure what type a variable is and you want
    -- to see the definition of its *type*, not where it was *defined*.
    nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
    -- Fuzzy find all the symbols in your current document (variables, functions, types, etc.).
    nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
    -- Fuzzy find all the symbols in your current workspace.
    nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

    -- See `:help K` for why this keymap
    nmap("K", vim.lsp.buf.hover, "Hover Documentation")
    nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

    -- Lesser used LSP functionality
    nmap("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
    nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "[W]orkspace [A]dd Folder")
    nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "[W]orkspace [R]emove Folder")
    nmap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "[W]orkspace [L]ist Folders")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

-- document existing key chains
require("which-key").add({
    { "<leader>c", group = "[C]ode" },
    { "<leader>d", group = "[D]ocument" },
    { "<leader>r", group = "[R]ename" },
    { "<leader>s", group = "[S]earch" },
    { "<leader>w", group = "[W]orkspace" },
    { "<leader>t", group = "[T]oggle" },
    { "<leader>h", group = "Git [H]unk", mode = { "n", "v" } },
})

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require("mason").setup()
require("mason-lspconfig").setup({
    automatic_installation = true,
})

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property "filetypes" to the map in question.
local servers = {
    -- clangd = {},
    -- rust_analyzer = {},
    -- tsserver = {},
    bashls = {},
    docker_compose_language_service = {},
    dockerls = {},
    gopls = {
        cmd = { "gopls", "serve" },
        filetypes = { "go", "gomod", "gowork", "gotmpl" },
        settings = {
            gopls = {
                gofumpt = true,
                codelenses = {
                    gc_details = false,
                    generate = true,
                    regenerate_cgo = true,
                    run_govulncheck = true,
                    test = true,
                    tidy = true,
                    upgrade_dependency = true,
                    vendor = true,
                },
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                },
                analyses = {
                    fieldalignment = true,
                    nilness = true,
                    unusedparams = true,
                    unusedwrite = true,
                    useany = true,
                },
                usePlaceholders = true,
                completeUnimported = true,
                staticcheck = true,
                directoryFilters = { "-.git", "-.vscode", "-.idea", "-.vscode-test", "-node_modules" },
                semanticTokens = true,
            },
        },
    },
    helm_ls = {},
    html = { filetypes = { "html", "twig", "hbs" } },
    jsonls = {},
    -- https://microsoft.github.io/pyright/#/settings?id=pyright-settings
    pyright = {
        enabled = false,
        analyses = {
            autoImportCompletion = true,
            typeCheckingMode = "basic",
        },
    },
    -- basedpyright = {},
    tailwindcss = {
        filetypes = {
            "templ",
        },
        init_options = {
            userLanguages = {
                templ = "html",
            },
        },
    },
    templ = {},
    terraformls = {},
    yamlls = {
        settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
                completion = true,
                hover = true,
                validate = true,
                format = {
                    enable = true,
                },
                schemaStore = {
                    -- Must disable built-in schemaStore support to use
                    -- schemas from SchemaStore.nvim plugin
                    enable = true,
                    -- Avoid TypeError: Cannot read properties of undefined (reading "length")
                    url = "",
                },
                schemas = {
                    ["kubernetes"] = "*.{yaml,yml}",
                    -- JSON & YAML schemas http://schemastore.org/json/
                    ["https://json.schemastore.org/chart"] = "Chart.{yml,yaml}",
                    ["https://json.schemastore.org/circleciconfig"] = ".circleci/**/*.{yml,yaml}",
                    ["https://json.schemastore.org/github-action"] = ".github/action.{yml,yaml}",
                    ["https://json.schemastore.org/github-workflow"] = ".github/workflows/*.{yml,yaml}",
                    ["https://json.schemastore.org/kustomization.json"] = "kustomization.{yml,yaml}",
                    ["https://json.schemastore.org/prettierrc"] = ".prettierrc.{yml,yaml}",
                    ["https://json.schemastore.org/stylelintrc"] = ".stylelintrc.{yml,yaml}",
                },
            },
        },
    },
    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            diagnostics = { disable = { "missing-fields" } },
        },
    },
}

-- Setup neovim lua configuration
require("neodev").setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require("mason-lspconfig")

mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
})

mason_lspconfig.setup_handlers({
    function(server_name)
        require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
        })
    end,
})

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require("cmp")
local luasnip = require("luasnip")
luasnip.config.setup({})
require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end,
    },
    completion = {
        completeopt = "menu,menuone,noinsert",
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),
        ["<C-Space>"] = cmp.mapping.complete({}),
        ["<CR>"] = cmp.mapping.confirm({
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
        }),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),
    sources = {
        { name = "vsnip" },
        { name = "nvim_lsp" },
        -- { name = "luasnip" },
        { name = "buffer" },
    },
})

cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
        { name = "path" },
    }, {
        {
            name = "cmdline",
            option = {
                ignore_cmds = { "Man", "!" },
            },
        },
    }),
})

cmp.setup.cmdline("/", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
        { name = "buffer" },
    },
})

for _, ft_path in ipairs(vim.api.nvim_get_runtime_file("lua/snippets/*.lua", true)) do
    loadfile(ft_path)()
end
