require("nvchad.configs.lspconfig").defaults()

-- Enable servers (NvChad's new API — no require("lspconfig") needed)
vim.lsp.enable { "html", "cssls", "ts_ls", "eslint", "emmet_ls" }

-- ESLint auto-fix on save
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.name == "eslint" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        command = "EslintFixAll",
      })
    end
  end,
})
