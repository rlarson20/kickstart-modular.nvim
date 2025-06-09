-- Set <space> as the leader key
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- gets python checkhealth off my ass
vim.g.python3_host_prog = vim.fn.expand '~/src/venv/Neovim/bin/python3'

-- load keymaps, options, autocmds
require 'options'

--TODO: refactor/move
require 'custom.autocmds'
require 'custom.usercmds'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

--
-- first load run
-- line 67 of dreamsofcode init.lua, if firstload then install all mason packs,
-- for k,v in pairs(vim.g.mason_binaries_list) do packages[k] = v end
-- checks installs
-- some kind of buf-refresh thing

-- finally add keymaps
require 'keymaps'
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
