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

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
