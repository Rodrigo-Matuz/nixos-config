-- oil.nvim
-- https://github.com/stevearc/oil.nvim

vim.pack.add {
  'https://github.com/stevearc/oil.nvim',
}

require('oil').setup {
  default_file_explorer = true,
}

vim.keymap.set('n', '<leader>ee', '<cmd>Oil<cr>', {
  desc = 'Open Oil',
})

vim.keymap.set('n', '<leader>ef', '<cmd>Oil --float<cr>', {
  desc = 'Open Oil (float)',
})

vim.keymap.set('n', '<leader>ec', '<cmd>Oil .<cr>', {
  desc = 'Open Oil (cwd)',
})
