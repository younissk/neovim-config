require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- DAP (debugger) keymaps
map("n", "<leader>db", function() require("dap").toggle_breakpoint() end, { desc = "DAP Toggle breakpoint" })
map("n", "<leader>dc", function() require("dap").continue() end, { desc = "DAP Continue" })
map("n", "<leader>do", function() require("dap").step_over() end, { desc = "DAP Step over" })
map("n", "<leader>di", function() require("dap").step_into() end, { desc = "DAP Step into" })
map("n", "<leader>du", function() require("dapui").toggle() end, { desc = "DAP Toggle UI" })

-- Neotest keymaps
map("n", "<leader>tr", function() require("neotest").run.run() end, { desc = "Test Run nearest" })
map("n", "<leader>tf", function() require("neotest").run.run(vim.fn.expand "%") end, { desc = "Test Run file" })
map("n", "<leader>ts", function() require("neotest").summary.toggle() end, { desc = "Test Summary" })

-- Python runner: uses uv run if available, falls back to .venv, then system python
map("n", "<F5>", function()
  local file = vim.fn.expand "%:p"
  local cwd = vim.fn.getcwd()
  -- exepath first, so a uv from brew or the system also counts; ~/.local/bin
  -- is only where the standalone installer happens to put it. Never a literal
  -- home path — this config runs on machines with a different $HOME.
  local uv = vim.fn.exepath "uv"
  if uv == "" then
    uv = vim.fn.expand "~/.local/bin/uv"
  end
  local cmd

  if vim.fn.executable(uv) == 1 and (vim.fn.isdirectory(cwd .. "/.venv") == 1 or vim.fn.filereadable(cwd .. "/pyproject.toml") == 1) then
    cmd = uv .. " run python " .. vim.fn.shellescape(file)
  elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
    cmd = cwd .. "/.venv/bin/python " .. vim.fn.shellescape(file)
  else
    cmd = "python3 " .. vim.fn.shellescape(file)
  end

  -- Open a bottom terminal split and run
  vim.cmd "botright 15split"
  vim.fn.termopen(cmd, { cwd = cwd })
  vim.cmd "startinsert"
end, { desc = "Python Run file" })


