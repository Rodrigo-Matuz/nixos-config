vim.pack.add {
  'https://github.com/folke/noice.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
}

vim.opt.shortmess:append("c")

-- Main cmdline UI
vim.api.nvim_set_hl(0, "NoiceCmdlinePopup", {
  fg = "#FFFFFF",
  bg = "NONE",
})

vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorder", {
  fg = "#A4E400",
})

vim.api.nvim_set_hl(0, "NoiceCmdlineIcon", {
  fg = "#A4E400",
})

vim.api.nvim_set_hl(0, "NoiceCmdlineIconCmdline", {
  fg = "#FF4D00",
})

vim.api.nvim_set_hl(0, "NoiceCmdlineIconSearch", {
  fg = "#FF4D00",
})

vim.api.nvim_set_hl(0, "NoiceCmdlineIconFilter", {
  fg = "#FF4D00",
})

vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderCmdline", {
  fg = "#A4E400",
})

vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderSearch", {
  fg = "#A4E400",
})

vim.api.nvim_set_hl(0, "NoiceCmdlinePopupBorderFilter", {
  fg = "#A4E400",
})

-- The actual command-line formatting
require("noice").setup {
  cmdline = {
    format = {
      cmdline = {
        pattern = "^:",
        icon = "",
        icon_hl_group = "NoiceCmdlineIcon",
        lang = nil,
      },

      search_down = {
        kind = "search",
        pattern = "^/",
        icon = " ",
        icon_hl_group = "NoiceCmdlineIcon",
        lang = nil,
      },

      search_up = {
        kind = "search",
        pattern = "^%?",
        icon = " ",
        icon_hl_group = "NoiceCmdlineIcon",
        lang = nil,
      },

      filter = {
        pattern = "^:%s*!",
        icon = "$",
        icon_hl_group = "NoiceCmdlineIcon",
        lang = nil,
      },
    },
  },

  routes = {
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },
  },

  lsp = {
    hover = {
      enabled = false,
    },

    signature = {
      enabled = false,
    },

    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },

  presets = {
    bottom_search = true,
    command_palette = true,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
}
