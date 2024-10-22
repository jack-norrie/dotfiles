if true then
  return {
    {
      "stevearc/conform.nvim",
      opts = {
        formatters_by_ft = {
          python = { "isort", "black" },
        },
        formatters = {
          black = {
            prepend_args = { "--line-length", "120" },
          },
          isort = {
            prepend_args = { "--profile", "black" },
          },
        },
      },
    },
  }
else
  return {}
end
