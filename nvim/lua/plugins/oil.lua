return {
  "stevearc/oil.nvim",
  lazy = true,
  cmd = "Oil",
  init = function()
    vim.api.nvim_create_autocmd("BufEnter", {
      group = vim.api.nvim_create_augroup("oil-start", { clear = true }),
      callback = function()
        local bufname = vim.api.nvim_buf_get_name(0)
        if vim.fn.isdirectory(bufname) == 1 then
          vim.defer_fn(function()
            require("oil").open(bufname)
          end, 0)
        end
      end,
    })
  end,
  opts = {
    default_file_explorer = true,
    view_options = {
        show_hidden = true,
        },
    keymaps = {
      ["yp"] = {
        callback = function()
          require("oil.actions").copy_entry_path.callback()
          vim.fn.setreg("+", vim.fn.getreg(vim.v.register))
          vim.notify("Copied full path", vim.log.levels.INFO, { title = "Oil" })
        end,
        desc = "Copy filepath to system clipboard",
      },
    },
    keys = {
      {
        "<leader>pv",
        "<cmd>Oil<CR>",
        desc = "Open Oil file explorer",
        mode = "n",
      },
    },
  },
}
