return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, --make sure to load this first
    opts = { flavour = 'mocha' },
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load any other.
      vim.cmd.colorscheme 'catppuccin'

      -- You can configure highlights by doing something like:
      --vim.cmd.hi 'Comment gui=none'
    end,
  },
}
