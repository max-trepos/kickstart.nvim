let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
let Illuminate_highlightPriority =  -1 
let Illuminate_highlightUnderCursor =  1 
let Illuminate_delay =  0 
silent only
silent tabonly
cd /mnt/d/Development
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
set shortmess=aoO
badd +1 /mnt/d/Dropbox/Apps/Alacritty/alacritty.yaml
badd +702 /mnt/d/Dropbox/Apps/MobaXterm_root/nvim/init.vim
badd +41 /mnt/d/Dropbox/Apps/MobaXterm_root/nvim/lua/config-luasnip.lua
badd +1 /mnt/d/Dropbox/Apps/MobaXterm_root/nvim/snippets/sql.lua
argglobal
%argdel
edit /mnt/d/Dropbox/Apps/MobaXterm_root/nvim/snippets/sql.lua
argglobal
balt /mnt/d/Dropbox/Apps/MobaXterm_root/nvim/init.vim
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 26) / 53)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
if exists(':tcd') == 2 | tcd /mnt/d/Dropbox/Apps/MobaXterm_root/nvim | endif
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :