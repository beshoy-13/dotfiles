require "nvchad.mappings"

-- =========================================
-- 🗺️ Custom Mappings
-- =========================================
local map = vim.keymap.set
local nomap = vim.keymap.del

-- ── General ──────────────────────────────
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>", { desc = "Escape insert mode" })

-- Save
map({ "n", "i", "v" }, "<C-s>", "<cmd>w<CR>", { desc = "Save file" })

-- Select all
map("n", "<C-a>", "gg<S-v>G", { desc = "Select all" })

-- ── Window navigation ─────────────────────
-- (NvChad already has Ctrl+h/j/k/l for pane switching)

-- Better indenting — stay in visual mode after indent
map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })

-- Move selected lines up/down in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- ── VSCode-style Line Move & Duplicate ───
-- Alt+Down / Alt+Up → move line (normal mode)
map("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
map("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })

-- Alt+Down / Alt+Up → move line (insert mode)
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })

-- Alt+Down / Alt+Up → move selection (visual mode)
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- Shift+Alt+Down / Shift+Alt+Up → duplicate line (normal mode)
map("n", "<S-A-Down>", ":co .<CR>", { desc = "Duplicate line down" })
map("n", "<S-A-Up>", ":co .-1<CR>", { desc = "Duplicate line up" })

-- Shift+Alt+Down / Shift+Alt+Up → duplicate line (insert mode)
map("i", "<S-A-Down>", "<Esc>:co .<CR>==gi", { desc = "Duplicate line down" })
map("i", "<S-A-Up>", "<Esc>:co .-1<CR>==gi", { desc = "Duplicate line up" })

-- Shift+Alt+Down / Shift+Alt+Up → duplicate selection (visual mode)
map("v", "<S-A-Down>", "y'>p`[v`]", { desc = "Duplicate selection down" })
map("v", "<S-A-Up>", "y'<P`[v`]", { desc = "Duplicate selection up" })

-- ── Terminal ──────────────────────────────
map("t", "<C-q>", "<C-\\><C-n>:bdelete!<CR>", { desc = "Close terminal" })

-- ── Language-aware Compile & Run ──────────
local run_buf = nil

local function compile()
  vim.cmd "w"
  local ft = vim.bo.filetype
  local file = vim.fn.expand "%"
  local output = vim.fn.expand "%:r"

  local cmd = ""
  if ft == "c" then
    cmd = "gcc " .. file .. " -Wall -O2 -o " .. output
  elseif ft == "cpp" then
    cmd = "g++ " .. file .. " -std=c++20 -Wall -O2 -o " .. output
  elseif ft == "java" then
    cmd = "javac " .. file
  else
    vim.notify("No compile step for filetype: " .. ft, vim.log.levels.WARN)
    return
  end

  vim.cmd("split | terminal " .. cmd)
  local buf = vim.api.nvim_get_current_buf()

  vim.api.nvim_create_autocmd("TermClose", {
    buffer = buf,
    once = true,
    callback = function()
      local exit_code = vim.v.event.status
      if exit_code == 0 then
        vim.schedule(function()
          if vim.api.nvim_buf_is_valid(buf) then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end)
      else
        vim.schedule(function()
          vim.notify("Compilation failed. Press any key to close...", vim.log.levels.ERROR)
          vim.fn.getchar()
          if vim.api.nvim_buf_is_valid(buf) then
            vim.api.nvim_buf_delete(buf, { force = true })
          end
        end)
      end
    end,
  })
end

local function run()
  local ft = vim.bo.filetype
  local file = vim.fn.expand "%"
  local output = vim.fn.expand "%:r"

  local cmd = ""
  if ft == "c" or ft == "cpp" then
    cmd = "./" .. output
  elseif ft == "python" then
    cmd = "python3 " .. file
  elseif ft == "java" then
    cmd = "java " .. output
  else
    vim.notify("No run command for filetype: " .. ft, vim.log.levels.WARN)
    return
  end

  if run_buf and vim.api.nvim_buf_is_valid(run_buf) then
    vim.api.nvim_buf_delete(run_buf, { force = true })
  end

  vim.cmd("split | terminal " .. cmd)
  run_buf = vim.api.nvim_get_current_buf()
end

map("n", "<leader>cc", compile, { desc = "Compile current file" })
map("n", "<leader>cr", run, { desc = "Run current file" })

map("n", "<leader>cb", function()
  compile()
  vim.defer_fn(run, 500)
end, { desc = "Compile + Run (Build)" })

-- ── Web Dev ───────────────────────────────
map("n", "<leader>wf", function()
  require("conform").format { async = true, lsp_fallback = true }
end, { desc = "Format file (Prettier)" })

map("n", "<leader>we", "<cmd>EslintFixAll<CR>", { desc = "ESLint fix all" })

map("n", "<leader>ws", function()
  vim.fn.jobstart({ "xdg-open", vim.fn.expand "%:p" }, { detach = true })
end, { desc = "Open in browser" })

map("n", "<leader>wt", function()
  local tag = vim.fn.input "Wrap with tag: "
  if tag ~= "" then
    vim.cmd(string.format("normal! ysiw<%s>", tag))
  end
end, { desc = "Wrap word in HTML tag" })

map("n", "<C-S-k>", '"_dd', { desc = "Delete line (no yank)" })
map("n", "<C-d>", "*``cgn", { desc = "Change next occurrence" })

-- ── NvimTree Resize (REVERSED) ────────────
map("n", "<C-Left>", ":NvimTreeResize +5<CR>", { desc = "NvimTree grow" })
map("n", "<C-Right>", ":NvimTreeResize -5<CR>", { desc = "NvimTree shrink" })
