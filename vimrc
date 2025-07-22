call plug#begin('~/.vim/plugged')

" Your plugins go here
Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'

Plug 'dense-analysis/ale'
Plug 'rust-lang/rust.vim'

Plug 'morhetz/gruvbox'

Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'wellle/context.vim' 
Plug 'justinmk/vim-dirvish'

" Ruby Support
Plug 'vim-ruby/vim-ruby'           " Official Ruby support
Plug 'tpope/vim-bundler'           " Bundler integration

let g:ale_linters = { 'rust': ['analyzer'], 'ruby': ['rubocop', 'solargraph']}
let g:ale_fixers = {'rust': ['rustfmt'], 'ruby': ['rubocop']}
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_rust_rustfmt_options = '--edition 2021'

set number
set completeopt=menu,menuone,preview,noselect,noinsert
set termguicolors
set cursorline
set signcolumn=number
set mouse=a
set foldmethod=syntax
set foldcolumn=1

call plug#end()

colorscheme gruvbox
set background=dark

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>,
nnoremap gd :ALEGoToDefinition<CR>
nnoremap <C-]> :ALEGoToDefinition<CR>

