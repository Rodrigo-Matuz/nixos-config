-- lualine
-- https://github.com/nvim-lualine/lualine.nvim

local function matuz()
  return "@matuz "
end

local function sep()
  return "•"
end

local function getFullDateTimeString()
  return os.date("%A, %B %d of %Y at %H:%M:%S")
end

local colors = {
  black = "#151515",
  full_black = "#050505",
  gray = "#808080",
  white = "#FFFFFF",
  cyan = "#00b3e3",
  green = "#a4e400",
  lgreen = "#078F0B",
  lorange = "#FFC671",
  orange = "#FF4D00",
  purple = "#702EF3",
  lpurple = "#BD93F9",
  red = "#fc1a70",
  lred = "#FA80AE",
  yellow = "#FFFF87",
  lblue = "#1e65ff",
  blue = "#62A6E1",
}

local custom_molokai = {
  normal = {
    a = { fg = colors.white, bg = colors.lblue, gui = "bold" },
    b = { fg = colors.full_black, bg = colors.blue },
    c = { fg = colors.white, bg = colors.black },
  },

  insert = {
    a = { fg = colors.white, bg = colors.red, gui = "bold" },
    b = { fg = colors.full_black, bg = colors.lred },
  },

  visual = {
    a = { fg = colors.white, bg = colors.orange, gui = "bold" },
    b = { fg = colors.full_black, bg = colors.lorange },
  },

  replace = {
    a = { fg = colors.full_black, bg = colors.red, gui = "bold" },
    b = { fg = colors.full_black, bg = colors.lblue },
  },

  inactive = {
    a = { fg = colors.white, bg = colors.purple, gui = "bold" },
    b = { fg = colors.full_black, bg = colors.lpurple },
  },

  command = {
    a = { fg = colors.white, bg = colors.lgreen, gui = "bold" },
    b = { fg = colors.full_black, bg = colors.green },
  },
}

vim.pack.add {
  "https://github.com/nvim-lualine/lualine.nvim",
  "https://github.com/nvim-tree/nvim-web-devicons",
}

require("lualine").setup {
  options = {
    icons_enabled = true,
    theme = custom_molokai,
    component_separators = "",
    section_separators = {
      left = "",
      right = "",
    },
    cmdline_floating_win = false,
  },

  sections = {
    lualine_a = {
      {
        "mode",
        separator = {
          right = "",
          left = "█",
        },
        icon = {
          "󰣇",
          align = "left",
        },
      },
    },

    lualine_b = {
      {
        "filename",
        icon = {
          "",
          align = "left",
        },
      },
    },

    lualine_c = {
      {
        "branch",
        icon = {
          "",
          align = "left",
        },
      },

      {
        "diff",
        symbols = {
          added = " ",
          modified = " ",
          removed = " ",
        },
        diff_color = {
          added = { fg = colors.green },
          removed = { fg = colors.red },
          modified = { fg = colors.yellow },
        },
      },

      {
        "diagnostics",
        sources = { "nvim_lsp" },
        sections = {
          "error",
          "warn",
          "info",
          "hint",
        },
        symbols = {
          error = "",
          warn = "",
          info = "",
          hint = "",
        },
        diagnostics_color = {
          color_error = { fg = colors.lred },
          color_warn = { fg = colors.lorange },
          color_info = { fg = colors.blue },
          color_hint = { fg = colors.purple },
        },
      },
    },

    lualine_x = {
      "encoding",
      sep,
      "filetype",
    },

    lualine_y = {
      matuz,
    },

    lualine_z = {
      "progress",
      {
        "location",
        separator = {
          left = "",
          right = "█",
        },
      },
    },
  },

  inactive_sections = {
    lualine_a = {
      {
        "mode",
        separator = {
          left = "",
          right = "",
        },
        icon = {
          "󰣇",
          align = "left",
        },
      },
    },

    lualine_b = {
      {
        "branch",
        icon = {
          "",
          align = "left",
        },
      },
    },

    lualine_c = {
      getFullDateTimeString,
    },

    lualine_x = {},

    lualine_y = {
      "fileformat",
    },

    lualine_z = {
      "location",
    },
  },

  tabline = {},

  extensions = {},
}
