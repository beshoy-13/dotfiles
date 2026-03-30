return {

  -- ══════════════════════════════════════════════════════════════
  --  FORMATTING
  -- ══════════════════════════════════════════════════════════════

  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },

  -- ══════════════════════════════════════════════════════════════
  --  LSP & LANGUAGE SERVERS
  -- ══════════════════════════════════════════════════════════════

  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- web
        "html-lsp",
        "css-lsp",
        "typescript-language-server",
        "eslint-lsp",
        "emmet-ls",
        "prettierd",
        -- lua
        "stylua",
        -- c / c++
        "clangd",
        "clang-format",
      },
    },
  },

  -- ══════════════════════════════════════════════════════════════
  --  SNIPPETS
  --  triggers (type keyword + Tab to expand):
  --    cpp    →  C++ boilerplate  (#include iostream, main, return 0)
  --    cmain  →  C  boilerplate   (#include stdio, main, return 0)
  --    jmain  →  Java boilerplate (Scanner, class, main, sc.close)
  --    pymain →  Python boilerplate (def main + __name__ guard)
  -- ══════════════════════════════════════════════════════════════

  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      local ls = require "luasnip"
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      -- load VS Code-style snippets from friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- ── C++ ───────────────────────────────────────────────────
      ls.add_snippets("cpp", {
        s("cpp", {
          t {
            "#include <iostream>",
            "",
            "using namespace std;",
            "",
            "int main() {",
            "    ",
          },
          i(1, "// code here"),
          t {
            "",
            "    return 0;",
            "}",
          },
        }),
      })

      -- ── C ─────────────────────────────────────────────────────
      ls.add_snippets("c", {
        s("cmain", {
          t {
            "#include <stdio.h>",
            "#include <stdlib.h>",
            "",
            "int main() {",
            "    ",
          },
          i(1, "// code here"),
          t {
            "",
            "    return 0;",
            "}",
          },
        }),
      })

      -- ── Java ──────────────────────────────────────────────────
      ls.add_snippets("java", {
        s("jmain", {
          t { "import java.util.Scanner;", "", "public class " },
          i(1, "Main"),
          t {
            " {",
            "    public static void main(String[] args) {",
            "        Scanner sc = new Scanner(System.in);",
            "        ",
          },
          i(2, "// code here"),
          t {
            "",
            "        sc.close();",
            "    }",
            "}",
          },
        }),
      })

      -- ── Python ────────────────────────────────────────────────
      ls.add_snippets("python", {
        s("pymain", {
          t {
            "def main():",
            "    ",
          },
          i(1, "# code here"),
          t {
            "",
            "",
            'if __name__ == "__main__":',
            "    main()",
          },
        }),
      })

      -- ── Tab: expand snippet or jump to next stop ───────────────
      vim.keymap.set({ "i", "s" }, "<Tab>", function()
        if ls.expand_or_jumpable() then
          ls.expand_or_jump()
        else
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
        end
      end, { silent = true })

      -- ── Shift-Tab: jump to previous stop ──────────────────────
      vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
        if ls.jumpable(-1) then
          ls.jump(-1)
        end
      end, { silent = true })
    end,
  },

  -- ══════════════════════════════════════════════════════════════
  --  HTML / JSX
  -- ══════════════════════════════════════════════════════════════

  -- Emmet  (! + Tab = HTML boilerplate,  div.x>p*3 + Tab = expand)
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

  -- Auto-close & rename HTML/JSX tags
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

  -- ══════════════════════════════════════════════════════════════
  --  EDITING QUALITY OF LIFE
  -- ══════════════════════════════════════════════════════════════

  -- Auto-pairs  ( → ()   " → ""   { → {}   etc.
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

  -- Inline color swatches for  #hex / rgb() / tailwind classes
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

  -- ══════════════════════════════════════════════════════════════
  --  DIAGNOSTICS & PROJECT HEALTH
  -- ══════════════════════════════════════════════════════════════

  -- Highlight TODO / FIXME / NOTE / HACK / BUG / WARN in every file
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- Clean diagnostics panel
  --   <leader>xx  →  all project diagnostics
  --   <leader>xb  →  current buffer only
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
      { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (project)" },
      { "<leader>xb", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Diagnostics (buffer)" },
    },
    opts = {},
  },
}
