require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "c",
    "lua",
    "rust",
    "vim",
    "yaml",
    "json",
    "html",
    "css",
    "javascript",
    "typescript",
    "go",
    "python",
    "bash",
    "toml",
    "markdown",
    "hcl",
    "dockerfile",
    "regex",
    "terraform",
  },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = true,
  auto_install = true,
  highlight = {
    enable = true,
  },
}
