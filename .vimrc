" vimconf is not vi-compatible
set nocompatible
""" Automatically make needed files and folders on first run
""" If you don't run *nix you're on your own (as in remove this) {{{
    call system("mkdir -p $HOME/.vim/{swap,undo}")
    if !filereadable($HOME . "/.vimrc.plugins") | call system("touch $HOME/.vimrc.plugins") | endif
    if !filereadable($HOME . "/.vimrc.first") | call system("touch $HOME/.vimrc.first") | endif
    if !filereadable($HOME . "/.vimrc.last") | call system("touch $HOME/.vimrc.last") | endif
""" }}}
""" Vundle plugin manager {{{
    """ Automatically setting up Vundle, taken from
    """ http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/ {{{
        let has_vundle=1
        if !filereadable($HOME."/.vim/bundle/Vundle.vim/README.md")
            echo "Installing Vundle..."
            echo ""
            silent !mkdir -p $HOME/.vim/bundle
            silent !git clone https://github.com/gmarik/Vundle.vim $HOME/.vim/bundle/Vundle.vim
            let has_vundle=0
        endif
    """ }}}
    """ Initialize Vundle {{{
        filetype off                                " required to init
        set rtp+=$HOME/.vim/bundle/Vundle.vim       " include vundle
        call vundle#begin()                         " init vundle
    """ }}}
    """ Github repos, uncomment to disable a plugin {{{
    Plugin 'gmarik/Vundle.vim'

    """ Local plugins (and only plugins in this file!) {{{{
        if filereadable($HOME."/.vimrc.plugins")
            source $HOME/.vimrc.plugins
        endif
    """ }}}

    "Comments and stuff
    Plugin 'scrooloose/nerdcommenter'
    "YCM CONF GENERATOR
    "Plugin 'rdnetto/YCM-Generator'
    "Auto cwd for current buffer
    Plugin 'ssl/AutoCWD.vim'
    "Better highlighting for c-family languages
    Plugin 'bbchung/Clamp'
    "Auto Complete
    Plugin 'octol/vim-cpp-enhanced-highlight'
    Plugin 'Shougo/deoplete.nvim'
    "File browser
    Plugin 'scrooloose/nerdtree'
    "Auto complete
    "Plugin 'Valloric/YouCompleteMe'

    "FOLDING
    Plugin 'tmhedberg/SimpylFold'

    " Edit files using sudo/su
    Plugin 'chrisbra/SudoEdit.vim'

    " Fuzzy finder (files, mru, etc)
    Plugin 'ctrlpvim/ctrlp.vim'

    " A pretty statusline, bufferline integration
    "Plugin 'itchyny/lightline.vim'
    Plugin 'bling/vim-bufferline'
    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'

    " Easy... motions... yeah.
    Plugin 'Lokaltog/vim-easymotion'

    " Glorious colorscheme
    Plugin 'nanotech/jellybeans.vim'
    Plugin 'whatyouhide/vim-gotham'
    Plugin 'tomasr/molokai'
    
    " Autoclose (, " etc
    Plugin 'Townk/vim-autoclose'

    " Git wrapper inside Vim
    "Plugin 'tpope/vim-fugitive'

    " Handle surround chars like ''
    Plugin 'tpope/vim-surround'

    " Snippets like textmate
   "Plugin 'MarcWeber/vim-addon-mw-utils'
   "Plugin 'tomtom/tlib_vim'
   "Plugin 'honza/vim-snippets'
   "Plugin 'garbas/vim-snipmate'

    " A fancy start screen, shows MRU etc.
    Plugin 'mhinz/vim-startify'

    " Vim signs (:h signs) for modified lines based off VCS (e.g. Git)
   "Plugin 'mhinz/vim-signify'

    " Awesome syntax checker.
    " REQUIREMENTS: See :h syntastic-intro
   "Plugin 'scrooloose/syntastic'
    " HTML COLORS IN VIM 
    Plugin 'ap/vim-css-color'

    " Functions, class data etc.
    " REQUIREMENTS: (exuberant)-ctags
    Plugin 'majutsushi/tagbar'

    " Finish Vundle stuff
    call vundle#end()

    """ Installing plugins the first time, quits when done {{{
        if has_vundle == 0
            :silent! PluginInstall
            :qa
        endif
    """ }}}
""" }}}
""" Local leading config, only use for prerequisites as it will be
""" overwritten by anything below {{{{
    if filereadable($HOME."/.vimrc.first")
        source $HOME/.vimrc.first
    endif
""" }}}
""" User interface {{{
    """ Syntax highlighting {{{
        filetype plugin indent on                   " detect file plugin+indent
        syntax on                                   " syntax highlighting
        set background=dark                         " we're using a dark bg
        colorscheme monochrome                      " colorscheme from plugin
        """ force behavior and filetypes, and by extension highlighting {{{
            augroup FileTypeRules
                autocmd!
                autocmd BufNewFile,BufRead *.md set ft=markdown tw=79
                autocmd BufNewFile,BufRead *.tex set ft=tex tw=79
                autocmd BufNewFile,BufRead *.txt set ft=sh tw=79
            augroup END
        """ }}}
        """ 256 colors for maximum jellybeans bling. See commit log for info {{{
            "if (&term =~ "xterm") || (&term =~ "screen")
                set t_Co=256
            "endif
        """ }}}
        """ Custom highlighting, where NONE uses terminal background {{{
            function! CustomHighlighting()
                highlight Normal ctermbg=NONE
                highlight NonText ctermbg=NONE
                highlight LineNr ctermbg=NONE
                highlight SignColumn ctermbg=NONE
                highlight SignColumn guibg=#151515
                highlight CursorLine ctermbg=235
            endfunction

            call CustomHighlighting()
        """ }}}
    """ }}}
    """ Interface general {{{
        set cursorline                              " hilight cursor line
        set more                                    " ---more--- like less
        set number                                  " line numbers
        set scrolloff=3                             " lines above/below cursor
        set showcmd                                 " show cmds being typed
        set title                                   " window title
        set vb t_vb=                                " disable beep and flashing
        set wildignore=*.a,*.o,*.so,*.pyc,*.jpg,
                    \*.jpeg,*.png,*.gif,*.pdf,*.git,
                    \*.swp,*.swo                    " tab completion ignores
        set wildmenu                                " better auto complete
        set wildmode=longest,list                   " bash-like auto complete
        """ Depending on your setup you may want to enforce UTF-8.
        """ Should generally be set in your environment LOCALE/$LANG {{{
             "set encoding=utf-8                    " default $LANG/latin1
             set fileencoding=utf-8                " default none
        """ }}}
    """ }}}
""" }}}
""" General settings {{{
    set hidden                                      " buffer change, more undo
    set history=1000                                " default 20
    set iskeyword+=_,$,@,%,#,-                        " not word dividers
    set laststatus=2                                " always show statusline
    set linebreak                                   " don't cut words on wrap
    set listchars=tab:>\                            " > to highlight <tab>
    set list                                        " displaying listchars
    set mouse=                                      " disable mouse
    set noshowmode                                  " hide mode cmd line
    set noexrc                                      " don't use other .*rc(s)
    set nostartofline                               " keep cursor column pos
   "set nowrap                                      " don't wrap lines
    set numberwidth=5                               " 99999 lines
    set shortmess+=I                                " disable startup message
    set splitbelow                                  " splits go below w/focus
    set splitright                                  " vsplits go right w/focus
    set ttyfast                                     " for faster redraws etc
    """ Folding {{{
        set foldcolumn=0                            " hide folding column
        set foldmethod=indent                       " folds using indent
        set foldnestmax=10                          " max 10 nested folds
        set foldlevelstart=99                       " folds open by default
    """ }}}
    """ Search and replace {{{
        set gdefault                                " default s//g (global)
        set incsearch                               " "live"-search
    """ }}}
    """ Matching {{{
        set matchtime=2                             " time to blink match {}
        set matchpairs+=<:>                         " for ci< or ci>
        set showmatch                               " tmpjump to match-bracket
    """ }}}
    """ Return to last edit position when opening files {{{
        augroup LastPosition
            autocmd! BufReadPost *
                \ if line("'\"") > 0 && line("'\"") <= line("$") |
                \     exe "normal! g`\"" |
                \ endif
        augroup END
    """ }}}
""" }}}
""" Files {{{
    set autochdir                                   " always use curr. dir.
    set autoread                                    " refresh if changed
    set confirm                                     " confirm changed files
    set noautowrite                                 " never autowrite
    set nobackup                                    " disable backups
    """ Persistent undo. Requires Vim 7.3 {{{
        if has('persistent_undo') && exists("&undodir")
            set undodir=$HOME/.vim/undo/            " where to store undofiles
            set undofile                            " enable undofile
            set undolevels=1000                      " max undos stored
            set undoreload=10000                    " buffer stored undos
        endif
    """ }}}
    """ Swap files, unless vim is invoked using sudo. Inspired by tejr's vimrc
    """ https://github.com/tejr/dotfiles/blob/master/vim/vimrc {{{
        if !strlen($SUDO_USER)
            set directory^=$HOME/.vim/swap//        " default cwd, // full path
            set swapfile                            " enable swap files
            set updatecount=50                      " update swp after 50chars
            """ Don't swap tmp, mount or network dirs {{{
                augroup SwapIgnore
                    autocmd! BufNewFile,BufReadPre /tmp/*,/mnt/*,/media/*
                                \ setlocal noswapfile
                augroup END
            """ }}}
        else
            set noswapfile                          " dont swap sudo'ed files
        endif
    """ }}}
""" }}}
""" Text formatting {{{
    set autoindent                                  " preserve indentation
    set backspace=indent,eol,start                  " smart backspace
    set cinkeys-=0#                                 " don't force # indentation
    set expandtab                                   " no real tabs
    set ignorecase                                  " by default ignore case
    set nrformats+=alpha                            " incr/decr letters C-a/-x
    set shiftround                                  " be clever with tabs
    set shiftwidth=4                                " default 8
    set smartcase                                   " sensitive with uppercase
    set smarttab                                    " tab to 0,4,8 etc.
    set softtabstop=4                               " "tab" feels like <tab>
   "set tabstop=4                                   " replace <TAB> w/4 spaces
    """ Only auto-comment newline for block comments {{{
        augroup AutoBlockComment
            autocmd! FileType c,cpp setlocal comments -=:// comments +=f://
        augroup END
    """ }}}
    """ Take comment leaders into account when joining lines, :h fo-table
    """ http://ftp.vim.org/pub/vim/patches/7.3/7.3.541 {{{
        if has("patch-7.3.541")
            set formatoptions+=j
        endif
    """ }}}
""" }}}
""" Keybindings {{{
    """ General {{{
        " Remap <leader>
        let mapleader=","

        " Quickly edit/source .vimrc
        noremap <leader>ve :edit $HOME/.vimrc<CR>
        noremap <leader>vs :source $HOME/.vimrc<CR>

        " Yank and paste to/from system clipboard
        noremap <leader>y "+y
        noremap <leader>p "+p

        " Toggle folding
        nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
        vnoremap <Space> zf

        " Bubbling (bracket matching)
        nmap <C-up> [e
        nmap <C-down> ]e
        vmap <C-up> [egv
        vmap <C-down> ]egv

        " Scroll up/down lines from 'scroll' option, default half a screen
        map <C-j> <C-d>
        map <C-k> <C-u>

        " Treat wrapped lines as normal lines
        nnoremap j gj
        nnoremap k gk

        " We don't need any help!
        inoremap <F1> <nop>
        nnoremap <F1> <nop>
        vnoremap <F1> <nop>
        map <F2> :NERDTreeToggle<CR>
        nmap <F3> :set relativenumber!<CR>

        "DISABLE SEARCH HIGHLIGHT WITH ESC
        nnoremap <esc> :noh<return><esc>
        " Disable annoying ex mode (Q)
        map Q <nop>

        " Buffers, preferred over tabs now with bufferline.
        nnoremap gn :bnext<CR>
        nnoremap gp :bprevious<CR>
        nnoremap gd :bdelete<CR>
        nnoremap gf <C-^>
    """ }}}
    """ Functions and/or fancy keybinds {{{{
        """ Vim motion on next found object like ci", but for ([{< etc
        """ - http://stackoverflow.com/a/14651443/1076493
        """ Based on gist by @AndrewRadev
        """ - https://gist.github.com/AndrewRadev/1171559
        """ For a crazier version with directions, more objects etc. see
        """ - https://bitbucket.org/sjl/dotfiles/src/default/vim/vimrc {{{
            function! s:NextTextObject(motion)
                echo
                let c = nr2char(getchar())
                exe "normal! f".c."v".a:motion.c
            endfunction

            onoremap a :<C-u>call <SID>NextTextObject('a')<CR>
            xnoremap a :<C-u>call <SID>NextTextObject('a')<CR>
            onoremap i :<C-u>call <SID>NextTextObject('i')<CR>
            xnoremap i :<C-u>call <SID>NextTextObject('i')<CR>
        """ }}}
        """ Toggle syntax highlighting {{{
            function! ToggleSyntaxHighlighthing()
                if exists("g:syntax_on")
                    syntax off
                else
                    syntax on
                    call CustomHighlighting()
                endif
            endfunction

            nnoremap <leader>s :call ToggleSyntaxHighlighthing()<CR>
        """ }}}
        """ Toggle text wrapping, wrap on whole words
        """ For more info see: http://stackoverflow.com/a/2470885/1076493 {{{
            function! WrapToggle()
                if &wrap
                    set list
                    set nowrap
                else
                    set nolist
                    set wrap
                endif
            endfunction

            nnoremap <leader>w :call WrapToggle()<CR>
        """ }}}
        """ Remove multiple empty lines {{{
            function! DeleteMultipleEmptyLines()
                g/^\_$\n\_^$/d
            endfunction

            nnoremap <leader>ld :call DeleteMultipleEmptyLines()<CR>
        """ }}}
        """ Split to relative header/source {{{
            function! SplitRelSrc()
                let s:fname = expand("%:t:r")

                if expand("%:e") == "h"
                    set nosplitright
                    exe "vsplit" fnameescape(s:fname . ".cpp")
                    set splitright
                elseif expand("%:e") == "cpp"
                    exe "vsplit" fnameescape(s:fname . ".h")
                endif
            endfunction

            nnoremap <leader>le :call SplitRelSrc()<CR>
        """ }}}
        """ Strip trailing whitespace, return to cursor at save {{{
            function! <SID>StripTrailingWhitespace()
                let l = line(".")
                let c = col(".")
                %s/\s\+$//e
                call cursor(l, c)
            endfunction

            augroup StripTrailingWhitespace
                autocmd!
                autocmd FileType c,cpp,cfg,conf,css,html,perl,python,sh,tex
                            \ autocmd BufWritePre <buffer> :call
                            \ <SID>StripTrailingWhitespace()
            augroup END
        """ }}}
    """ }}}
    """ Plugins {{{
        " Toggle tagbar (definitions, functions etc.)
        map <F1> :TagbarToggle<CR>

        " Toggle pastemode, doesn't indent
        set pastetoggle=<F3>

    """ }}}
""" }}}
""" Plugin settings {{{
    " Startify, the fancy start page
    let g:ctrlp_reuse_window = 'startify' " don't split in startify
    let g:startify_bookmarks = [
        \ $HOME . "/.vimrc", $HOME . "/.vimrc.first",
        \ $HOME . "/.vimrc.last", $HOME . "/.vimrc.plugins"
        \ ]

    " CtrlP - don't recalculate files on start (slow)
    let g:ctrlp_clear_cache_on_exit = 1
    let g:ctrlp_working_path_mode = 'ra'

    " TagBar
    let g:tagbar_left = 0
    let g:tagbar_width = 30
    set tags=tags;/


    " Netrw - the bundled (network) file and directory browser
    let g:netrw_banner = 0
    let g:netrw_list_hide = '^\.$'
    let g:netrw_liststyle = 3

    " Automatically remove preview window after autocomplete (mainly for clang_complete)
    augroup RemovePreview
        autocmd!
        autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
        autocmd InsertLeave * if pumvisible() == 0|pclose|endif
    augroup END

    """ My StatusLine {{{
    let g:currentmode={
        \ 'n'  : 'N ',
        \ 'no' : 'N·Operator Pending ',
        \ 'v'  : 'V ',
        \ 'V'  : 'V·Line ',
        \ '' : 'V·Block ',
        \ 's'  : 'Select ',
        \ 'S'  : 'S·Line ',
        \ '^s' : 'S·Block ',
        \ 'i'  : 'I ',
        \ 'R'  : 'R ',
        \ 'Rv' : 'V·Replace ',
        \ 'c'  : 'Command ',
        \ 'cv' : 'Vim Ex ',
        \ 'ce' : 'Ex ',
        \ 'r'  : 'Prompt ',
        \ 'rm' : 'More ',
        \ 'r?' : 'Confirm ',
        \ '!'  : 'Shell ',
    \ 't'  : 'Terminal '
        \}

    function! ReadOnly()
    if &readonly || !&modifiable
        return '!'
    else
        return ''
    endfunction

    set statusline=
    set statusline+=%0*\ %{toupper(g:currentmode[mode()])}
    set statusline+=%8*\ %<%F\ %{ReadOnly()}\ %m\ 
    set statusline+=%9*\ %=                                  " Space
    set statusline+=%8*\ %y                               " FileType
    set statusline+=%7*\ %{(&fenc!=''?&fenc:&enc)}\ %{&ff}\ " Encoding & Fileformat
    """}}}
    """" Lightline {{{
        "let g:lightline = {
            "\ 'colorscheme': '',
            "\ 'active': {
            "\     'left': [
            "\         ['mode', 'paste'],
            "\         ['readonly'],
            "\         ['ctrlpmark', 'bufferline']
            "\     ],
            "\     'right': [
            "\         ['lineinfo'],
            "\         ['percent'],
            "\         ['filetype' ]
            "\     ]
            "\ },
            "\ 'component': {
            "\     'paste': '%{&paste?"!":""}'
            "\ },
            "\ 'component_function': {
            "\     'mode'         : 'MyMode',
            "\     'fugitive'     : 'MyFugitive',
            "\     'readonly'     : 'MyReadonly',
            "\     'ctrlpmark'    : 'CtrlPMark',
            "\     'bufferline'   : 'MyBufferline',
            "\     'fileformat'   : 'MyFileformat',
            "\     'fileencoding' : 'MyFileencoding',
            "\     'filetype'     : 'MyFiletype'
            "\ },
            "\ 'component_expand': {
            "\     'syntastic': 'SyntasticStatuslineFlag',
            "\ },
            "\ 'component_type': {
            "\     'syntastic': 'middle',
            "\ },
            "\ 'subseparator': {
            "\     'left': '|', 'right': '|'
            "\ }
            "\ }

        "let g:lightline.mode_map = {
            "\ 'n'      : ' N ',
            "\ 'i'      : ' I ',
            "\ 'R'      : ' R ',
            "\ 'v'      : ' V ',
            "\ 'V'      : 'V-L',
            "\ 'c'      : ' C ',
            "\ "\<C-v>" : 'V-B',
            "\ 's'      : ' S ',
            "\ 'S'      : 'S-L',
            "\ "\<C-s>" : 'S-B',
            "\ '?'      : '      ' }

        "function! MyMode()
            "let fname = expand('%:t')
            "return fname == '__Tagbar__' ? 'Tagbar' :
                    "\ fname == 'ControlP' ? 'CtrlP' :
                    "\ winwidth('.') > 60 ? lightline#mode() : ''
        "endfunction

        "function! MyFugitive()
            "try
                "if expand('%:t') !~? 'Tagbar' && exists('*fugitive#head')
                    "let mark = '± '
                    "let _ = fugitive#head()
                    "return strlen(_) ? mark._ : ''
                "endif
            "catch
            "endtry
            "return ''
        "endfunction

        "function! MyReadonly()
            "return &ft !~? 'help' && &readonly ? '≠' : '' " or ⭤
        "endfunction

        "function! CtrlPMark()
            "if expand('%:t') =~ 'ControlP'
                "call lightline#link('iR'[g:lightline.ctrlp_regex])
                "return lightline#concatenate([g:lightline.ctrlp_prev, g:lightline.ctrlp_item
                    "\ , g:lightline.ctrlp_next], 0)
            "else
                "return ''
            "endif
        "endfunction

        "function! MyBufferline()
            "call bufferline#refresh_status()
            "let b = g:bufferline_status_info.before
            "let c = g:bufferline_status_info.current
            "let a = g:bufferline_status_info.after
            "let alen = strlen(a)
            "let blen = strlen(b)
            "let clen = strlen(c)
            "let w = winwidth(0) * 4 / 11
            "if w < alen+blen+clen
                "let whalf = (w - strlen(c)) / 2
                "let aa = alen > whalf && blen > whalf ? a[:whalf] : alen + blen < w - clen || alen < whalf ? a : a[:(w - clen - blen)]
                "let bb = alen > whalf && blen > whalf ? b[-(whalf):] : alen + blen < w - clen || blen < whalf ? b : b[-(w - clen - alen):]
                "return (strlen(bb) < strlen(b) ? '...' : '') . bb . c . aa . (strlen(aa) < strlen(a) ? '...' : '')
            "else
                "return b . c . a
            "endif
        "endfunction

        "function! MyFileformat()
            "return winwidth('.') > 90 ? &fileformat : ''
        "endfunction

        "function! MyFileencoding()
            "return winwidth('.') > 80 ? (strlen(&fenc) ? &fenc : &enc) : ''
        "endfunction

        "function! MyFiletype()
            "return winwidth('.') > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
        "endfunction

        "let g:ctrlp_status_func = {
            "\ 'main': 'CtrlPStatusFunc_1',
            "\ 'prog': 'CtrlPStatusFunc_2',
            "\ }

        "function! CtrlPStatusFunc_1(focus, byfname, regex, prev, item, next, marked)
            "let g:lightline.ctrlp_regex = a:regex
            "let g:lightline.ctrlp_prev = a:prev
            "let g:lightline.ctrlp_item = a:item
            "let g:lightline.ctrlp_next = a:next
            "return lightline#statusline(0)
        "endfunction

        "function! CtrlPStatusFunc_2(str)
            "return lightline#statusline(0)
        "endfunction

        "let g:tagbar_status_func = 'TagbarStatusFunc'

        "function! TagbarStatusFunc(current, sort, fname, ...) abort
            "let g:lightline.fname = a:fname
            "return lightline#statusline(0)
        "endfunction


    """" }}}
""" }}}
""" Local ending config, will overwrite anything above. Generally use this. {{{{
    " MINE SETTINGS
    let g:ctrlp_show_hidden = 1
    let NERDTreeShowHidden=1

    if filereadable($HOME."/.vimrc.last")
        source $HOME/.vimrc.last
    endif
    let python_highlight_all=1
    set guiheadroom=0
    "let $NVIM_TUI_ENABLE_TRUE_COLOR=1
    let g:deoplete#enable_at_startup = 1
    "let g:clighter_autostart = 1

    nmap n :norm! nzzzv<CR>
    nmap N :norm! Nzzzv<CR>
