set nowrapscan
set hlsearch
set incsearch
set number
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
set scrolloff=5
autocmd FileType make,gitconfig setlocal noexpandtab " use tabs in these types
set laststatus=2
syntax on
set term=xterm-256color
colorscheme wombat256

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='100,\"100,:50,%,n~/.viminfo

function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

augroup resCur
    autocmd!
    autocmd BufWinEnter * call ResCur()
augroup END

" Trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Long lines
highlight OverLength ctermbg=black
autocmd FileType * 2match OverLength /\%81v./
autocmd FileType gitcommit highlight OverLength ctermbg=red
autocmd FileType gitcommit 2match OverLength /\%71v./

" show tabs
set list
set listchars=tab:T>

