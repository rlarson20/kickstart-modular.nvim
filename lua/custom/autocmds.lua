local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
-- Highlight when yanking (copying) text
local yank = augroup('yank', { clear = true })
autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual', timeout = 200 }
  end,
  group = yank,
})

-- Formatting options
local format_options = augroup('Format Options', { clear = true })
autocmd('FileType', {
  callback = function()
    vim.opt_local.formatoptions = vim.opt_local.formatoptions
      - 'a' -- Don't autoformat.
      - 't' -- Linters exist for a reason.
      + 'c' -- In general, I like it when comments respect textwidth
      + 'q' -- Allow formatting comments w/ gq
      - 'o' -- O and o, don't continue comments
      + 'r' -- But do continue when pressing enter.
      + 'n' -- Indent past the formatlistpat, not underneath it.
      + 'j' -- Auto-remove comments if possible.
      - '2' -- I'm not in gradeschool anymore
  end,
  group = format_options,
})

-- quit common plugins with q? might not need this but worth checking out
-- Use 'q' to quit from common plugins
autocmd('FileType', {
  pattern = {
    'help',
    'man',
    'lspinfo',
    'trouble',
    'qf',
    'help',
    'notify',
    'startuptime',
  },
  callback = function(event)
    vim.opt_local.wrap = false
    vim.bo[event.buf].buflisted = false
    vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true })
  end,
})

-- Persistent Folds
local save_fold = augroup('Persistent Folds', { clear = true })
autocmd('BufWinLeave', {
  pattern = '*.*',
  callback = function()
    vim.cmd.mkview()
  end,
  group = save_fold,
})
autocmd('BufWinEnter', {
  pattern = '*.*',
  callback = function()
    vim.cmd.loadview { mods = { emsg_silent = true } }
  end,
  group = save_fold,
})
