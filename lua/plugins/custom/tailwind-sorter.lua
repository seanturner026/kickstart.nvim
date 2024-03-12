return {
  "laytan/tailwind-sorter.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-lua/plenary.nvim" },
  build = "cd formatter && npm i && npm run build",
  config = function()
    require("tailwind-sorter").setup({
      on_save_enabled = true,
      on_save_pattern = {
        "*.astro",
        "*.hbs",
        "*.heex",
        "*.html",
        "*.js",
        "*.jsx",
        "*.php",
        "*.tsx",
        "*.twig",
      },       -- The file patterns to watch and sort.
      node_path = "node",
    })
  end,
}
