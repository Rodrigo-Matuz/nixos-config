vim.pack.add {
  'https://github.com/lukas-reineke/indent-blankline.nvim',
}

local highlight = {
  'IblScope1',
  'IblScope2',
  'IblScope3',
  'IblScope4',
  'IblScope5',
  'IblScope6',
}

local hooks = require('ibl.hooks')

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  vim.api.nvim_set_hl(0, 'IblIndent', {
    fg = '#202020',
  })

  vim.api.nvim_set_hl(0, 'IblScope1', { fg = '#1E65FF' })
  vim.api.nvim_set_hl(0, 'IblScope2', { fg = '#702EF3' })
  vim.api.nvim_set_hl(0, 'IblScope3', { fg = '#FC1A70' })
  vim.api.nvim_set_hl(0, 'IblScope4', { fg = '#FF4D00' })
  vim.api.nvim_set_hl(0, 'IblScope5', { fg = '#FFFF87' })
  vim.api.nvim_set_hl(0, 'IblScope6', { fg = '#A4E400' })
end)

require('ibl').setup {
  indent = {
    char = '│',
    highlight = 'IblIndent',
  },

  scope = {
    enabled = true,
    highlight = highlight,
    show_start = false,
    show_end = false,
    show_exact_scope = true,
  },
}

hooks.register(
  hooks.type.SCOPE_HIGHLIGHT,
  hooks.builtin.scope_highlight_from_extmark
)
