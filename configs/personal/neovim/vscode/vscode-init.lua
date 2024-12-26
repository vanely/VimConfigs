---@diagnostic disable: undefined-global

-- Early check for VSCode environment
local is_vscode = vim.g.vscode ~= nil

-- Common settings for both environments
vim.g.mapleader = " "
vim.g.maplocalleader = " "

if is_vscode then
    -- VSCode-specific keymaps using recommended patterns
    -- Basic operations
    vim.api.nvim_set_keymap('i', 'jj', [[<Esc><Cmd>call VSCodeCall('vscode-neovim.escape')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<Esc>', [[<Cmd>call VSCodeCall('workbench.action.clearFind')<CR>]], { silent = true })
    
    -- LSP functionality
    vim.api.nvim_set_keymap('n', 'K', [[<Cmd>call VSCodeCall('editor.action.showHover')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', 'gd', [[<Cmd>call VSCodeCall('editor.action.revealDefinition')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<leader>ca', [[<Cmd>call VSCodeCall('editor.action.quickFix')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<leader>gf', [[<Cmd>call VSCodeCall('editor.action.formatDocument')<CR>]], { silent = true })
    
    -- File navigation
    vim.api.nvim_set_keymap('n', '<C-p>', [[<Cmd>call VSCodeCall('workbench.action.quickOpen')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<leader>/', [[<Cmd>call VSCodeCall('workbench.action.findInFiles')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<C-f>', [[<Cmd>call VSCodeCall('workbench.action.quickOpen')<CR>]], { silent = true })
    
    -- File operations
    vim.api.nvim_set_keymap('n', '<leader>w', [[<Cmd>call VSCodeCall('workbench.action.files.save')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<leader>q', [[<Cmd>call VSCodeCall('workbench.action.closeActiveEditor')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<leader>Q', [[<Cmd>call VSCodeCall('workbench.action.closeAllEditors')<CR>]], { silent = true })
    
    -- Window operations
    vim.api.nvim_set_keymap('n', '<leader>vs', [[<Cmd>call VSCodeCall('workbench.action.splitEditor')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<leader>hs', [[<Cmd>call VSCodeCall('workbench.action.splitEditorDown')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<leader>sx', [[<Cmd>call VSCodeCall('workbench.action.closeActiveEditor')<CR>]], { silent = true })
    
    -- Buffer/Tab operations
    vim.api.nvim_set_keymap('n', '<leader>l', [[<Cmd>call VSCodeCall('workbench.action.nextEditor')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<leader>h', [[<Cmd>call VSCodeCall('workbench.action.previousEditor')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<leader>bd', [[<Cmd>call VSCodeCall('workbench.action.closeActiveEditor')<CR>]], { silent = true })

    -- Terminal
    vim.api.nvim_set_keymap('n', '<leader>t', [[<Cmd>call VSCodeCall('workbench.action.terminal.toggleTerminal')<CR>]], { silent = true })
    
    -- Window navigation
    vim.api.nvim_set_keymap('n', '<C-S-h>', [[<Cmd>call VSCodeCall('workbench.action.focusLeftGroup')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<C-S-l>', [[<Cmd>call VSCodeCall('workbench.action.focusRightGroup')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<C-S-j>', [[<Cmd>call VSCodeCall('workbench.action.focusBelowGroup')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<C-S-k>', [[<Cmd>call VSCodeCall('workbench.action.focusAboveGroup')<CR>]], { silent = true })

    -- Window resizing
    vim.api.nvim_set_keymap('n', '<C-Up>', [[<Cmd>call VSCodeCall('workbench.action.increaseViewHeight')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<C-Down>', [[<Cmd>call VSCodeCall('workbench.action.decreaseViewHeight')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<C-Left>', [[<Cmd>call VSCodeCall('workbench.action.increaseViewWidth')<CR>]], { silent = true })
    vim.api.nvim_set_keymap('n', '<C-Right>', [[<Cmd>call VSCodeCall('workbench.action.decreaseViewWidth')<CR>]], { silent = true })

    -- Copy/paste operations
    vim.api.nvim_set_keymap('n', '<leader>y', [["+y]], { silent = true })
    vim.api.nvim_set_keymap('v', '<leader>y', [["+y]], { silent = true })
    vim.api.nvim_set_keymap('n', '<leader>p', [["+p]], { silent = true })
    vim.api.nvim_set_keymap('v', '<leader>p', [["+p]], { silent = true })

else
    -- Regular Neovim-only settings
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
    vim.opt.cursorcolumn = true

    -- [Your entire existing Neovim config exactly as it was, including:]
    -- - Lazy.nvim setup
    -- - All plugins
    -- - Theme settings
    -- - Neovim-specific keymaps
    -- [Rest of your Neovim config...]
end