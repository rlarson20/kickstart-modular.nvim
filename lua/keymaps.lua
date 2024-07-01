-- Sources for some of this code
--
-- https://github.com/m4xshen/dotfiles/blob/main/nvim/nvim/lua/config/mappings.lua
-- https://github.com/leonasdev/.dotfiles/blob/master/.config/nvim/lua/leonasdev/keymaps.lua
-- https://github.com/brainfucksec/neovim-lua/blob/main/nvim/lua/core/keymaps.lua

-- MOST IMPORTANT MAP:
-- Map helper function

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.keymap.set(mode, lhs, rhs, options)
end

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

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
map('n', '<leader>s', ':w<CR>', { desc = 'Save file' })
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

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- vim: ts=2 sts=2 sw=2 et
