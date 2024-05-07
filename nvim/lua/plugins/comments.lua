return {
  {
    "b3nj5m1n/kommentary",
    config = function ()
      require('kommentary.config').configure_language('default', {
        single_line_comment_string = 'auto',
        multi_line_comment_strings = 'auto',
        hook_function = function()
          require('ts_context_commentstring').update_commentstring()
        end,
      })
    end
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function ()
      require('ts_context_commentstring').setup({
        enable_autocmd = false,
      })
    end
  },
}
