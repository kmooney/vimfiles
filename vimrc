call plug#begin('~/.vim/plugged')

" Your plugins go here
Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'

Plug 'dense-analysis/ale'
Plug 'rust-lang/rust.vim'

Plug 'morhetz/gruvbox'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'wellle/context.vim' 
Plug 'justinmk/vim-dirvish'

" Ruby Support
Plug 'vim-ruby/vim-ruby'           " Official Ruby support
Plug 'tpope/vim-bundler'           " Bundler integration

Plug 'tpope/vim-fugitive'

Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" Add nvim-lspconfig to your plugins
Plug 'neovim/nvim-lspconfig'

" Disable ALE LSP
let g:ale_disable_lsp = 1

let g:vim_markdown_folding_enabled = 1
let g:vim_markdown_folding_level = 2
let g:vim_markdown_toc_autofit = 1

let g:ale_disable_lsp = 1

let g:ale_linters = { 'rust': ['analyzer'], 'ruby': ['standardrb'], 'markdown': ['markdownlint'], 'javascript': ['eslint'], 'vue': ['eslint', 'vue_ls'], 'typescript': ['eslint', 'tsserver']}
let g:ale_fixers = {'rust': ['rustfmt'], 'ruby': ['standardrb'], 'markdown': ['prettier'], 'vue': ['eslint'], 'typescript': ['eslint'], 'javascript': ['eslint']}
let g:ale_completion_enabled = 1
let g:ale_fix_on_save = 1
let g:ale_rust_rustfmt_options = '--edition 2021'

autocmd FileType markdown setlocal wrap linebreak
autocmd FileType markdown setlocal textwidth=80

set number
set completeopt=menu,menuone,preview,noselect,noinsert
set termguicolors
set cursorline
set signcolumn=number
set mouse=a
set foldmethod=syntax
set foldlevel=99
set foldcolumn=1

call plug#end()

" colorscheme gruvbox
colorscheme catppuccin_mocha
set background=dark

nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nnoremap <C-p> :Files<CR>
nnoremap <C-b> :Buffers<CR>,


let mapleader = ","
nnoremap <leader>d i<C-R>=strftime("%Y-%m-%d")<CR><esc>
inoremap <C-d> <C-R>=strftime("%Y-%m-%d")<CR>

" After call plug#end(), add:
lua << EOF
require'lspconfig'.solargraph.setup{}
require'lspconfig'.vue_ls.setup{}
require'lspconfig'.eslint.setup{}

-- Key mappings
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
-- vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition)
vim.keymap.set('n', '<C-[>', '<C-o>')
vim.keymap.set('n', 'K', vim.lsp.buf.hover) 
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', '<C-Q>', '<C-o>:q<CR>')

vim.keymap.set('n', '<C-]>', function()
  vim.cmd('split')
  vim.lsp.buf.definition()
end)

EOF


