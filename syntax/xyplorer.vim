" Vim syntax file
" Language: XYplorer Scripting Language (*.xys)
" Maintainer: WirlyWirly
" Latest Revision: 15 December 2024
" Version: 0.1
" Installation: https://vim.fandom.com/wiki/Creating_your_own_syntax_files#Install_the_syntax_file

if exists("b:current_syntax")
  finish
endif
let main_syntax = 'xyplorer'

let s:cpo_save = &cpo
set cpo&vim

" =========== Keywords ===========
syn keyword xyBuiltin abs ageclasses aid air appicon asc assert get attrstamp automaxcolumn autosizecolumns function backupto base64decode base64encode beep box button buttonset catalogexecute catalogload catalogreport cea ceil ces charview chr colorfilter columnlayout compare conf confirm continue get gpc controlatpos controlposition copier copy copyas copydata copyitem copytext copyto count ctbicon ctbname ctbstate dark datediff datepicker dectohex delete dlog download echo editconf end eval exists exit explode extlist extracttext extratag favs filesequal filesize filetime filetype filter flattenfolder floor focus folderreport foldersize font format formatbytes formatdate formatlist fresh freshhere get getkey getpathcomponent gpc getsectionlist gettoken gettokenindex ghost global goto hash hashlist hex hexdump hextodec highlight hotkeyshowapp html htmlencode id3tag implode incr indexatpos input inputfile inputfolder inputselect interfacecolors ifc internetflags isset isunicode itematpos lax listfolder listpane llog load loadlayout loadsearch loadsettings loadtree logon makecoffee md5 moveas moveto msg new newwindow now obfuscate open openwith outputfile paperfolder pasteto patchimage pathreal pathspecial perm popupcontextmenu popupmainmenu popupmenu popupnativecontextmenu popupnested posatpos preview previewcheck preview64 property quickfileview quicksearch quote raf rand readfile readonly readonlyhere readpv readurl readurlutf8 recase refresh refreshlist regexmatches regexreplace releaseglobals rename renameitem replace replacelist report resolvepath return rotate round rtfm run runq runret savesettings savethumb searchtemplate sel selectitems selectthumbs self selfilter seltab set setcolumns seticons setkey setlayout setthumb setting settingp shellopen shellprops showhash showintree showstatus skipundo slog sortby sortbylist sound status statusbartemplate step strlen strpos strrepeat strreverse sub substr swapnames sync syncselect tab tabset tag tagcheck tagexport tagitems taglist tagload tagsave text thumbscacherename thumbsconf timestamp toolbar topindex trayballoon trim unset unstep update urldecode urlencode utf8decode utf8encode varname vartype view wait wipe writefile writepv zip_add zip_extract zip_list2 skipwhite
syn keyword xyConditional if elseif else Like LikeI UnLike UnLikeI and or true false break none
syn keyword xyRepeat while for foreach
" syn keyword xyComparison

" =========== Regex Matches ===========
syn match xyBrackets "[(){}\[\]]"
syn match xyCommandId "\#\d\+"
syn match xyCommentLine "/\{2}.*$" contains=@Spell
syn match xyCommentLine "^;.\+$" contains=@Spell
syn match xyConcatinate "\s*\.\s*"
syn match xyFunction "\w\+\ze("
syn match xyInteger "\d\+\.\?"
syn match xyOperator "\d\+\s*\zs/\ze\s*\d\+"
syn match xyOperator "[:!<>=+&\-*]\+"
syn match xyRegExpCapture "\$\d\+"
syn match xySeperatorOR "|\{2}"
syn match xySeperator "|\{1}"
syn match xyVariableCustom "\$\a\+"
syn match xyVariableNative "<\w\{-}>"
syn match xyVariableNative "%\w\{-}%"
syn match xyVariableNative "<\w\{-}\s.\{-}>" contains=xyVariableCustom
"
" =========== Regions ===========
syn region xyCommentBlock start="^/\*"  end="\*/" contains=@Spell
syn region xyStringLax start="lax("ms=e+1 end=")\|$"me=s-1 oneline contains=xyVariableNative,xyVariableCustom
syn region xyStringD start='"'  end='"\|$'	contains=xyVariableNative,xyVariableCustom,xyRegExpCapture
syn region xyStringS start="'"  end="'\|$"	contains=xyVariableNative,xyVariableCustom,xyRegExpCapture
syn region xyStringT start="`"  end="`\|$"	contains=xyVariableNative,xyVariableCustom,xyRegExpCapture


" =========== Highlighting ===========
hi def link xyBrackets Function
hi def link xyBuiltin Function
hi def link xyCommandId Label
hi def link xyCommentBlock Comment
hi def link xyCommentLine Comment
hi def link xyConcatinate Operator
hi def link xyConditional Conditional
hi def link xyFunction Function
hi def link xyFunctionArgs Function
hi def link xyInteger Number
hi def link xyOperator Operator
hi def link xyRegExpCapture Identifier
hi def link xyRepeat Repeat
hi def link xySeperatorOR Structure
hi def link xySeperator Comment
hi def link xyStringLax String
hi def link xyStringD String
hi def link xyStringS String
hi def link xyStringT String
hi def link xyVariableCustom NONE
hi def link xyVariableNative Identifier

let b:current_syntax = "xyplorer"
let &cpo = s:cpo_save
unlet s:cpo_save
