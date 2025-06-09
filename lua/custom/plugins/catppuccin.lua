return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000, --make sure to load this first
    opts = {
      transparent_background = true,
      flavour = 'mocha',
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        notify = true,
        markdown = true,
        flash = true,
        -- harpoon = true,
        indent_blankline = {
          enabled = true,
          scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
          colored_indent_levels = false,
        },
        mason = true,
        neotree = true,
        noice = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
            ok = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },
            ok = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
        render_markdown = true,
        snacks = {
          enabled = false,
          indent_scope_color = '', -- catppuccin color (eg. `lavender`) Default: text
        },
        telescope = { enabled = true },
        which_key = true,
      },
    },
    init = function()
      -- Load the colorscheme here.
      -- Like many other themes, this one has different styles, and you could load any other.
      vim.cmd.colorscheme 'catppuccin'

      -- You can configure highlights by doing something like:
      --vim.cmd.hi 'Comment gui=none'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
