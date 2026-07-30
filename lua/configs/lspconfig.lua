-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = {
  "html",
  "cssls",
  "ts_ls",
  -- "denols"
}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- Configure ruff LSP
lspconfig.ruff.setup {
  cmd = { "ruff", "server" },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
}

-- pyright with virtualenv awareness
local pyright_cmd = vim.fn.exepath "pyright-langserver"
if pyright_cmd == "" then
  pyright_cmd = vim.fn.expand "~/.local/bin/pyright-langserver"
end
lspconfig.pyright.setup {
  cmd = { pyright_cmd, "--stdio" },
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  before_init = function(_, config)
    -- Point pyright at the uv venv python for the current project
    local venv_python = (config.root_dir or vim.fn.getcwd()) .. "/.venv/bin/python"
    if vim.fn.executable(venv_python) == 1 then
      config.settings.python.pythonPath = venv_python
    end
  end,
  settings = {
    python = {
      analysis = {
        autoSearchPaths = true,
        useLibraryCodeForTypes = true,
        diagnosticMode = "workspace",
      },
      venvPath = ".",
      venv = ".venv",
    },
  },
}

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
