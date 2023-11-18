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
" set clipboard+=unnamedplus
set clipboard=unnamedplus
" let g:clipboard = {
"                 \   'name': 'WslClipboard',
"                 \   'copy': {
"                 \      '+': 'clip.exe',
"                 \      '*': 'clip.exe',
"                 \    },
"                 \   'paste': {
"                 \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
"                 \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
"                 \   },
"                 \   'cache_enabled': 0,
"                 \ }

set mouse+=a
nnoremap <2-LeftMouse> yiw

" if exists('*SelectionToClipboard')
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
" endif

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

nnoremap <Leader>xf :%!xmllint --format '%' <CR> 
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

""""""""""""""""""""""""""""""
" => Highlight Yank
""""""""""""""""""""""""""""""
" augroup highlight_yank
"     autocmd!
"     au TextYankPost * silent! lua vim.highlight.on_yank{higroup="IncSearch", timeout=2000}
" augroup END

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

  'wellle/targets.vim',
  'junegunn/vim-easy-align',
  -- 'junegunn/vim-peekaboo',
  'godlygeek/tabular',
  'windwp/nvim-autopairs',

  -- Git related plugins
  -- 'tpope/vim-fugitive',
  -- 'tpope/vim-rhubarb',

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
    dependencies = { 'hrsh7th/cmp-nvim-lsp', 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip', 'onsails/lspkind.nvim'
                     , 'hrsh7th/cmp-buffer'
                     , 'hrsh7th/cmp-path'
                     , 'hrsh7th/cmp-cmdline'
                          },
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
    -- dependencies = {
    --   'kdheepak/tabline.nvim',
    -- },
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'dracula',
        component_separators = { left = '', right = ''},
        section_separators = { left = '', right = ''},
        disabled_filetypes = {}
      },
      sections = {
        lualine_a = {'mode'},
        lualine_x = {'branch'},
        lualine_c = { 
                    },
        lualine_y = {
                      { 'diagnostics', sources = {"nvim_diagnostic"}, symbols = {error = ' ', warn = ' ', info = ' ', hint = ' '} },
                      'filetype',
                      {
                        'fileformat',
                        symbols = {
                          unix = '', -- e712
                          dos = '', -- e70f
                          mac = '', -- e711
                        }
                      }, 
                      'encoding'
        },
        lualine_b = {'%r%{getcwd()}%h',
                      {'filename',
                         file_status = true,  -- displays file status (readonly status, modified status)
                         path = 1,            -- 0 = just filename, 1 = relative path, 2 = absolute path
                         shorting_target = 40 -- Shortens path to leave 40 space in the window,
                      }
                    },
        lualine_z = {'location'}
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {{'filename', filestatus = true}},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {{'filename', filestatus = true}},
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
      extensions = {'quickfix'}
    },
  }, -- Set lualine as statusline end

  {
    -- 'Mofiqul/dracula.nvim',
    'kdheepak/tabline.nvim',
    dependencies = {
      'nvim-lualine/lualine.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function()
     require'tabline'.setup {
      -- Defaults configuration options
      enable = true,
      options = {
      -- If lualine is installed tabline will use separators configured in lualine by default.
      -- These options can be used to override those settings.
        section_separators = {'', ''},
        component_separators = {'', ''},
        max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
        show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
        show_devicons = true, -- this shows devicons in buffer section
        show_bufnr = false, -- this appends [bufnr] to buffer section,
        show_filename_only = false, -- shows base filename only instead of relative path in filename
        modified_icon = "+ ", -- change the default modified icon
        modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
        show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
      }
    }
    vim.cmd[[
      set guioptions-=e " Use showtabline in gui vim
      set sessionoptions+=tabpages,globals " store tabpages and globals in session
    ]]
    end,
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
  { 'nvim-telescope/telescope.nvim', version = '*', dependencies = { 'nvim-lua/plenary.nvim' },
    opts ={
      defaults = {file_ignore_patterns = { ".csv", ".xlsx", ".docx", "node_modules" }}
    }
  },

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

  {'chentoast/marks.nvim'},
  {'kylechui/nvim-surround'},
  {'tpope/vim-eunuch'},
  {'akinsho/toggleterm.nvim'},
  {'voldikss/vim-floaterm'},
  {'moll/vim-bbye'},
  {'mhinz/vim-startify'},
  {'skywind3000/asyncrun.vim'},
  {'chrisbra/csv.vim'},
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

  -- {
  -- "kndndrj/nvim-dbee",
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --   },
  --   build = function()
  --     -- Install tries to automatically detect the install method.
  --     -- if it fails, try calling it with one of these parameters:
  --     --    "curl", "wget", "bitsadmin", "go"
  --     require("dbee").install()
  --   end,
  --   config = function()
  --     require("dbee").setup({--[[optional config]]
  --       require("dbee.sources").MemorySource:new({
  --       {
  --         name = "D01",
  --         type = "oracle",
  --         url = "oracle://apps:ForX8ydev@172.16.40.50:1526/oermod01",
  --       }
  --       -- ...
  --     })
  --     })
  --   end,
  -- },

  { import = 'custom.plugins' },

}, {})

-- [[ Setting options ]]
-- See `:help vim.o`

-- Set highlight on search
-- vim.o.hlsearch = false

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
    vim.highlight.on_yank({higroup="IncSearch", timeout=2000})
  end,
  group = highlight_group,
  pattern = '*',
})

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    file_ignore_patterns = { ".csv", ".xlsx", ".docx", "node_modules" }, 
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
-- vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>fb', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>f/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

vim.keymap.set('n', '<leader>fc', require('telescope.builtin').command_history, { desc = 'Command History' })
vim.keymap.set('n', '<leader>ff', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>fh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>fw', require('telescope.builtin').grep_string, { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>fg', require('telescope.builtin').live_grep, { desc = '[S]earch by [G]rep' })
vim.keymap.set('n', '<leader>fd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })

-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
require('nvim-treesitter.configs').setup {
  -- Add languages to be installed here that you want installed for treesitter
  ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'typescript', 'help', 'vim', 'html', 'json', 'javascript'},

  -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
  auto_install = false,

  highlight = { enable = true , disable = { "sql"}},
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

-- Setup nvim-autopairs
require('nvim-autopairs').setup{}

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


  local has_words_before = function()
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
  end
--
-- nvim-cmp setup
local cmp = require 'cmp'
local luasnip = require 'luasnip'
  local lspkind = require("lspkind") -- Pretty icons on the automplete list
  local kind_icons = {
    Text = "",
    Method = "",
    Function = "",
    Constructor = "",
    Field = "",
    Variable = "",
    Class = "ﴯ",
    Interface = "",
    Module = "",
    Property = "ﰠ",
    Unit = "",
    Value = "",
    Enum = "",
    Keyword = "",
    Snippet = "",
    Color = "",
    File = "",
    Reference = "",
    Folder = "",
    EnumMember = "",
    Constant = "",
    Struct = "",
    Event = "",
    Operator = "",
    TypeParameter = ""
  }

-- luasnip.config.setup {}

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      -- ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

      ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif has_words_before() then
            cmp.complete()
          else
            fallback()
          end
        end, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
      { name = 'path' },
      -- { name = 'vsnip' }, -- For vsnip users.
      { name = 'luasnip' }, -- For luasnip users.
      -- { name = 'ultisnips' }, -- For ultisnips users.
      -- { name = 'snippy' }, -- For snippy users.
    }, {
      { name = 'buffer',
            option = {
                      -- Options go into this table
                      keyword_length = 4,
                      get_bufnrs = function()
                                      local bufs = {}
                                      for _, win in ipairs(vim.api.nvim_list_wins()) do
                                        bufs[vim.api.nvim_win_get_buf(win)] = true
                                      end
                                      return vim.tbl_keys(bufs)
                                    end
                     },
      },
    }),
    formatting = {
     format = function(entry, vim_item)
      -- Kind icons
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
      -- Source
       vim_item.menu = ({
         buffer = "[Buf]",
         nvim_lsp = "[LSP]",
         luasnip = "[LuaSnip]",
         nvim_lua = "[Lua]",
         latex_symbols = "[LaTeX]",
       })[entry.source.name]
       return vim_item
     end
     --   format = lspkind.cmp_format({
     --       mode = "symbol_text",
     --       menu = {
     --           buffer = "[Buf]",
     --           nvim_lsp = "[Lsp]",
     --           luasnip = "[Snip]",
     --           nvim_lua = "[Lua]",
     --           latex_symbols = "[Lat]",
     --       },
     --   }),
    },

}

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })

  require ('config-luasnip')
  require ('config-open_win')
--
-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et

require'marks'.setup {
  -- whether to map keybinds or not. default true
  default_mappings = true,
  -- which builtin marks to show. default {}
  builtin_marks = { ".", "<", ">", "^" },
  -- whether movements cycle back to the beginning/end of buffer. default true
  cyclic = true,
  -- whether the shada file is updated after modifying uppercase marks. default false
  force_write_shada = false,
  -- how often (in ms) to redraw signs/recompute mark positions. 
  -- higher values will have better performance but may cause visual lag, 
  -- while lower values may cause performance penalties. default 150.
  refresh_interval = 250,
  -- sign priorities for each type of mark - builtin marks, uppercase marks, lowercase
  -- marks, and bookmarks.
  -- can be either a table with all/none of the keys, or a single number, in which case
  -- the priority applies to all marks.
  -- default 10.
  sign_priority = { lower=10, upper=15, builtin=8, bookmark=20 },
  -- disables mark tracking for specific filetypes. default {}
  excluded_filetypes = {},
  -- marks.nvim allows you to configure up to 10 bookmark groups, each with its own
  -- sign/virttext. Bookmarks can be used to group together positions and quickly move
  -- across multiple buffers. default sign is '!@#$%^&*()' (from 0 to 9), and
  -- default virt_text is "".
  bookmark_0 = {
    sign = "⚑",
    virt_text = "hello world"
  },
  mappings = {}
}

require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })

vim.cmd([[

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
xmap gt <Plug>(Tabularize)


""""""""""""""""""""""""""""""
" => vim-commentry
""""""""""""""""""""""""""""""
autocmd FileType sql setlocal commentstring=--\ %s
autocmd FileType autohotkey setlocal commentstring=;\ %s
nmap <leader>/ gcc
nmap <C-/> gcc
xnoremap <C-m> :norm gcc

" no auto comment on enter
autocmd BufNewFile,BufRead * setlocal formatoptions-=cro

""""""""""""""""""""""""""""""
" => floaterm
""""""""""""""""""""""""""""""
let g:floaterm_autoinsert = v:false
let g:floaterm_width = 0.8

nnoremap <leader>lg :FloatermNew! --title=lazygit lazygit<CR>

""""""""""""""""""""""""""""""
" => Target, Never seek backwards
""""""""""""""""""""""""""""""
" let g:targets_seekRanges = 'cc cr cb cB lc ac Ac lr rr lb ar ab lB Ar aB Ab AB rb rB bb bB BB'
let g:targets_jumpRanges = 'rr rb rB bb bB BB ll al Al aa Aa AA'

""""""""""""""""""""""""""""""
" => toggleterm
""""""""""""""""""""""""""""""
" By applying the mappings this way you can pass a count to your
" mapping to open a specific window.
" For example: 2<C-t> will open terminal 2
nnoremap <leader>te <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

""""""""""""""""""""""""""""""
" => My TabToggle Terminal
""""""""""""""""""""""""""""""
autocmd TermOpen * startinsert
autocmd BufWinEnter,WinEnter term://* startinsert

let g:tab_buf = [-1]
function! s:TabToggleTerminal() abort
  let current_tabpage = tabpagenr()
  let index = current_tabpage - 1
  " echom "current tabpage: " . current_tabpage
  " echom "current index: " . index
  if len(g:tab_buf) == current_tabpage
     " echom "tab_buf exists"
  else
     " echom "tab_buf does not exists"
     call  add(g:tab_buf, -1)
     " echom g:tab_buf
  endif

  if g:tab_buf[index] == -1
    execute "sp | wincmd j | resize 20 |  term "
    let g:tab_buf[index] = bufnr("$")
  else
    let visible = win_findbuf(g:tab_buf[index])
    " echom "visible: " . len(visible)
    if len(visible) > 0 
      call win_execute(visible[0], 'wincmd c')
      " echom visible[0]
    else
   "  echom "not visible"
      execute "sp | wincmd j | resize 20 | b" . g:tab_buf[index]
    endif
  endif
endfunction
    
" nnoremap <silent> <C-t> :call <SID>TabToggleTerminal()<CR>
" tnoremap <silent> <C-t> <C-\><C-n><C-w>p:call <SID>TabToggleTerminal()<CR>
" tnoremap <leader> tc <ESC><C-w>k:call <SID>TabToggleTerminal()<CR>
" 
" In the new setup somehow this terminal does not work anymore. Anyhow with
" Wezterm don't really need this too


let g:csv_no_conceal = 1

  " augroup myautocmds
  "   autocmd!
  "   au FileType vim nnoremap  <buffer> <leader><F5> :so%<CR>
  "   au FileType lua nnoremap  <buffer> <leader><F5> :luafile %<CR>
  " augroup END


""""""""""""""""""""""""""""""
" => asyncrun for sql
""""""""""""""""""""""""""""""
let g:asyncrun_open = 20
 if has('win32') || has('win64') || has('win95') || has('win16')
    nnoremap  <F3> :AsyncRun -program=wsl /mnt/d/test.sh %:p<CR>
    nnoremap  <F4> :FloatermNew --name=executeSql devops_scripts/execute_sql.sh %:p<CR>
    nnoremap  <F5> :AsyncRun -program=wsl /mnt/d/Development/devops_scripts/execute_sql.sh %:p<CR>
    nnoremap  <F6> :AsyncRun -program=wsl /mnt/d/Development/devops_scripts/install_sql.sh %:p<CR>
    nnoremap  <F7> :AsyncRun -program=wsl /mnt/d/Development/devops_scripts/copy_to_md.sh %:p<CR>
    nnoremap  <C-F9> :AsyncRun -program=wsl /mnt/d/Development/devops_scripts/drop_sql.sh %:p<CR>
 else
    nnoremap  <F3> :FloatermNew! --name=sql --title=sql --wintype=split --position=rightbelow devops_scripts/sqlcl.sh<CR>
    nnoremap  <F4> :AsyncRun  devops_scripts/execute_sqlcl.sh devops_scripts/50.SQL_scripts/get_dba_tab_cols.sql @0<CR>
    nnoremap  <S-F4> :exec ":AsyncRun -mode=term -pos=floaterm  devops_scripts/execute_sqlcl.sh devops_scripts/50.SQL_scripts/get_dba_tab_cols.sql" getreg("0")<CR>
    nnoremap  <F5> :AsyncRun devops_scripts/execute_sql.sh %:p<CR>
    nnoremap  <C-F5> :AsyncRun -mode=term -pos=floaterm devops_scripts/execute_sql.sh %:p<CR>
    nnoremap  <leader>f5 :AsyncRun -mode=term -pos=floaterm devops_scripts/execute_sql.sh %:p<CR>
    nnoremap  <M-F5> :call FloatingWindowLog('/tmp/execute.log')<CR>
    nnoremap  <F6> :AsyncRun devops_scripts/install_sql.sh %:p<CR>
    nnoremap  <C-F6> :AsyncRun -mode=term -pos=floaterm_reuse devops_scripts/install_sql.sh %:p<CR>
    nnoremap  <M-F6> :call FloatingWindowLog('/tmp/install.log')<CR>
    nnoremap  <F7> :AsyncRun devops_scripts/copy_to_md.sh %:p<CR>
    nnoremap  <F9> :FloatermToggle <CR>
    nnoremap  <C-F9> :AsyncRun devops_scripts/drop_sql.sh %:p<CR>
    nnoremap  <M-F9> :call FloatingWindowLog('/tmp/drop.log')<CR>
 endif

set errorformat+=ERROR\ %l/%c\ %f\ %m

nnoremap <Leader>el yiWi<element name="<ESC>$a"             value="<ESC>pa"><ESC>^j
nnoremap <Leader>lo i<tab>log('<C-r>0: ' \|\| <C-r>0, l_module);<ESC>^kj<ESC>

function PLSQLpa() range
  " Takes first word as a parameter and adds => and replaces the first character with l
  execute a:firstline . ',' . a:lastline . 'normal yiwA => pbrl'
  call Tabularize('/=>/')
endfunction 
command -range PLSQLpa :<line1>,<line2>call PLSQLpa()
command -range Tabp :<line1>,<line2>call Tabularize('/||/')
command -range Tabpa :<line1>,<line2>call Tabularize('/=>/')
command -range Tabpe :<line1>,<line2>call Tabularize('/:=/')

" nnoremap <Leader>fp /proc<CR>
" nnoremap <Leader>ff /func<CR>

autocmd BufEnter *.log :setlocal filetype=log
autocmd BufEnter .env.* :setlocal filetype=sh
""""""""""""""""""""""""""""""
" => Set .pkb, .pks to sql filetype
""""""""""""""""""""""""""""""
autocmd BufEnter *.pkb :setlocal filetype=sql
autocmd BufEnter *.pks :setlocal filetype=sql
autocmd BufEnter *.plb :setlocal filetype=sql
autocmd BufEnter *.pls :setlocal filetype=sql
autocmd BufEnter *.ldt :setlocal filetype=sql

map <F13>  <S-F1>
map <F14>  <S-F2>
map <F15>  <S-F3>
map <F16>  <S-F4>
map <F17>  <S-F5>
map <F18>  <S-F6>
map <F19>  <S-F7>
map <F20>  <S-F8>
map <F21>  <S-F9>
map <F22>  <S-F10>
map <F23>  <S-F11>
map <F24>  <S-F12>

map <F25>  <C-F1>
map <F26>  <C-F2>
map <F27>  <C-F3>
map <F28>  <C-F4>
map <F29>  <C-F5>
map <F30>  <C-F6>
map <F31>  <C-F7>
map <F32>  <C-F8>
map <F33>  <C-F9>
map <F34>  <C-F10>
map <F35>  <C-F11>
map <F36>  <C-F12>

map <F37>  <M-F1>
map <F38>  <M-F2>
map <F39>  <M-F3>
map <F40>  <M-F4>
map <F41>  <M-F5>
map <F42>  <M-F6>
map <F43>  <M-F7>
map <F44>  <M-F8>
map <F45>  <M-F9>
map <F46>  <M-F10>
map <F47>  <M-F11>
map <F48>  <M-F12>

map <C-S-F9> :echo F9
]])
