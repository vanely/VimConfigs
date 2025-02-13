" VSCode Neovim Configuration

" Highlight cursor line underneath the cursor horizontally.
set cursorline
" Highlight cursor line underneath the cursor vertically.
set cursorcolumn
" Set highlight search
set hlsearch
" Set tab width to 4 columns.
set tabstop=2
" Use space characters instead of tabs.
set expandtab
set smarttab
set ai "Auto inden
" usaved changes are not discarded when the file is abandoned(not the active
" in any buffer, window, or tab, and can only be viewed when buffers are
" listed)
set hidden
" While searching though a file incrementally highlight matching characters as you type.
set incsearch
" Ignore capital letters during search.
set ignorecase
" Override the ignorecase option if searching for capital letters.
" This will allow you to search specifically for capital letters.
set smartcase
" Show partial command you type in the last line of the screen.
set showcmd
" Show the mode you are on the last line.
set showmode
" Show matching words during a search.
set showmatch
" Set regular expression engine automatically
set regexpengine=0
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
" Don't redraw while executing macros (good performance config)
set lazyredraw
" For regular expressions turn magic on
set magic
" Set leader key to space
let mapleader = " "

" File operations
nnoremap <leader>w <Cmd>call VSCodeCall('workbench.action.files.save')<CR>
nnoremap <leader>q <Cmd>call VSCodeCall('workbench.action.closeActiveEditor')<CR>
nnoremap <leader>e <Cmd>call VSCodeCall('workbench.action.toggleSidebarVisibility')<CR>

" Function navigation
" nnoremap [f <Cmd>call VSCodeCall('editor.action.previousMethodOrFunctionDefinition')<CR>
" nnoremap ]f <Cmd>call VSCodeCall('editor.action.nextMethodOrFunctionDefinition')<CR>
" nnoremap [[ <Cmd>call VSCodeCall('editor.action.previousMethodOrFunctionDefinition')<CR>
nnoremap ]] <Cmd>call VSCodeCall('editor.action.jumpToBracket')<CR>

" Finding and navigation
" noremap <leader>ff <Cmd>call VSCodeCall('workbench.action.quickOpen')<CR>
" nnoremap <leader>fb <Cmd>call VSCodeCall('workbench.action.showAllEditors')<CR>
nnoremap gf <Cmd>call VSCodeCall('editor.action.goToReferences')<CR>
nnoremap <leader>co :!code '/Users/vanelysantos/.config/nvim/vscode/vscode.vim'<CR>

" tabbing
nnoremap > >>
nnoremap < <<

" Keep selection when indenting in visual mode
vnoremap > >gv
vnoremap < <gv

" Window management
nnoremap <leader>vs <Cmd>call VSCodeCall('workbench.action.splitEditor')<CR>
nnoremap <leader>sh <Cmd>call VSCodeCall('workbench.action.splitEditorDown')<CR>
" nnoremap <leader>se <Cmd>call VSCodeCall('workbench.action.equalizeEditorGroups')<CR>

" LSP-like functionality
nnoremap <leader>ca <Cmd>call VSCodeCall('editor.action.quickFix')<CR>
nnoremap <leader>rn <Cmd>call VSCodeCall('editor.action.rename')<CR>

" Terminal and panel control
nnoremap <leader>t <Cmd>call VSCodeCall('workbench.action.terminal.toggleTerminal')<CR>
nnoremap <leader>T <Cmd>call VSCodeCall('workbench.action.togglePanel')<CR>

" Buffer navigation
nnoremap <leader>l <Cmd>call VSCodeCall('workbench.action.nextEditor')<CR>
nnoremap <leader>h <Cmd>call VSCodeCall('workbench.action.previousEditor')<CR>

" Quick commenting
" nnoremap gc <Cmd>call VSCodeCall('editor.action.commentLine')<CR>
nnoremap gc gc<CR>
" vnoremap gc <Cmd>call VSCodeCall('editor.action.commentLine')<CR>
vnoremap gc <Cmd>call VSCodeCall('editor.action.commentLine')<CR>

" Move line up with Alt+Up or <leader>k
" nnoremap <M-Up> :m-2<CR>
nnoremap <leader>k :m-2<CR>

" Move line down with Alt+Down or <leader>j 
" nnoremap <M-Down> :m+<CR>
nnoremap <leader>j :m+<CR>

" Visual mode mappings to move selected lines
" vnoremap <M-Up> :m '<-2<CR>gv
vnoremap <leader>k :m '<-2<CR>gv
" vnoremap <M-Down> :m '>+1<CR>gv 
vnoremap <leader>j :m '>+1<CR>gv

" Additional useful VS Code specific mappings
nnoremap <leader>/ <Cmd>call VSCodeCall('workbench.action.findInFiles')<CR>
nnoremap <leader>s <Cmd>call VSCodeCall('editor.action.formatDocument')<CR>

" Window navigation
nnoremap <C-h> <Cmd>call VSCodeCall('workbench.action.navigateLeft')<CR>
nnoremap <C-j> <Cmd>call VSCodeCall('workbench.action.navigateDown')<CR>
nnoremap <C-k> <Cmd>call VSCodeCall('workbench.action.navigateUp')<CR>
nnoremap <C-l> <Cmd>call VSCodeCall('workbench.action.navigateRight')<CR>

" Workbench shortcuts
nnoremap <leader>fe <Cmd>call VSCodeCall('workbench.view.explorer')<CR>
nnoremap <leader>ff <Cmd>call VSCodeCall('workbench.view.search')<CR>

" clear search highlights with escape
nnoremap <silent> <esc> :noh<CR><esc>

" Clipboard optimizations
" Copy to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
nnoremap <leader>Y "+Y

" Paste from system clipboard
nnoremap <leader>p "+p
vnoremap <leader>p "+p
nnoremap <leader>P "+P

" Copy file path
nnoremap <leader>yp <Cmd>call VSCodeCall('copyFilePath')<CR>
nnoremap <leader>yr <Cmd>call VSCodeCall('copyRelativeFilePath')<CR>
