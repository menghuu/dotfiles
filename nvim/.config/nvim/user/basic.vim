" vim: tabstop=8 softtabstop=2 shiftwidth=2 expandtab

if &compatible | set nocompatible | endif

let mapleader = "\<space>"

inoreabbrev @@ mail@meng.hu

" modified from https://github.com/itchyny/dotfiles/blob/main/.vimrc
" Data files
let $VIM_DATA = ($XDG_DATA_HOME ? $XDG_DATA_HOME : $HOME . '/.local/share') . '/nvim_vim'
if is_vim
    set history=5000 viminfo='10,/100,:5000,<10,@10,s10,h,n$VIM_DATA/viminfo
else
    set history=5000 shada='10,/100,:5000,<10,@10,s10,h,n$VIM_DATA/shada/main.shada
endif
set nospell spellfile=$VIM_DATA/en.utf-8.add
set swapfile directory=$VIM_DATA/swap,.,/var/tmp/vim,/var/tmp
set nobackup backupdir=$VIM_DATA/backup,/var/tmp/vim,/var/tmp
set undofile undolevels=1000 undodir=$VIM_DATA/undo,/var/tmp/vim,/var/tmp
let g:netrw_home = $VIM_DATA

" Encoding
if &encoding !=? 'utf-8' | let &termencoding = &encoding | endif
  set encoding=utf-8 fileencoding=utf-8 fileformats=unix,mac,dos
  set fileencodings=utf-8,iso-2022-jp-3,euc-jisx0213,cp932,euc-jp,sjis,jis,latin,iso-2022-jp

set mouse=a
set number
set timeoutlen=500
set cursorline cursorcolumn
" 为了启用 true color
" see https://stackoverflow.com/questions/62702766/termguicolors-in-vim-makes-everything-black-and-white
if has("termguicolors")
  " fix bug for vim
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

  " enable true color
  set termguicolors
endif
" 总是显示状态栏; 总是显示标签页的行; gui程序的状态栏和标签页行使用和命令行模式下一致，否则会使用 GUI 程序
set laststatus=2 showtabline=2 guioptions-=e
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:·,trail:·
set scrolloff=3


if has('folding')
	" 允许代码折叠
	set foldenable

	" 代码折叠默认使用缩进
	set fdm=indent

	" 默认打开所有缩进
	set foldlevel=99
endif


set suffixes=.bak,~,.o,.h,.info,.swp,.obj,.pyc,.pyo,.egg-info,.class

set wildignore=*.o,*.obj,*~,*.exe,*.a,*.pdb,*.lib "stuff to ignore when tab completing
set wildignore+=*.so,*.dll,*.swp,*.egg,*.jar,*.class,*.pyc,*.pyo,*.bin,*.dex
set wildignore+=*.zip,*.7z,*.rar,*.gz,*.tar,*.gzip,*.bz2,*.tgz,*.xz    " MacOSX/Linux
set wildignore+=*DS_Store*,*.ipch
set wildignore+=*.gem
set wildignore+=*.png,*.jpg,*.gif,*.bmp,*.tga,*.pcx,*.ppm,*.img,*.iso
set wildignore+=*.so,*.swp,*.zip,*/.Trash/**,*.pdf,*.dmg,*/.rbenv/**
set wildignore+=*/.nx/**,*.app,*.git,.git
set wildignore+=*.wav,*.mp3,*.ogg,*.pcm
set wildignore+=*.mht,*.suo,*.sdf,*.jnlp
set wildignore+=*.chm,*.epub,*.pdf,*.mobi,*.ttf
set wildignore+=*.mp4,*.avi,*.flv,*.mov,*.mkv,*.swf,*.swc
set wildignore+=*.ppt,*.pptx,*.docx,*.xlt,*.xls,*.xlsx,*.odt,*.wps
set wildignore+=*.msi,*.crx,*.deb,*.vfd,*.apk,*.ipa,*.bin,*.msu
set wildignore+=*.gba,*.sfc,*.078,*.nds,*.smd,*.smc
set wildignore+=*.linux2,*.win32,*.darwin,*.freebsd,*.linux,*.android




" 修正 ScureCRT/XShell 以及某些终端乱码问题，主要原因是不支持一些
" 终端控制命令，比如 cursor shaping 这类更改光标形状的 xterm 终端命令
" 会令一些支持 xterm 不完全的终端解析错误，显示为错误的字符，比如 q 字符
" 如果你确认你的终端支持，不会在一些不兼容的终端上运行该配置，可以注释
if has('nvim')
	set guicursor=
elseif (!has('gui_running')) && has('terminal') && has('patch-8.0.1200')
	let g:termcap_guicursor = &guicursor
	let g:termcap_t_RS = &t_RS
	let g:termcap_t_SH = &t_SH
	set guicursor=
	set t_RS=
	set t_SH=
endif

" 参见 modifyOtherKeys
" let &t_TI = "\<Esc>[>4;2m"
" let &t_TE = "\<Esc>[>4;m"

"----------------------------------------------------------------------
" 文件类型微调
"----------------------------------------------------------------------
augroup InitFileTypesGroup

	" 清除同组的历史 autocommand
	autocmd!

	" C/C++ 文件使用 // 作为注释
	autocmd FileType c,cpp setlocal commentstring=//\ %s

	" markdown 允许自动换行
	autocmd FileType markdown setlocal wrap

	" lisp 进行微调
	autocmd FileType lisp setlocal ts=8 sts=2 sw=2 et

	" scala 微调
	autocmd FileType scala setlocal sts=4 sw=4 noet

	" haskell 进行微调
	autocmd FileType haskell setlocal et

	" quickfix 隐藏行号
	autocmd FileType qf setlocal nonumber

	autocmd FileType sh setlocal commentstring=#\ %s

	autocmd FileType vim setlocal commentstring=\"\ %s foldmethod=marker

	autocmd FileType python setlocal commentstring=#\ %s

	" 强制对某些扩展名的 filetype 进行纠正
	autocmd BufNewFile,BufRead *.as setlocal filetype=actionscript
	autocmd BufNewFile,BufRead *.pro setlocal filetype=prolog
	autocmd BufNewFile,BufRead *.es setlocal filetype=erlang
	autocmd BufNewFile,BufRead *.asc setlocal filetype=asciidoc
	autocmd BufNewFile,BufRead *.vl setlocal filetype=verilog
augroup END


augroup vimrc
  autocmd!
augroup END

" Move to the directory each buffer
"  autocmd vimrc BufEnter * silent! lcd %:p:h

" Open quickfix window automatically
autocmd vimrc QuickfixCmdPost [^l]* ++nested copen | wincmd p
autocmd vimrc QuickfixCmdPost l* ++nested lopen | wincmd p

" Close quickfix window when it is the only window
autocmd vimrc WinEnter * if &l:buftype ==# 'quickfix' && winnr('$') == 1 | quit | endif

" Fix window position of help
"  autocmd vimrc FileType help if &l:buftype ==# 'help' | wincmd K | endif

" 取消terminal的行号，开启terminal自身的颜色
"  autocmd vimrc TermOpen * setlocal nonumber termguicolors

" Always open read-only when a swap file is found
autocmd vimrc SwapExists * let v:swapchoice = 'o'

" " Automatically set expandtab
autocmd vimrc FileType * execute 'setlocal ' . (search('^\t.*\n\t.*\n\t', 'n') ? 'no' : '') . 'expandtab'

" 恢复我的光标位置
autocmd vimrc BufReadPost *
  \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
  \ |   exe "normal! g`\""
  \ | endif
