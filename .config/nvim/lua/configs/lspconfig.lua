require("nvchad.configs.lspconfig").defaults()

vim.lsp.enable { "html", "cssls", "ts_ls", "eslint", "emmet_ls", "clangd", "omnisharp" }

vim.diagnostic.config {
  update_in_insert = true,
  virtual_text = { spacing = 4, prefix = "●" },
  underline = true,
  severity_sort = true,
}

vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)

    vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = args.buf, desc = "LSP code action" })

    if client and client.name == "eslint" then
      vim.api.nvim_create_autocmd("BufWritePre", {
        buffer = args.buf,
        command = "EslintFixAll",
      })
    end
  end,
})
