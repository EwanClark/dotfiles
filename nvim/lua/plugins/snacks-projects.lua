return {
  "folke/snacks.nvim",
  opts = {
    projects = {
      enabled = true,
      -- what counts as a project root
      patterns = { ".git", "package.json", "pyproject.toml", "cargo.toml" },
      recent = true,
    },
  },
}
