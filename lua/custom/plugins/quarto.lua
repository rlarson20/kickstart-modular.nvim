-- plugins/quarto.lua
-- https://quarto.org/docs/get-started/hello/neovim.html
-- https://github.com/quarto-dev/quarto-nvim
return {
  {
    'quarto-dev/quarto-nvim',
    dependencies = {
      'jmbuhr/otter.nvim',
      'nvim-treesitter/nvim-treesitter',
    },
  },
}
