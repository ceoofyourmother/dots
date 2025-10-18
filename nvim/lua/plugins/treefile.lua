return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      hidden = true,
      ignored = true,
      exclude = {
        ".github",
        ".idea",
        ".turbo",
        ".git",
        ".direnv",
        "node_modules",
        ".editorconfig",
        ".envrc",
        ".npmrc",
        ".prettierignore",
        ".next",
      },
    },
  },
}
