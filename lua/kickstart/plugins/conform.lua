return {
  { -- Autoformat
    -- https://github.com/stevearc/conform.nvim
    'stevearc/conform.nvim',
    lazy = false,
    keys = {
      {
        '<leader>f',
        function()
          require('conform').format { async = true, lsp_fallback = true }
        end,
        mode = '',
        desc = '[F]ormat buffer',
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        return {
          timeout_ms = 500,
          lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
        }
      end,
      formatters_by_ft = {
        lua = {
          'stylua',
        },
        markdown = { 'markdownlint' },
        python = { 'ruff', 'autopep8', 'autoflake', 'docformatter', 'isort' },
        go = { 'gofmt' },
        bash = { 'shfmt', 'beautysh' },
        rust = { 'rustfmt' },
        javascript = { 'prettier', 'standardjs' },
        sql = { 'sql_formatter' },
        c = { 'clang-format' },
        html = { 'htmlbeautifier' },
        css = { 'rustywind' },
        -- Conform can also run multiple formatters sequentially
        -- python = { "isort", "black" },
        --
        -- You can use a sub-list to tell conform to run *until* a formatter
        -- is found.
        -- javascript = { { "prettierd", "prettier" } },
      },
      -- formatters = {
      --   markdownlint = {
      --     prepend_args = { '--disable', 'MD047' },
      --   },
      -- },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
