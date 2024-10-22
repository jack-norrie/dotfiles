if true then
  return {
    {
      "jackMort/ChatGPT.nvim",
      event = "VeryLazy",
      config = function()
        require("chatgpt").setup({
          api_key_cmd = "pass show llm/chatgpt",
          openai_params = {
            max_tokens = 1028,
          },
        })
      end,
      dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
        "folke/trouble.nvim",
        "nvim-telescope/telescope.nvim",
      },
    },
    {
      "folke/which-key.nvim",
      opts = {
        defaults = {
          ["<leader>p"] = {
            name = "ChatGPT",
            mode = { "n", "v" },
            c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
            e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction" },
            g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction" },
            t = { "<cmd>ChatGPTRun translate<CR>", "Translate" },
            k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords" },
            d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring" },
            a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests" },
            o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code" },
            s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize" },
            f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs" },
            x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code" },
            r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit" },
            l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis" },
          },
        },
      },
    },
  }
else
  return {}
end
