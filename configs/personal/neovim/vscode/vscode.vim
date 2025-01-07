" VSCode Neovim Configuration
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
nnoremap <leader>gd <Cmd>call VSCodeCall('editor.action.revealDefinition')<CR>

" Window management
nnoremap <leader>vs <Cmd>call VSCodeCall('workbench.action.splitEditor')<CR>
nnoremap <leader>hs <Cmd>call VSCodeCall('workbench.action.splitEditorDown')<CR>
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
nnoremap gcc <Cmd>call VSCodeCall('editor.action.commentLine')<CR>
vnoremap gcc <Cmd>call VSCodeCall('editor.action.commentLine')<CR>

" Additional useful VS Code specific mappings
nnoremap <leader>/ <Cmd>call VSCodeCall('workbench.action.findInFiles')<CR>
nnoremap <leader>s <Cmd>call VSCodeCall('editor.action.formatDocument')<CR>

" Window navigation
nnoremap <C-h> <Cmd>call VSCodeCall('workbench.action.navigateLeft')<CR>
nnoremap <C-j> <Cmd>call VSCodeCall('workbench.action.navigateDown')<CR>
nnoremap <C-k> <Cmd>call VSCodeCall('workbench.action.navigateUp')<CR>
nnoremap <C-l> <Cmd>call VSCodeCall('workbench.action.navigateRight')<CR>

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

" Recommended VSCode-Neovim settings
" Add these to your VSCode settings.json:
" {
"   "vscode-neovim.neovimInitVimPaths.darwin": "/path/to/your/vscode.vim",
"   "vscode-neovim.neovimInitVimPaths.linux": "/path/to/your/vscode.vim",
"   "vscode-neovim.neovimInitVimPaths.win32": "C:\\path\\to\\your\\vscode.vim",
"   "keyboard.dispatch": "keyCode",
"   "vscode-neovim.useWSL": false,
"   "vscode-neovim.keybindingsEnabled": true,
"   "vscode-neovim.keyCommandWaitTimeout": 750
" }