-- todo-comments.nvim
-- https://github.com/folke/todo-comments.nvim

vim.pack.add {
  'https://github.com/folke/todo-comments.nvim',
}

require('todo-comments').setup {
  merge_keywords = true,

  keywords = {
    FIX = {
      icon = "",
      color = "#fc1a70",
      alt = { "FIXME", "BUG", "FIXIT", "ISSUE" },
    },

    TODO = {
      icon = "",
      color = "#702EF3",
      alt = { "MAKE", "TOCODE" },
    },

    HACK = {
      icon = "",
      color = "#fc1a70",
    },

    WARN = {
      icon = "",
      color = "#FF4D00",
      alt = { "WARNING", "XXX" },
    },

    PERF = {
      icon = "",
      color = "#62A6E1",
      alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" },
    },

    NOTE = {
      icon = "󰴓",
      color = "#a4e400",
      alt = { "INFO" },
    },

    TEST = {
      icon = "⏲",
      color = "#ffff87",
      alt = { "TESTING", "PASSED", "FAILED" },
    },

    URL = {
      icon = "󰌹",
      color = "#1e65ff",
      alt = { "LINK", "SITE" },
    },

    DOCS = {
      icon = "󰈙",
      color = "#62A6E1",
      alt = { "DOC", "DOCUMENTATION" },
    },
  },

  highlight = {
    multiline = true,
    multiline_pattern = "^",
    multiline_context = 10,

    before = "",
    keyword = "wide",
    after = "fg",

    pattern = [[.*<(KEYWORDS)\s*:]],

    comments_only = true,
    max_line_len = 400,
    exclude = {},
  },
}
