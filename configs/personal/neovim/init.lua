---@diagnostic disable: undefined-global

-- vim options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.scrolloff = 8
vim.opt.updatetime = 250
vim.opt.cursorline = true
-- vim.opt.cursorcolumn = true

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
      vim.g.sonokai_style = "default" -- options: 'default', 'atlantis', 'andromeda', 'shusia', 'maia', 'espresso'
      vim.g.sonokai_better_performance = 1
      vim.g.sonokai_enable_italic = 1
      vim.g.sonokai_transparent_background = 0
      vim.g.sonokai_diagnostic_virtual_text = "colored" -- options: 'grey', 'colored', 'highlighted'
      -- vim.cmd([[colorscheme sonokai]])
    end,
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
    end,
  },
  {
    "sainnhe/everforest",
    name = "everforest",
    priority = 1000,
    config = function()
      vim.g.everforest_background = "medium" -- options: 'hard', 'medium(default)', 'soft'
      vim.g.everforest_better_performance = 1
      vim.g.everforest_enable_italic = 1
      vim.g.everforest_disable_italic_comment = 0
      vim.g.everforest_transparent_background = 0
      vim.g.everforest_sign_column_background = "none"
      vim.g.everforest_diagnostic_virtual_text = "colored"
      vim.g.everforest_ui_contrast = "high" -- options: 'low', 'high'
      vim.g.everforest_show_eob = 1        -- show ~ for empty lines at buffer end
      vim.g.everforest_float_style = "bright" -- background of floating windows
      vim.cmd([[colorscheme everforest]])
    end,
  },
  {
    "AlexvZyl/nordic.nvim",
    name = "nordic",
    priority = 1000,
    config = function()
      require("nordic").setup({
        theme = "nordic",             -- options 'nordic', 'nord'
        enable_sidebar_background = true, -- for sidebar elements like NvimTree
        italic_comments = true,       -- italicized comments for emphasis
        cursorline = {
          enable = true,
          theme = "dark",
        },
        transparent = false,
        brighter_comments = true,
        telescope = {
          style = "classic", -- options: "flat" for flat, "classic" for borders
        },
      })
    end,
  },
  { -- global grep and file search
    "nvim-telescope/telescope-fzy-native.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
          },
          fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
          },
        },
      })
      require("telescope").load_extension("ui-select")
      require("telescope").load_extension("fzy_native")
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true,
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  },
  {
    "nvim-treesitter/nvim-treesitter",
    name = "treesitter",
    priority = 1000,
    build = ":TSUpdate",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
      "nvim-treesitter/playground",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        -- Core functionality
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        autotag = {
          enable = true,
        },
        
        -- Incremental selection
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
        },

        -- Text objects configuration
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- Text object mappings
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
              ["ac"] = "@class.outer",
              ["ic"] = "@class.inner",
              ["ab"] = "@block.outer",
              ["ib"] = "@block.inner",
              ["ap"] = "@parameter.outer",
              ["ip"] = "@parameter.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = "@function.outer",
              ["]c"] = "@class.outer",
              ["]b"] = "@block.outer",
              ["]p"] = "@parameter.inner",
            },
            goto_next_end = {
              ["]F"] = "@function.outer",
              ["]C"] = "@class.outer",
            },
            goto_previous_start = {
              ["[f"] = "@function.outer",
              ["[c"] = "@class.outer",
              ["[b"] = "@block.outer",
              ["[p"] = "@parameter.inner",
            },
            goto_previous_end = {
              ["[F"] = "@function.outer",
              ["[C"] = "@class.outer",
            },
          },
        },

        -- optional modules
        playground = {
          enable = true,
          disable = {},
          updatetime = 25,
          persist_queries = false,
        },

        -- additional modules can be added here
        rainbow = {
          enable = true,
          extended_mode = true,
          max_file_lines = nil,
        },
      })

      -- additional setup after treesitter is loaded
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
      vim.opt.foldenable = false -- disable folding by default
    end,
  },
  {
    {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      --event = { "BufReadPost", "BufNewFile" },
      dependencies = {
        "HiPhish/rainbow-delimiters.nvim",
      },
      config = function()
        local highlight = {
          "RainbowRed",
          "RainbowYellow",
          "RainbowBlue",
          "RainbowOrange",
          "RainbowGreen",
          "RainbowViolet",
          "RainbowCyan",
        }
        local hooks = require("ibl.hooks")

        hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
          vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
          vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
          vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
          vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
          vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
          vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
          vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
        end)

        vim.g.rainbow_delimiters = { highlight = highlight }
        require("ibl").setup({
          scope = {
            highlight = highlight,
            priority = 500,
            include = {
              node_type = {
                ["*"] = {
                  -- Curly brace scopes
                  "block",
                  "chunk",
                  "class_definition",
                  "function_definition",
                  "function_declaration",
                  "function",
                  "object",
                  "table",
                  "dictionary",
                  -- Bracket scopes
                  "array",
                  "list_literal",
                  "tuple",
                  "element",
                  -- HTML/JSX
                  "jsx_element",
                  "jsx_self_closing_element",
                  "tag",
                  "element",
                  "tag_self_close",
                  -- General scopes
                  "if_statement",
                  "else_clause",
                  "elif_clause",
                  "for_statement",
                  "while_statement",
                  "switch_statement",
                  "case_statement",
                  "try_statement",
                  "catch_clause",
                  -- Additional contexts
                  "arguments",
                  "parameters",
                  "body",
                },
              },
            },
          },
        })
        hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
      end,
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          theme = "dracula",
        },
      })
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "muniftanjim/nui.nvim",     -- "3rd/image.nvim", -- optional image support in preview window: see `# preview mode` for more information
    },
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
    opts = {
      auto_install = true,
    },
  },
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({ capabilities = capabilities })
      lspconfig.html.setup({ capabilities = capabilities })
      lspconfig.cssls.setup({ capabilities = capabilities })
      lspconfig.ast_grep.setup({ capabilities = capabilities })
      lspconfig.eslint.setup({ capabilities = capabilities })
      lspconfig.emmet_ls.setup({ capabilities = capabilities })
      lspconfig.jsonls.setup({ capabilities = capabilities })
      lspconfig.pyright.setup({ capabilities = capabilities })
      lspconfig.pylyzer.setup({ capabilities = capabilities })
      lspconfig.rust_analyzer.setup({ capabilities = capabilities })
      lspconfig.templ.setup({ capabilities = capabilities })
      lspconfig.dockerls.setup({ capabilities = capabilities })
      lspconfig.docker_compose_language_service.setup({ capabilities = capabilities })
      lspconfig.yamlls.setup({ capabilities = capabilities })
      lspconfig.taplo.setup({ capabilities = capabilities })
      lspconfig.bashls.setup({ capabilities = capabilities })
      lspconfig.marksman.setup({ capabilities = capabilities })
    end,
  },
  { -- wrapper for LSPs
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.prettier,
          null_ls.builtins.formatting.biome,
          null_ls.builtins.formatting.isort,
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.djlint,
        },
      })
    end,
  },
  -- auto complete, and snippets
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "hrsh7th/cmp-nvim-lsp-signature-help",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      require("luasnip.loaders.from_vscode").lazy_load()
      
      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp_signature_help" },
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- for luasnip users
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
local opts = {}
require("lazy").setup(plugins, opts)

-- themes
vim.cmd.colorscheme("catppuccin")
-- vim.cmd.colorscheme("sonokai")
-- vim.cmd.colorscheme("everforest")
-- vim.cmd.colorscheme("nordic")

vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    vim.cmd [[
      highlight Normal guibg=#000000
      highlight NormalNC guibg=#000000
      highlight EndOfBuffer guibg=#000000
    ]] -- Replace with your hex color
  end,
})

----------------------------------------------------------------------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- open nvim config
vim.keymap.set('n', '<leader>co', ':e ~/.config/nvim/init.lua<CR>', { silent = true, desc = "Open nvim config" })

-- escape keymaps 
vim.keymap.set("i", "jj", "<Esc>", { silent = true, desc = "Exit insert mode with jj" })
vim.keymap.set("n", "<Esc>", ":noh<CR>", { silent = true, desc = "Clear search highlight" })

-- lsp keymappings
vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show identifier details"} )
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to where code artifact is defined" })
vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Display available actions to take on code" })

vim.keymap.set("n", "<leader>ed", vim.diagnostic.enable, { desc = "Enable LSP diagnostics" })
vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, { desc = "Format current file with linter rules" })

-- mason keymaps("i" to install packages within stylua explorer)
vim.keymap.set("n", "<leader>ma", ":Mason<CR>", { desc = "Open Mason language server explorer" })

-- global keymaps (outside neo-tree window)
vim.keymap.set("n", "<leader>ge", "<cmd>Neotree git_status<cr>", { desc = "Git explorer" })
vim.keymap.set("n", "<leader>be", "<cmd>Neotree buffers<cr>", { desc = "Buffer explorer" })
vim.keymap.set("n", "<leader>fe", "<cmd>Neotree reveal<cr>", { desc = "Reveal file in explorer" })
vim.keymap.set("n", "<leader>ce", "<cmd>Neotree close<cr>", { desc = "Close file explorere" })

-- keymaps for toggling indentation
vim.keymap.set("n", "<leader>is", "<cmd>IndentScopeToggle<CR>", { desc = "Toggle indent scope highlighting" })

-- suggestions
vim.keymap.set("n", "<C-<space>>", "")

-- save and quit operations
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "Save file" })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit" })
vim.keymap.set("n", "<leader>Q", ":qa!<CR>", { desc = "Force quit all" })
vim.keymap.set("n", "<leader>x", ":wq<CR>", { desc = "Save and quit" })

-- buffer operations
-- vim.api.nvim_create_user_command("SwitchBuffer", function(opts)
--   local buf_id = tonumber(opts.args)
--   if buf_id and vim.api.nvim_buf_is_valid(buf_id) then
--     vim.api.nvim_set_current_buf(buf_id)
--   else
--     print("Invalid buffer ID")
--   end
-- end, { nargs = 1 })
--
-- vim.keymap.set("n", "<leader>sb", ":SwitchBuffer ", { desc = "Switch to buffer by ID" })
-- vim.keymap.set("n", "<leader>lb", "<cmd>ls<CR>", { desc = "List buffers" })
vim.keymap.set("n", "<leader>lb", "<cmd>Telescope buffers<CR>", { desc = "List buffers interactively" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>l", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>h", ":bprevious<CR>", { desc = "Previous buffer" })

-- window operations
vim.keymap.set("n", "<leader>sv", ":vsplit<CR>", { desc = "Vertical split" })
vim.keymap.set("n", "<leader>sh", ":split<CR>", { desc = "Horizontal split" })
vim.keymap.set("n", "<leader>sx", ":close<CR>", { desc = "Close current split" })
vim.keymap.set("n", "<C-h>", "<C-W>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-W>l", { desc = "Move to right window" })
vim.keymap.set("n", "<C-j>", "<C-W>j", { desc = "Move to bottom window" })
vim.keymap.set("n", "<C-k>", "<C-W>k", { desc = "Move to window above" })

-- tabbing
vim.keymap.set("n", ">", ">>", { desc = "Tab current line to the right" })
vim.keymap.set("n", "<", "<<", { desc = "Tab current line to the left" })
vim.keymap.set("v", ">", ">gv", { desc = "Tab current selection to the right" })
vim.keymap.set("v", "<", "<gv", { desc = "Tab current selection to the left" })

-- move lines
vim.keymap.set("n", "<leader>k", ":m-2<CR>", { desc = "Move current line upwards" })
vim.keymap.set("n", "<leader>j", ":m+<CR>", { desc = "Move current line downwards" })
vim.keymap.set("v", "<leader>k", ":m '<-2<CR>gv", { desc = "Move current selection upwards" })
vim.keymap.set("v", "<leader>j", ":m '>+1<CR>gv", { desc = "Move current selection downwards" })

-- resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- file navigation
vim.keymap.set("n", "<leader>/", ":Telescope live_grep<CR>", { desc = "Search in files" })
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<C-f>", ":Telescope buffers<CR>", { desc = "Find buffers" })
vim.keymap.set("n", "<leader>fh", ":Telescope help_tags", { desc = "Find help" })

-- open terminal
vim.keymap.set("n", "<leader>t", ":bel term<CR>", { desc = "Open terminal at bottom of window" })

-- copy&past improvements
vim.keymap.set("n", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
vim.keymap.set("v", "<leader>y", '"+ygv', { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

vim.keymap.set('n', '<C-S-a>', function()
    print(vim.fn.getcharstr())
end)
