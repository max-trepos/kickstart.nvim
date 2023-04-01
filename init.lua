--[[

=====================================================================
==================== READ THIS BEFORE CONTINUING ====================
=====================================================================

Kickstart.nvim is *not* a distribution.

Kickstart.nvim is a template for your own configuration.
  The goal is that you can read every line of code, top-to-bottom, and understand
  what your configuration is doing.

  Once you've done that, you should start exploring, configuring and tinkering to
  explore Neovim!

  If you don't know anything about Lua, I recommend taking some time to read through
  a guide. One possible example:
  - https://learnxinyminutes.com/docs/lua/

  And then you can explore or search through `:help lua-guide`


Kickstart Guide:

I have left several `:help X` comments throughout the init.lua
You should run that command and read that help section for more information.

In addition, I have some `NOTE:` items throughout the file.
These are for you, the reader to help understand what is happening. Feel free to delete
them once you know what you're doing, but they should serve as a guide for when you
are first encountering a few different constructs in your nvim config.

I hope you enjoy your Neovim journey,
- TJ

P.S. You can delete this when you're done too. It's your config now :)
--]]

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Neovide
vim.cmd([[

set rtp+=D:\Dropbox\Apps\MobaXterm_root\nvim
" DEtect for WSL
function! Is_WSL() abort
  let proc_version = '/proc/version'
  return filereadable(proc_version)
        \  ? !empty(filter(
        \    readfile(proc_version, '', 1), { _, val -> val =~? 'microsoft' }))
        \  : 0
        " \  : v:false
endfunction

if has ("GuiFont")
	GuiFont  Hack NF:h10
endif
"
" neovide
set guifont=Hack\ NF:h10
let g:neovide_cursor_animate_in_insert_mode=v:false
let g:neovide_remember_window_size = v:true

command! -nargs=1 -complete=file TablineTabNew1 :lua require'tabline'.tab_new(<f-args>)

if Is_WSL() == 1 
  let configpath="/mnt/d/Dropbox/Apps/MobaXterm_root/" 
  nnoremap <Leader>iv :tabe /mnt/d/Dropbox/Apps/MobaXterm_root/nvim/init.vim<CR> <bar> :tcd ~/.config/nvim<CR> 
  nnoremap <Leader>al :TablineTabNew /mnt/d/Dropbox/Apps/Alacritty/alacritty.yaml<CR>
  nnoremap <Leader>ah :TablineTabNew /mnt/d/Dropbox/scripts/auto_hot_key/ahk_program_run.ahk<CR> <bar> :tcd /mnt/d/Dropbox/scripts/auto_hot_key<CR>
  nnoremap <Leader>wz :TablineTabNew /mnt/d/Dropbox/Apps/WezTerm/wezterm.lua<CR> <bar> :tcd /mnt/d/Dropbox/Apps/WezTerm<CR>
  let xrtp=configpath . "nvim" 
  let plugpath=xrtp . "/plugged"
  set rtp+=/mnt/d/Dropbox/Apps/MobaXterm_root/nvim
  " echom "Max was here"
  "
  let g:startify_session_dir = '~/.config/nvim/session'
else
  let configpath="D:\\Dropbox\\Apps\\MobaXterm_root\\"
  nnoremap <Leader>iv :tabe D:\Dropbox\Apps\MobaXterm_root\nvim\init.vim<CR> <bar> :tcd D:\Dropbox\Apps\MobaXterm_root\nvim
  nnoremap <Leader>ah :tabe D:\Dropbox\scripts\auto_hot_key\ahk_program_run.ahk<CR> <bar> :tcd D:\Dropbox\scripts\auto_hot_key
  nnoremap <Leader>wz :TablineTabNew D:\Dropbox\Apps\WezTerm\wezterm.lua<CR> <bar> :tcd D:\Dropbox\Apps\WezTerm<CR>
  let xrtp=configpath . "nvim"
  let plugpath=xrtp . "\\plugged"
  let g:startify_session_dir = 'D:\\Dropbox\\Apps\\MobaXterm_root\\'
endif
"
"Startify
"
let g:startify_change_to_dir = 0
let g:startify_session_delete_buffers = 0
let g:startify_bookmarks = ['']
 
" For tabline.nvim
set sessionoptions+=tabpages,globals " store tabpages and globals in session

set autoindent
set tabstop=2 
set expandtab "no replace 4 spaces to tab
set shiftwidth=2
set softtabstop=2
set linebreak
set hlsearch
set ignorecase
"  When scrolling always keep 5 line readable
set  scrolloff=5

" dangerous will witch buffer even not saved, used for toggleterm.nvim
set hidden

set foldmethod=syntax
set nofoldenable
au BufRead * normal zR

" dangerous will witch buffer even not saved, used for toggleterm.nvim
set tags=./tags,tags;/

if has ("syntax")
	syntax on
endif

" Mouse settings
set clipboard=unnamedplus
set mouse+=a
nnoremap <2-LeftMouse> y

function SelectionToClipboard()
	if mode() == "v"
		let selection_start = getcurpos()[1:]
		silent normal! o
		let selection_end = getcurpos()[1:]

		silent normal! "*y

		call cursor(selection_start)
		silent normal! v
		call cursor(selection_end)
		silent normal! o
	endif
endfunction

vnoremap <LeftRelease> <Cmd>call SelectionToClipboard()<cr>

map <Space> <Leader>

noremap <Leader>y "*y
noremap <Leader>p "xp
noremap <Leader>Y "+y
noremap <Leader>P "+p
" Shortcut to use blackhole register by default
nnoremap d "xd
vnoremap d "xd
nnoremap D "xD
vnoremap D "xD
nnoremap c "xc
vnoremap c "xc
nnoremap C "xC
vnoremap C "xC
" nnoremap x "_x
" vnoremap x "_x
" nnoremap X "_X
" vnoremap X "_X" 
"
" Remapping y, so after yanking a block, it will go back to the last position
vnoremap y ygv<Esc>

" REselect by visual what has been pasted
nnoremap <expr> gV '`[' . strpart(getregtype(), 0, 1) . '`]'

" Shift Insert mapped to yanking the * buffer in Insert Mode
inoremap <S-Insert> <C-r>* 

" Allows to move in wrapped lines
nnoremap <expr> <Down> (v:count == 0 ? 'g<down>' : '<down>')
vnoremap <expr> <Down> (v:count == 0 ? 'g<down>' : '<down>')
nnoremap <expr> <Up> (v:count == 0 ? 'g<up>' : '<up>')
vnoremap <expr> <Up> (v:count == 0 ? 'g<up>' : '<up>')
"
" shift+arrow selection
nmap <S-Up> V<Up>
nmap <S-Down> V<Down>
nmap <S-Left> v<Left>
nmap <S-Right> v<Right>
vmap <S-Up> <Up>
vmap <S-Down> <Down>
vmap <S-Left> <Left>
vmap <S-Right> <Right>
"Visual blocck
imap <S-Up> <Esc>V<Up>
imap <S-Down> <Esc>V<Down>
imap <S-Left> <Esc>v<Left>
imap <S-Right> <Esc>v<Right>
vnoremap <A-Down> :m '>+1<CR>gv
vnoremap <A-up> :m '<-2<CR>gv
"Have :W act :w
command! -bang -range=% -complete=file -nargs=* W <line1>,<line2>write<bang> <args>
"Have :Q act :q
command! -bang Q quit<bang>
nnoremap <C-s> <cmd>w<CR>
inoremap <C-s> <Esc><cmd>w<CR>
"
" Some normal editor mappings
noremap <C-Home> gg
noremap <C-End> G
nnoremap <C-Up> <C-e>
inoremap <C-Up> <C-x><C-e>
nnoremap <C-Down> <C-y>
inoremap <C-Down> <C-x><C-y>
noremap <C-Left> b
noremap <C-Right> w

nnoremap <A-End> yyp
nnoremap <A-Up>   {
nnoremap <A-Down> }
"
" inoremap <A-End>  <C-o>D
" nnoremap <A-End>  Da
inoremap <A-End>  <Esc>Ypi
nnoremap <A-End> yyp
inoremap <A-Del>  <C-o>D
nnoremap <A-Del>  Da

inoremap <A-space> <C-x><C-n>
 
noremap <C-h> :%s/<C-r>0/<C-r>0/g
noremap <A-h> :noh<CR>
noremap <A-w> <C-W>w
"
" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

nnoremap <silent> oo :<C-u>call append(line("."),   repeat([""], v:count1))<CR>
nnoremap <silent> OO :<C-u>call append(line(".")-1,   repeat[""], v:count1))<CR>

" toggle cursor line
nnoremap <leader>l :set cursorline!<cr>

" noremap <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>
noremap <leader>q :Bdelete<CR>
nnoremap <Leader><space> i<space><esc>

nnoremap <Leader>sy :syntax off <CR> :syntax on <CR>
nnoremap <Leader>qc :cclose <CR>
nnoremap <A-c> :cclose <CR>

nnoremap <Leader>; A;<ESC>j

" To replace a word with uanked test in normal mode (Stamp)
nnoremap S diw"0P

nnoremap <leader>d d
vnoremap <leader>d d
nnoremap <leader>D D
vnoremap <leader>D D
nnoremap <leader>c c
vnoremap <leader>c c
nnoremap <leader>C C
vnoremap <leader>C C
nnoremap <leader>x x
vnoremap <leader>x x
nnoremap <leader>X X
vnoremap <leader>X X

" First remap <tab> (and <c-i>) to <c-n>
nnoremap <c-n> <tab>

" better ident
nnoremap <Tab> >>_
nnoremap <S-Tab> <<_
inoremap <S-Tab> <C-D>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Datetime functions
nnoremap <leader>ss diw"=strftime("%Y%m%d") . "001" <CR>gP
nnoremap <leader>sd diW"=strftime("%d-%b-%Y") <CR>gPBviWU
nnoremap <leader>sda yiW:%s/\(<C-r>0\)/\=strftime("%d-%b-%Y") /g<CR>''

" Lowercase (su) or Uppercase (sU)  the word under the cursor for all occurances in the file
nnoremap <leader>su yiW:%s/\(<C-r>0\)/\L\1/g<CR>''
nnoremap <leader>sU yiW:%s/\(<C-r>0\)/\U\1/g<CR>''
 
""""""""""""""""""""""""""""""
" => Gutter
""""""""""""""""""""""""""""""
" Show line number and relativenumber 
set number
set relativenumber
highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=NONE guifg=DarkGrey guibg=NONE

""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2
set statusline=\ %F%m%r%h\%w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l\ \ Column:\ %c
"set autochdir

""""""""""""""""""""""""""""""
" trigger `autoread` when files changes on disk
" see https://github.com/neovim/neovim/issues/1936 for issue on neovim, this
" not working
""""""""""""""""""""""""""""""
set autoread
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
" notification after file change
autocmd FileChangedShellPost *
        \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
autocmd FileType help wincmd j


set termguicolors " this variable must be enabled for colors to be applied properly

]])


-- Install package manager
--    https://github.com/folke/lazy.nvim
--    `:help lazy.nvim.txt` for more info
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- NOTE: Here is where you install your plugins.
--  You can configure plugins using the `config` key.
--
--  You can also configure plugins after the setup call,
--    as they will be available in your neovim runtime.
require('lazy').setup({
  -- NOTE: First, some plugins that don't require any configuration



  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  -- NOTE: This is where your plugins related to LSP can be installed.
  --  The configuration is done below. Search for lspconfig to find it below.
  { -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',

      -- Useful status updates for LSP
      -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
      { 'j-hui/fidget.nvim', opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },
  },

  { -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip' },
  },

  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
    },
  },

  -- { -- Theme inspired by Atom
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   config = function()
  --     vim.cmd.colorscheme 'onedark'
  --   end,
  -- },
  {
    -- 'Mofiqul/dracula.nvim',
    'dracula/vim',
    config = function()
      vim.cmd.colorscheme 'dracula'
    end,
  },

  { -- Set lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = false,
        theme = 'onedark',
        component_separators = '|',
        section_separators = '',
      },
    },
  },

  { -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help indent_blankline.txt`
    opts = {
      char = '┊',
      show_trailing_blankline_indent = false,
    },
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  -- Fuzzy Finder (files, lsp, etc)
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' } },

  -- Fuzzy Finder Algorithm which requires local dependencies to be built.
  -- Only load if `make` is available. Make sure you have the system
  -- requirements installed.
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    -- NOTE: If you are having trouble with this installation,
    --       refer to the README for telescope-fzf-native for more instructions.
    build = 'make',
    cond = function()
      return vim.fn.executable 'make' == 1
    end,
  },

  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    config = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  },

  -- NOTE: Next Step on Your Neovim Journey: Add/Configure additional "plugins" for kickstart
  --       These are some example plugins that I've included in the kickstart repository.
  --       Uncomment any of the lines below to enable them.
  -- require 'kickstart.plugins.autoformat',
  -- require 'kickstart.plugins.debug',

  -- NOTE: The import below automatically adds your own plugins, configuration, etc from `lua/custom/plugins/*.lua`
  --    You can use this folder to prevent any conflicts with this init.lua if you're interested in keeping
  --    up-to-date with whatever is in the kickstart repo.
  --
  --    For additional information see: https://github.com/folke/lazy.nvim#-structuring-your-plugins
  --
  --    An additional note is that if you only copied in the `init.lua`, you can just comment this line
  --    to get rid of the warning telling you that there are not plugins in `lua/custom/plugins/`.
  { import = 'custom.plugins' },
}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
vim.o.hlsearch = false

-- Make line numbers default
vim.wo.number = true

-- Enable mouse mode
vim.o.mouse = 'a'

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.o.clipboard = 'unnamedplus'

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true

-- Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.wo.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250
vim.o.timeout = true
vim.o.timeoutlen = 300

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

-- NOTE: You should make sure your terminal supports this
vim.o.termguicolors = true

-- [[ Basic Keymaps ]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'help', 'vim' },

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true },
  indent = { enable = true, disable = { 'python' } },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<M-space>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- LSP settings.
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')
  nmap('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, '[W]orkspace [L]ist Folders')

  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Setup mason so it can manage external tooling
require('mason').setup()

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
    }
  end,
}

-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'

luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
