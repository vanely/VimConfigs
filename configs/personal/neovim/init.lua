--vim.cmd("set expandtab")
--vim.cmd("set tabstop=2")
--vim.cmd("set softtabstop=2")
--vim.cmd("set shiftwidth=2")
-- vim options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.scrolloff = 8
vim.opt.updatetime = 250

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- plugins
local plugins = {
  -- Sonokai theme
  { 
    "sainnhe/sonokai", 
    name = "sonokai",
    priority = 1000, 
    config = function()
      -- Sonokai configs
        vim.g.sonokai_style = 'default' -- options: 'default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso'
        vim.g.sonokai_better_performance = 1
        vim.g.sonokai_enable_italic = 1
        vim.g.sonokai_transparent_background = 0
        vim.g.sonokai_diagnostic_virtual_text = 'colored' -- options: 'grey', 'colored', 'highlighted'
        -- vim.cmd([[colorscheme sonokai]])
    end
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "mocha",
        transparent_background = false,
        term_colors = true,
      })
    end
  },
  {
    "sainnhe/everforest",
    name = "everforest",
    priority = 1000,
    config = function()
      vim.g.everforest_background = 'medium' -- options: 'hard', 'medium(default)', 'soft'
      vim.g.everforest_better_performance = 1
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_disable_italic_comment = 0
      vim.g.everforest_transparent_background = 0
      vim.g.everforest_sign_column_background = 'none'
      vim.g.everforest_diagnostic_virtual_text = 'colored'
      vim.g.everforest_ui_contrast = 'high' -- options: 'low', 'high'
      vim.g.everforest_show_eob = 1 -- show ~ for empty lines at buffer end
      vim.g.everforest_float_style = 'bright' -- background of floating windows
      vim.cmd([[colorscheme everforest]])   
    end
  },
  {
    "AlexvZyl/nordic.nvim",
    name = "nordic",
    priority = 1000,
    config = function()
      require("nordic").setup({
        theme = 'nordic', -- options 'nordic', 'nord'
        enable_sidebar_background = true, -- for sidebar elements like NvimTree
        italic_comments = true, -- italicized comments for emphasis
        cursorline = { 
          enable = true,
          theme = 'dark',
        },
        transparent_bg = false,
        brighter_comments = true,
        telescope = {
          style = "classic", -- options: "flat" for flat, "classic" for borders
        },
      })
    end
  },
  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim'},
  }
}
local opts = {}
require("lazy").setup(plugins, opts)

-- themes
vim.cmd.colorscheme("catppuccin")
-- vim.cmd.colorscheme("sonokai")
-- vim.cmd.colorscheme("everforest")
-- vim.cmd.colorscheme("nordic")

----------------------------------------------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "
-- key maps and re-maps 
vim.keymap.set('i', 'jj', '<Esc>', { desc = "Exit insert mode with jj" }) 
-- vim.keymap.set('n', 'jj', '<Esc>', { desc = "General escape in normal mode" })
vim.keymap.set('n', '<Esc>', ':noh<CR>', { silent = true, desc = "Clear search highlight" })

-- save and quit operations
vim.keymap.set('n', '<leader>w', ':w<CR>', { desc = "Save file" })
vim.keymap.set('n', '<leader>q', ':q<CR>', { desc = "Quit" })
vim.keymap.set('n', '<leader>Q', ':qa!<CR>', { desc = "Force quit all" })
vim.keymap.set('n', '<leader>x', ':wq<CR>', { desc = "Save and quit" })

-- buffer operations
vim.keymap.set('n', '<leader>bd', ':bdelete<CR>', { desc = "Delete buffer" })
vim.keymap.set('n', '<leader>l', ':bnext<CR>', { desc = "Next buffer" })
vim.keymap.set('n', '<leader>h', ':bprevious<CR>',{ desc = "Previous buffer" })

-- window operations
vim.keymap.set('n', '<leader>vs', ':vsplit<CR>', { desc = "Vertical split" })
vim.keymap.set('n', '<leader>hs', ':split<CR>', { desc = "Horizontal split" })
vim.keymap.set('n', '<leader>sx', ':close<CR>', { desc = "Close current split" })
vim.keymap.set('n', '<C-h>', '<C-W>h', { desc = "Move to left window" })
vim.keymap.set('n', '<C-l>', '<C-W>l', { desc = "Move to right window" })
vim.keymap.set('n', '<C-j>', '<C-W>j', { desc = "Move to bottom window" })
vim.keymap.set('n', '<C-k>', '<C-W>k', { desc = "Move to window above" })

-- file navigation
vim.keymap.set('n', '<leader>/', ':Telescope live_grep<CR>', { desc = "Search in files" })
vim.keymap.set('n', '<C-p>', ':Telescope find_files<CR>', { desc = "Find files" })
vim.keymap.set('n', '<C-f>', ':Telescope buffers<CR>', { desc = "Find buffers" })
vim.keymap.set('n', '<leader>fh', ':Telescope help_tags', { desc = "Find help" })

-- copy&past improvements
vim.keymap.set('n', '<leader>y', '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set('v', '<leader>y', '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set('n', '<leader>p', '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set('v', '<leader>p', '"+p', { desc = "Paste from system clipboard" })




 
