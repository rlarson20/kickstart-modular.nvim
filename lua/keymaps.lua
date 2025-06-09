-- Sources for some of this code
--
-- https://github.com/m4xshen/dotfiles/blob/main/nvim/nvim/lua/config/mappings.lua
-- https://github.com/leonasdev/.dotfiles/blob/master/.config/nvim/lua/leonasdev/keymaps.lua

-- MOST IMPORTANT MAP:
-- Map helper function

local function map(modes, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  if type(modes) == 'string' then
    modes = { modes }
  end
  for _, mode in ipairs(modes) do
    vim.keymap.set(mode, lhs, rhs, options)
  end
end

-- Lazy
map('n', '<leader>l', ':Lazy<CR>', { desc = 'Lazy' })

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- better up/down
map({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true })
map({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
map('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
map('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
map('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
map('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
-- is not what someone will guess without a bit more experience.
--
-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
-- or just use <C-\><C-n> to exit terminal mode
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TODO: have like
-- 4 diff ways of moving around
-- compress them into two total
-- need one for switching focus and one for moving the window
--
-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- Map esc to jj, kk, jk
map('i', 'jj', '<Esc>')
map('i', 'kk', '<Esc>')
map('i', 'jk', '<Esc>')

-- more split stuff: Switch split orientation
map('n', '<leader>tk', '<C-w>t<C-w>K', { desc = 'Change vertical to horizontal' })
map('n', '<leader>th', '<C-w>t<C-w>H', { desc = 'Change horizontal to vertical' })

-- Fast Save
-- map('n', '<leader>S', ':w<CR>', { desc = 'Save file' })
-- Reload config
map('n', '<leader>R', ':so %<CR>', { desc = 'Reload config file' })
-- Close ALL WINDOWS
map('n', '<leader>q', ':qa!<CR>', { desc = 'Close ALL WINDOWS' })

-- Smart insert in blank line (auto indent)
map('n', 'i', function()
  if #vim.fn.getline '.' == 0 then
    return [["_cc]]
  else
    return 'i'
  end
end, { expr = true })

-- Don't add blank lines into default register
map('n', 'dd', function()
  if vim.api.nvim_get_current_line():match '^%s*$' then
    return '"_dd'
  else
    return 'dd'
  end
end, { expr = true })

-- Leader movements
map('n', '<Leader>v', ':cd ~/.config/nvim/<CR>:Telescope find_files<CR>', { desc = 'Go to file in nvim config' })
-- map('n', '<Leader>m', ':make<CR>', { desc = 'Make file' })

-- TODO: add this stuff
-- system clipboard
-- map({ "n", "v" }, "<Leader>y", '"+y', {})
-- map({ "n" }, "<Leader>Y", '"+y$', {})
-- map({ "n", "v" }, "<Leader>p", '"+p', {})
-- map({ "n", "v" }, "<Leader>P", '"+P', {})

-- increment/decrement values
map('n', '+', '<C-a>')
map('n', '-', '<C-x>')

-- open github link
map('n', '<Leader>gg', function()
  local selection = vim.fn.getline '.'
  local cur = vim.api.nvim_win_get_cursor(0)
  local path = 'https://github.com/' .. string.match(selection, '[%w%-%.]+/[%w%-%.]+')
  vim.ui.open(path)
end, { desc = 'Open github string' })

--toggle context
map('n', '<Leader>tc', ':TSContextToggle<CR>', { desc = 'Toggle Treesitter Context' })

--copy file path
map('n', '<leader>cp', function()
  vim.fn.setreg('+', vim.api.nvim_buf_get_name(0))
end, { desc = 'Copy file path to clipboard' })

-- Gen.nvim keymaps
-- Gen default
map({ 'n', 'v' }, '<leader>]', ':Gen<CR>')
map({ 'n', 'v' }, '<leader>gch', ':Gen Chat<CR>')
-- specific prompts
map('v', '<leader>gcg', ':Gen Change<CR>')
map('v', '<leader>ga', ':Gen Ask<CR>')
map('v', '<leader>egs', ':Gen Enhance_Grammar_Spelling<CR>')
map('v', '<leader>gs', ':Gen Summarize<CR>')
map('v', '<leader>ew', ':Gen Enhance_Wording<CR>')
map('v', '<leader>mc', ':Gen Make_Concise<CR>')
map('v', '<leader>ml', ':Gen Make_List<CR>')
map('v', '<leader>mt', ':Gen Make_Table<CR>')
map('v', '<leader>rc', ':Gen Review_Code<CR>')
map('v', '<leader>ec', ':Gen Enhance_Code<CR>')
map('v', '<leader>cc', ':Gen Change_Code<CR>')

-- keymap to
map('n', '<leader>pl', function()
  local clipboard = vim.fn.getreg '+'
  local link_text = '[](' .. clipboard .. ')'
  vim.cmd 'normal o'
  local cursor_pos = vim.api.nvim_win_get_cursor(0)
  local row, col = cursor_pos[1], cursor_pos[2]

  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { link_text })
  vim.api.nvim_win_set_cursor(0, { row, col + 1 })
  vim.cmd 'startinsert'
end, { desc = 'Paste Markdown Link and Title It' })
-- vim: ts=2 sts=2 sw=2 et
map('n', '<leader>fm', ':OT2MDL<CR>', { desc = 'Convert OneTab lists to Markdown links' })

--yank, comment out and paste
-- Duplicate selection and comment out the first instance.
function _G.duplicate_and_comment_lines()
  local start_line, end_line = vim.api.nvim_buf_get_mark(0, '[')[1], vim.api.nvim_buf_get_mark(0, ']')[1]

  -- NOTE: `nvim_buf_get_mark()` is 1-indexed, but `nvim_buf_get_lines()` is 0-indexed. Adjust accordingly.
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)

  -- Store cursor position because it might move when commenting out the lines.
  local cursor = vim.api.nvim_win_get_cursor(0)

  -- Comment out the selection using the mini.comment function to make . repeatable
  require('mini.comment').toggle_lines(start_line, end_line)

  -- Append a duplicate of the selected lines to the end of selection.
  vim.api.nvim_buf_set_lines(0, end_line, end_line, false, lines)

  -- Move cursor to the start of the duplicate lines.
  vim.api.nvim_win_set_cursor(0, { end_line + 1, cursor[2] })
end

vim.keymap.set({ 'n', 'x' }, 'yc', function()
  vim.opt.operatorfunc = 'v:lua.duplicate_and_comment_lines'
  return 'g@'
end, { expr = true, desc = 'Duplicate selection and comment out the first instance' })

vim.keymap.set('n', 'ycc', function()
  vim.opt.operatorfunc = 'v:lua.duplicate_and_comment_lines'
  return 'g@_'
end, { expr = true, desc = 'Duplicate [count] lines and comment out the first instance' })

-- Automatically add semicolon or comma at the end of the line in INSERT and NORMAL modes
map('i', ';;', '<ESC>A;')
map('i', ',,', '<ESC>A,')
map('n', ';;', 'A;<ESC>')
map('n', ',,', 'A,<ESC>')
