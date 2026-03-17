local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    html = { "prettierd", "prettier" },
    css = { "prettierd", "prettier" },
    scss = { "prettierd", "prettier" },
    javascript = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    json = { "prettierd", "prettier" },
    markdown = { "prettierd", "prettier" },
  },
  format_on_save = {
    timeout_ms = 1000,
    lsp_fallback = true,
  },
}

return options
