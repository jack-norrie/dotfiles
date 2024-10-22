-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Run current Python file
vim.keymap.set("n", "<leader>c<CR>", function()
  local cwd = vim.fn.getcwd()
  vim.cmd("write")

  -- Check if tmux is available
  if vim.fn.executable("tmux") == 1 and vim.fn.environ()["TMUX"] ~= "" then
    -- Run in tmux window
    local window_name = "run_term" -- Replace with your desired window name
    local tmux_command =
      string.format("tmux select-window -t %s 2>/dev/null || tmux new-window -n %s", window_name, window_name)
    vim.fn.system(tmux_command)

    local python_command = string.format("PYTHONPATH='%s' python '%s'", cwd, vim.fn.expand("%:p"))
    vim.fn.system(string.format("tmux send-keys -t %s '%s' Enter", window_name, python_command))
  else
    -- Fallback to terminal if tmux is not available
    vim.cmd('terminal PYTHONPATH="' .. cwd .. '" python %')
  end
end, { noremap = true, silent = true, desc = "Run Current Python File" })
