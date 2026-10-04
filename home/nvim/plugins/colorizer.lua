-- colorizer
-- https://github.com/catgoose/nvim-colorizer.lua

vim.opt.termguicolors = true

vim.pack.add {
  'https://github.com/catgoose/nvim-colorizer.lua',
}

require('colorizer').setup {
  options = {
    parsers = {
      css = true,
      css_fn = true,
    },

    display = {
      mode = "background",
    },
  },
}
