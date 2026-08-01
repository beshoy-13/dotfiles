return {
  {
    "mfussenegger/nvim-dap",
    lazy = false,
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require "dap"
      local dapui = require "dapui"

      dapui.setup()

      dap.adapters.coreclr = {
        type = "executable",
        command = vim.fn.exepath "netcoredbg",
        args = { "--interpreter=vscode" },
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "launch - netcoredbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end,
        },
      }

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      local map = vim.keymap.set
      map("n", "<leader>db", dap.toggle_breakpoint, { desc = "DAP toggle breakpoint" })
      map("n", "<leader>dc", dap.continue, { desc = "DAP continue/start" })
      map("n", "<leader>di", dap.step_into, { desc = "DAP step into" })
      map("n", "<leader>do", dap.step_over, { desc = "DAP step over" })
      map("n", "<leader>dO", dap.step_out, { desc = "DAP step out" })
      map("n", "<leader>dr", dap.repl.open, { desc = "DAP open REPL" })
      map("n", "<leader>du", dapui.toggle, { desc = "DAP toggle UI" })
    end,
  },
}
