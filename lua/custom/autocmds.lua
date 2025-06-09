local my_autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`
-- Highlight when yanking (copying) text
local yank = augroup('yank', { clear = true })
my_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'Visual', timeout = 200 }
  end,
  group = yank,
})

-- Formatting options
local format_options = augroup('Format Options', { clear = true })
my_autocmd('FileType', {
  callback = function()
    vim.opt_local.formatoptions = vim.opt_local.formatoptions
      - 't' -- Linters exist for a reason.
      + 'c' -- In general, I like it when comments respect textwidth
      + 'r' -- But do continue when pressing enter.
      - 'o' -- O and o, don't continue comments
      + '/' -- don't insert comment leader for // comment after statment, only at start of line
      + 'q' -- Allow formatting comments w/ gq
      + 'w' -- trailing whitespace === continues on next line
      - 'a' -- Don't autoformat.
      + 'n' -- Indent past the formatlistpat, not underneath it.
      - '2' -- I'm not in gradeschool anymore
      + 'j' -- Auto-remove comments if possible.
  end,
  group = format_options,
})

-- quit common plugins with q? might not need this but worth checking out
-- Use 'q' to quit from common plugins
my_autocmd('FileType', {
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
my_autocmd('BufWinLeave', {
  pattern = '*.*',
  callback = function()
    vim.cmd.mkview()
  end,
  group = save_fold,
})
my_autocmd('BufWinEnter', {
  pattern = '*.*',
  callback = function()
    vim.cmd.loadview { mods = { emsg_silent = true } }
  end,
  group = save_fold,
})

my_autocmd('LspAttach', {
  group = augroup('lsp_attach_disable_ruff_hover', { clear = true }),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client == nil then
      return
    end
    if client.name == 'ruff' then
      -- Disable hover in favor of Pyright
      client.server_capabilities.hoverProvider = false
    end
  end,
  desc = 'LSP: Disable hover capability from Ruff',
})
