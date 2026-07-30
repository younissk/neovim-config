require "nvchad.options"

vim.opt.clipboard = "unnamedplus"
vim.opt.laststatus = 3
vim.opt.number = true
vim.opt.relativenumber = true

-- Ensure ~/.local/bin is in PATH so LSP servers installed there are found.
-- expand("~") rather than a literal home path: this config is vendored into
-- homebase and checked out on machines with a different $HOME, where a
-- hardcoded path silently does nothing.
vim.env.PATH = vim.env.PATH .. ":" .. vim.fn.expand "~/.local/bin"

