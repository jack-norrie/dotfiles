return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- add any opts here
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },

    -- By default config is passed require("avante").setup(*opts)
    -- We leave opts blank above and explicitly define opts below
    -- This allows us to add custom key retrieval logic after the
    -- plugin setup has been run, this is not possible with simple
    -- opts.
    config = function()
      require("avante").setup({
        mode = "legacy",
        disable_tools = true,
        disabled_tools = { "python", "run_python", "bash", "git_commit" },
        providers = {
          claude = {
            endpoint = "https://api.anthropic.com",
            model = "claude-sonnet-4-20250514",
            timeout = 30000, -- Timeout in milliseconds
            extra_request_body = {
              temperature = 0,
              max_tokens = 4096,
            },
          },
        },
      })
      --
      -- Retrieve the API key and set it directly in Lua
      local handle = io.popen("pass show dev/llm/anthropic")
      if handle then
        local api_key = handle:read("*a")
        handle:close()
        -- Trim any whitespace
        api_key = api_key:gsub("^%s*(.-)%s*$", "%1")
        -- Set the environment variable within Neovim
        vim.env.ANTHROPIC_API_KEY = api_key
      else
        print("Failed to retrieve Anthropic API key")
      end
    end,
  },
}
