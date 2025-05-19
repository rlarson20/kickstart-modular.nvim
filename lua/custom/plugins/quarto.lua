-- plugins/quarto.lua
-- https://quarto.org/docs/get-started/hello/neovim.html
-- https://github.com/quarto-dev/quarto-nvim
-- https://quarto.org/
return {
  {
    'quarto-dev/quarto-nvim',
    ft = 'quarto',
    dependencies = {
      'jmbuhr/otter.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
    enabled = false,
  },
}
