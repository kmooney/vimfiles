call plug#begin('~/.vim/plugged')

Plug 'rust-lang/rust.vim'
Plug 'dense-analysis/ale'
Plug 'morhetz/gruvbox'
Plug 'catppuccin/vim', { 'as': 'catppuccin' }
Plug 'junegunn/fzf', {'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'justinmk/vim-dirvish'
Plug 'SmiteshP/nvim-navic'
Plug 'NLKNguyen/papercolor-theme'

" Ruby Support
Plug 'vim-ruby/vim-ruby'           " Official Ruby support
Plug 'tpope/vim-bundler'           " Bundler integration
Plug 'tpope/vim-fugitive'
Plug 'preservim/vim-markdown'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install' }

" Add nvim-lspconfig to your plugins
Plug 'neovim/nvim-lspconfig'

" completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'"


" Disable ALE LSP
let g:ale_disable_lsp = 1

let g:vim_markdown_folding_enabled = 0
let g:vim_markdown_folding_level = 0
let g:vim_markdown_toc_autofit = 1

let g:ale_linters = { 'rust': ['analyzer'], 'ruby': ['standardrb'], 'markdown': ['markdownlint'], 'javascript': ['eslint'], 'vue': ['eslint', 'vue_ls'], 'typescript': ['eslint', 'tsserver']}
let g:ale_fixers = { 'rust': ['rustfmt'],'ruby': ['standardrb'], 'markdown': ['prettier'],  'vue': ['eslint'],  'typescript': ['eslint'], 'javascript': ['eslint']}
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
"set foldmethod=syntax
"set foldlevel=1
set foldcolumn=0

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
local navic = require("nvim-navic")

local lspconfig = require('lspconfig')
local configs = require('lspconfig.configs')

if not configs.vue_language_server then
  configs.vue_language_server = {
    default_config = {
      cmd = { 'vue-language-server', '--stdio' },
      filetypes = { 'vue' },
      root_dir = lspconfig.util.root_pattern('package.json', '.git'),
    },
  }
end

-- Setup the server
lspconfig.vue_language_server.setup{}

require'lspconfig'.solargraph.setup{
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentSymbolProvider then
      navic.attach(client, bufnr)
    end
  end,
  settings = {
  solargraph = {
      diagnostics = false
    }
  }
}

require'lspconfig'.rust_analyzer.setup{}

vim.o.winbar = '%{%v:lua.require("nvim-navic").get_location()%}'
vim.api.nvim_set_hl(0, "NavicSeparator", { bg = "#aa55aa" })
require'lspconfig'.eslint.setup{}
require'lspconfig'.ts_ls.setup{
  filetypes = { 'typescript', 'javascript', 'vue' },
  init_options = {
    plugins = {
      { name = '@vue/typescript-plugin', location = '/opt/homebrew/lib/node_modules/@vue/language-server', languages = { 'vue' } }
    }
  }
}

-- Key mappings
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
-- vim.keymap.set('n', '<C-]>', vim.lsp.buf.definition)
vim.keymap.set('n', 'K', vim.lsp.buf.hover) 
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', '<C-Q>', ':q<CR>')

vim.keymap.set('n', '<C-]>', function()
  vim.lsp.buf.definition()
end)

vim.diagnostic.config({
  virtual_text = true,
})

-- In your plugin manager
require('cmp').setup({
  sources = {
    { name = 'nvim_lsp' },
  },
  mapping = require('cmp').mapping.preset.insert({
    ['<C-Space>'] = require('cmp').mapping.complete(),
    ['<CR>'] = require('cmp').mapping.confirm({ select = true }),
  }),
})

EOF


