return {
  'GeorgesAlkhouri/nvim-aider',
  cmd = {
    'AiderTerminalToggle',
    'AiderHealth',
  },
  keys = {
    { '<leader>a/', '<cmd>AiderTerminalToggle<cr>', desc = 'Open Aider' },
    { '<leader>as', '<cmd>AiderTerminalSend<cr>', desc = 'Send to Aider', mode = { 'n', 'v' } },
    { '<leader>ac', '<cmd>AiderQuickSendCommand<cr>', desc = 'Send Command To Aider' },
    { '<leader>ab', '<cmd>AiderQuickSendBuffer<cr>', desc = 'Send Buffer To Aider' },
    { '<leader>a+', '<cmd>AiderQuickAddFile<cr>', desc = 'Add File to Aider' },
    { '<leader>a-', '<cmd>AiderQuickDropFile<cr>', desc = 'Drop File from Aider' },
    { '<leader>ar', '<cmd>AiderQuickReadOnlyFile<cr>', desc = 'Add File as Read-Only' },
    -- Example nvim-tree.lua integration if needed: not bc i use neotree
    -- { '<leader>a+', '<cmd>AiderTreeAddFile<cr>', desc = 'Add File from Tree to Aider', ft = 'NvimTree' },
    -- { '<leader>a-', '<cmd>AiderTreeDropFile<cr>', desc = 'Drop File from Tree from Aider', ft = 'NvimTree' },
  },
  dependencies = {
    'folke/snacks.nvim',
    --- The below dependencies are optional
    'catppuccin/nvim',
    --- Neo-tree integration
    {
      'nvim-neo-tree/neo-tree.nvim',
      opts = function(_, opts)
        -- Example mapping configuration (already set by default)
        opts.window = {
          mappings = {
            ['+'] = { 'nvim_aider_add', desc = 'add to aider' },
            ['-'] = { 'nvim_aider_drop', desc = 'drop from aider' },
          },
        }
        require('nvim_aider.neo_tree').setup(opts)
      end,
    },
  },
  config = true,
}
