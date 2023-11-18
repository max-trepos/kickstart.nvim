function! CreateCenteredFloatingWindow() abort
    " Define the size of the floating window
    let width = 50
    let height = 10
    let width = min([&columns - 4, max([80, &columns - 20])]) 
    let height = min([&lines - 4, max([20, &lines - 10])])

    " Create the scratch buffer displayed in the floating window
    let buf = nvim_create_buf(v:false, v:true)

    " let top = "╭" . repeat("─", width - 4) . "╮"
    " let mid = "│" . repeat(" ", width - 4) . "│"
    " let bot = "╰" . repeat("─", width - 4) . "╯"
    " let lines = [top] + repeat([mid], height - 4) + [bot]

    " let horizontal_border = '+' . repeat('-', width - 2) . '+'
    " let empty_line = '|' . repeat(' ', width - 2) . '|'
    " let lines = flatten([horizontal_border, map(range(height-2), 'empty_line'), horizontal_border])

    " call nvim_buf_set_lines(buf, 0, -1, v:true, lines)
    " Get the current UI
    let ui = nvim_list_uis()[0]

    " Create the floating window
    let opts = {'relative': 'editor',
                \ 'width': width,
                \ 'height': height,
                \ 'col': (ui.width/2) - (width/2),
                \ 'row': (ui.height/2) - (height/2),
                \ 'anchor': 'NW',
                \ 'style': 'minimal',
                \ }
    let win = nvim_open_win(buf, 1, opts)
      " Set mappings in the buffer to close the window easily
    let closingKeys = ['<Esc>', '<CR>', '<Leader>', 'F9']
    for closingKey in closingKeys
        call nvim_buf_set_keymap(buf, 'n', closingKey, ':close<CR>', {'silent': v:true, 'nowait': v:true, 'noremap': v:true})
    endfor

    return buf

endfunction

function! FloatingWindowLog(filePath) abort
    let l:buf = CreateCenteredFloatingWindow()
    call nvim_set_current_buf(l:buf)
    setlocal filetype=log
    " setlocal buftype=log
    execute "read " . fnameescape(a:filePath)
endfunction


