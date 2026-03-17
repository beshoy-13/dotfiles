return {
  -- ── Formatter (conform) ───────────────────────────────────────
  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- format on save
    opts = require "configs.conform",
  },

  -- ── LSP ───────────────────────────────────────────────────────
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- ── Mason: auto-install web LSPs + formatters ─────────────────
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "html-lsp",
        "css-lsp",
        "typescript-language-server",
        "eslint-lsp",
        "emmet-ls",
        "prettierd",
        "stylua",
      },
    },
  },

  -- ── Emmet  (! + Tab = boilerplate, div.x>p*3 + Tab = expand) ──
  {
    "mattn/emmet-vim",
    ft = {
      "html",
      "css",
      "scss",
      "sass",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
    },
    init = function()
      vim.g.user_emmet_leader_key = "<C-y>"
      vim.g.user_emmet_mode = "inv"
      vim.g.user_emmet_expandabbr_key = "<Tab>"
      vim.g.user_emmet_settings = {
        html = {
          snippets = {
            ["!"] = "<!DOCTYPE html>\n"
              .. '<html lang="en">\n'
              .. "<head>\n"
              .. '  <meta charset="UTF-8">\n'
              .. '  <meta name="viewport" content="width=device-width, initial-scale=1.0">\n'
              .. "  <title>${1:Document}</title>\n"
              .. "</head>\n"
              .. "<body>\n"
              .. "  ${0}\n"
              .. "</body>\n"
              .. "</html>",
          },
        },
        css = { filters = "fc" },
        scss = { extends = "css" },
        javascriptreact = { extends = "jsx" },
        typescriptreact = { extends = "jsx" },
      }
    end,
  },

  -- ── Auto-close & rename HTML/JSX tags ─────────────────────────
  {
    "windwp/nvim-ts-autotag",
    ft = {
      "html",
      "xml",
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "vue",
      "svelte",
      "markdown",
    },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      opts = {
        enable_close = true,
        enable_rename = true,
        enable_close_on_slash = true,
      },
    },
  },

  -- ── Auto-pairs  ( → ()  " → ""  etc. ─────────────────────────
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      local autopairs = require "nvim-autopairs"
      autopairs.setup {
        check_ts = true,
        fast_wrap = { map = "<M-e>" },
      }
      local ok, cmp = pcall(require, "cmp")
      if ok then
        local cmp_ap = require "nvim-autopairs.completion.cmp"
        cmp.event:on("confirm_done", cmp_ap.on_confirm_done())
      end
    end,
  },

  -- ── Inline color swatches  #hex / rgb() / tailwind ───────────
  {
    "NvChad/nvim-colorizer.lua",
    ft = { "html", "css", "scss", "javascript", "typescript", "vue", "svelte" },
    opts = {
      user_default_options = {
        css = true,
        css_fn = true,
        tailwind = true,
        mode = "background",
      },
    },
  },
}
