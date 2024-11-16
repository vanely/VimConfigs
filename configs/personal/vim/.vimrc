" GENERAL SETTINGS --------------------------------------------------------------------- {{{ 
" A combination of settings I've found throughout the internets

" Disable compatibility with vi which can cause unexpected issues.
set nocompatible

" Enable type file detection. Vim will be able to try to detect the type of file in use.
filetype on
" Enable plugins and load plugin for the detected file type.
filetype plugin on
" Load an indent file for the detected file type.
filetype indent on
set autoread
au FocusGained,BufEnter * silent! checktime
" Turn syntax highlighting on.
syntax on
colorscheme gruvbox
" colorscheme desert

" we use a dark background, don't we?
" set bg=dark
set background=dark

" Always show the menu, insert longest match
set completeopt=menuone,longest

" Add numbers to each line on the left-hand side.
set number
set relativenumber
" Highlight cursor line underneath the cursor horizontally.
set cursorline
" Highlight cursor line underneath the cursor vertically.
set cursorcolumn
" Set shift width to 4 spaces.
set shiftwidth=2
set numberwidth=5
" Set tab width to 4 columns.
set tabstop=2
" Use space characters instead of tabs.
set expandtab
set smarttab
set ai "Auto indent
set si "Smart indent
set wrap "Wrap lines

" Do not save backup files.
set nobackup
set nowb
set noswapfile
" Do not let cursor scroll below or above N number of lines when scrolling.
set scrolloff=10
" Do not wrap lines. Allow long lines to extend as far as the line goes.
set wrap
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
" Use Unix as the standard file type
set ffs=unix,dos,mac
" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l
" How many tenths of a second to blink when matching brackets
set mat=2
" Don't redraw while executing macros (good performance config)
set lazyredraw
" For regular expressions turn magic on
set magic
" Use highlighting when doing a search.
set hlsearch
" Set the commands to save in history default number is 20.
set history=100
" How many tenths of a second to blink when matching brackets
set mat=2

"set gh=git\ grep\ vimgrep\ -n

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
" Properly disable sound on errors on MacVim
if has("gui_macvim")
    autocmd GUIEnter * set vb t_vb=
endif
" Add a bit extra margin to the left
set foldcolumn=1
" Enable auto completion menu after pressing TAB.
set wildmenu
" Make wildmenu behave like similar to Bash completion.
set wildmode=list:longest
" There are certain files that we would never want to edit with Vim.
" Wildmenu will ignore files with these extensions.
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*.pyc,*.exe,*.flv,*.img,*.xlsx
function! InsertTabWrapper()
  let col = col('.') - 1
  if !col || getline('.')[col - 1] !~ '\k'
    return "\<Tab>"
  else
    return "\<C-p>"
  endif
endfunction

" }}}

" PLUGINS ---------------------------------------------------------------- {{{

call plug#begin('~/.vim/plugged')

  Plug 'neoclide/coc.vim', { 'branch': 'release' } 
  Plug 'chriskempson/base16-vim'
  Plug 'dense-analysis/ale'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'vim-syntastic/syntastic'
  Plug 'mileszs/ack.vim'
  Plug 'itchyny/lightline.vim'
  Plug 'frazrepo/vim-rainbow'
  Plug 'tpope/vim-surround'
  Plug 'preservim/nerdtree'
  Plug 'rust-lang/rust.vim'

call plug#end()

" }}}

" MAPPINGS ---------------------------------------------------------------- {{{

""""""""""""""""""""""""""""""
" => Plugin configs
""""""""""""""""""""""""""""""
"--------------------------------------fzf---------------------------------"
"let g:fzf_vim.preview_window = ['right,50%', 'ctrl-/']
"--------------------------------------------------------------------------"

"--------------------------------------ack---------------------------------"
let g:ackprg = 'ack --vimgrep'
let g:ack_use_location_list = 1
let g:ack_ignore_dir = ['node_modules', '.git']
"--------------------------------------------------------------------------"

"----------------------------------Syntastic-------------------------------"
" Syntastic configuration
let g:syntastic_enable_signs = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" Language checkers
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_python_checkers = ['flake8']
"--------------------------------------------------------------------------"

"------------------------------------Tabline-------------------------------"
let g:lightline = {
  \   'colorscheme': 'Gruvbox',
  \   'active': {
  \     'left':[ [ 'mode', 'paste' ],
  \              [ 'gitbranch', 'readonly', 'filename', 'modified' ]
  \     ]
  \   },
	\   'component': {
	\     'lineinfo': ' %3l:%-2v',
	\   },
  \   'component_function': {
  \     'gitbranch': 'fugitive#head',
  \   }
  \ }
let g:lightline.separator = {
	\   'left': '', 'right': ''
  \}
let g:lightline.subseparator = {
	\   'left': '', 'right': '' 
  \}
let g:lightline.tabline = {
  \   'left': [ ['tabs'] ],
  \   'right': [ ['close'] ]
  \ }
set showtabline=2  " Show tabline
set guioptions-=e  " Don't use GUI tabline
"--------------------------------------------------------------------------"

"----------------------------------Vim-rainbow-----------------------------"
au FileType c,cpp,objc,objcpp call rainbow#load()
let g:rainbow_active = 1

let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ [ '*.css' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.scss' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.js' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.ts' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.go' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.rs' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.vim' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.sh' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ ]

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']
"--------------------------------------------------------------------------"
""""""""""""""""""""""""""""""
" => Plugin mappings
""""""""""""""""""""""""""""""

"--------------------------------------fzf---------------------------------"
nnoremap <leader>f :call GlobalSearch()<CR>
"--------------------------------------------------------------------------"

"--------------------------------------ack---------------------------------"
" Map :Ack command to <leader>a
nnoremap <leader>a :Ack<space>
" Map :Ack to search for the word under the cursor
nnoremap <leader>aw :Ack <C-R><C-W><CR>
" Map :Ack to search in the current working directory
nnoremap <leader>ac :Ack -H .<CR>
" Map :Ack to search in the current file's directory
nnoremap <leader>ad :Ack -H %:h<CR>
"--------------------------------------------------------------------------"

"-----------------------------------NERDTree-------------------------------"
map <C-S-e> :NERDTreeToggle<CR>
map <C-p> :Files<CR>
"--------------------------------------------------------------------------"

""""""""""""""""""""""""""""""
" => Insert mode related
""""""""""""""""""""""""""""""
let mapleader = ","

inoremap <Tab> <C-r>=InsertTabWrapper()<CR>
inoremap <S-Tab> <C-n>
inoremap jj <esc>

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :<C-u>call VisualSelection('', '')<CR>/<C-R>=@/<CR><CR>
vnoremap <silent> # :<C-u>call VisualSelection('', '')<CR>?<C-R>=@/<CR><CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map <Space> to / (search) and Ctrl-<Space> to ? (backwards search)
" map <space> /
" map <C-space> ?

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Faster split sizing
map <C-Left> <C-W><
map <C-Right> <C-W>>
map <C-Up> <C-W>+
map <C-Down> <C-W>-

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :Bclose<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t :execute 'tabn ' . ChangeTab()<cr>

" IDE like search
nnoremap <silent> <leader>f :call OpenSearchPopup()<CR>

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()

" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <C-r>=escape(expand("%:p:h"), " ")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
try
  set switchbuf=useopen,usetab,newtab
  set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Format the status line
set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^
" Reasigning [Alt]+[h,j,k,l] to actually be functional
execute "set <M-h>=\eh"
execute "set <M-j>=\ej"
execute "set <M-k>=\ek"
execute "set <M-l>=\el"

nmap <M-j> mz:m .+1<CR>`z
nmap <M-k> mz:m .-2<CR>`z

" Visual mode mappings for moving selected lines up or down
vmap <M-j> :m '>+1<CR>gv=gv
vmap <M-k> :m '<-2<CR>gv=gv

" macOS-specific mappings
if has("mac") || has("macunix")
  " For macOS, map the Cmd key (⌘) to Alt key mappings for consistency
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>

  " Insert mode mappings for moving a line up or down
  inoremap <M-j> <Esc>:m .+1<CR>==gi
  inoremap <M-k> <Esc>:m .-2<CR>==gi
              
  " Normal mode mappings for moving a line up or down
  nnoremap <M-j> :m .+1<CR>==
  nnoremap <M-k> :m .-2<CR>==
                
  " Visual mode mappings for moving selected lines up
  " or down
  vnoremap <M-j> :m '>+1<CR>gv=gv
  vnoremap <M-k> :m '<-2<CR>gv=gv
endif

nnoremap gd <C-]><CR>

" Delete trailing white space on save, useful for some filetypes ;)
fun! CleanExtraSpaces()
  let save_cursor = getpos(".")
  let old_query = getreg('/')
  silent! %s/\s\+$//e
  call setpos('.', save_cursor)
  call setreg('/', old_query)
endfun

if has("autocmd")
    autocmd BufWritePre *.txt,*.js,*.py,*.wiki,*.sh,*.coffee :call CleanExtraSpaces()
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

" Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Quickly open a buffer for scribble
map <leader>q :e ~/buffer<cr>

" Quickly open a markdown buffer for scribble
map <leader>x :e ~/buffer.md<cr>

" Toggle paste mode on and off
map <leader>pp :setlocal paste!<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    endif
    return ''
endfunction

" Don't close window, when deleting a buffer
command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
    let l:currentBufNum = bufnr("%")
    let l:alternateBufNum = bufnr("#")

    if buflisted(l:alternateBufNum)
        buffer #
    else
        bnext
    endif

    if bufnr("%") == l:currentBufNum
        new
    endif

    if buflisted(l:currentBufNum)
        execute("bdelete! ".l:currentBufNum)
    endif
endfunction

function! CmdLine(str)
    call feedkeys(":" . a:str)
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", "\\/.*'$^~[]")
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'gv'
        call CmdLine("Ack '" . l:pattern . "' " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

function! ChangeTab()  
  let tab_number = input('Enter tab num: ')
  if tab_number =~ '^\d\+$'
    return tab_number
  else
    return ''
  endif
endfunction

function! MergeTab()
  let bufnums = tabpagebuflist()
  hide tabclose
  vsplit
  for n in bufnums
    execute 'sbuffer ' . n
    wincmd _
  endfor
  wincmd t
  quit
  wincmd =
endfunction

" Work In Progress
function! GlobalSearch()
  " Use ripgrep to search for the input pattern, and pipe the results to fzf 
  let l:search_term = input('<token> <file.extension>: ')
  if empty(l:search_term)
    return
  endif
  " Execute the search and use fzf to filter the results
  let l:results = system('rg --vimgrep --smart-case '.shellescape(l:search_term))
  " If there are no results, print a message and return
    echo "No results found for '".l:search_term."'"
  if empty(l:results)
    return
  endif
  " Use fzf to select from the results
  let l:selection = split(system('echo '.shellescape(l:results).' | fzf --ansi --preview "bat --color=always --line-range :30 {}"'))
  " If no selection is made, return
  if empty(l:selection)
    return
  endif
  " Parse the selected result and open the file at the specified line
  let l:file = l:selection[0]
  let l:line = l:selection[1]
  execute 'e+' . l:line . ' ' . l:file
endfunction

" make this popup where file searches are performed(it should have the same
" functionality as when / is pressed in normal mode
" bring cursor focus to the popup box
" position popup box to top right of current buffer
" allow input for search token, and tab press to input for global replace on enter
" when enter is pressed and then searched words have been replace with the new one, use the logic of ClosePopup to close the search popup box 

" function! OpenSearchPopup()
"     let text = ['Enter search term:']
"     let options = {
"         \ 'line': 1,
"         \ 'col': '100%',
"         \ 'minwidth': 40,
"         \ 'minheight': 5,
"         \ 'border': [],
"         \ 'padding': [0, 1, 0, 1],
"         \ 'highlight': 'PopupNormal',
"         \ 'zindex': 10,
"         \ 'mappings': 'insert',
"         \ 'filter': 'PopupFilter',
"         \ 'callback': function('CloseSearchPopup')
"         \ }
"     let winid = popup_create(text, options)
"     call popup_setoptions(winid, {'callback': function('CloseSearchPopup')})
"     let g:search_popup_winid = winid

"     " Create input buffer and set it to popup
"     " let input_bufnr = bufnr('%')
"     call popup_settext(winid, 'Search: ')
"     call feedkeys('i')
" endfunction

" function! CloseSearchPopup(id)
"     call popup_close(a:id)
" endfunction

" function! PopupFilter(id, key)
"     " Get input from user
"     let input = nr2char(a:key)
"     if input == "\<Esc>"
"         call CloseSearchPopup(a:id)
"     elseif input == "\<CR>"
"         " Get the current buffer text
"         let lnum = line('.')
"         let search_term = getline(lnum)
"         let search_term = substitute(search_term, 'Search: ', '', '')
"         call inputsave()
"         let replace_term = input('Replace with: ')
"         call inputrestore()
"         " Perform the search and replace
"         execute '%s/' . search_term . '/' . replace_term . '/gc'
"         call CloseSearchPopup(a:id)
"     endif
" endfunction

" nnoremap <silent> <leader>p :call OpenSearchPopup()<CR>
" }}}
