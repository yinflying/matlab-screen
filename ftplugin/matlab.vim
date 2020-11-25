function matlab#Start()
    if !exists('g:matlab_screen_terminal_height')
        let g:matlab_screen_terminal_height = 10
    endif
    if exists('s:matlab_buf')
        echom "Only one MATLAB process in current vim!"
        return
    endif
    if exists('g:matlab_screen_vertical_terminal') && g:matlab_screen_vertical_terminal ==  1
        rightbelow let s:matlab_buf =
        \term_start(g:matlab_term_cmd,
        \{"term_finish" : "close", "vertical" : 1, "norestore" : 1 })
    else
       rightbelow let s:matlab_buf =
       \term_start(g:matlab_term_cmd,
       \{"term_finish" : "close", "term_rows": g:matlab_screen_terminal_height, "norestore" : 1 })
    endif
    wincmd p
endfunction

function! matlab#Close()
    call term_sendkeys(s:matlab_buf,"\nexit\n")
    unlet s:matlab_buf
endfunction

function! matlab#Toggle()
    if exists('s:matlab_buf')
        call matlab#Close()
    else
        call matlab#Start()
    endif
endfunction

augroup termIgnore
    autocmd!
    autocmd TerminalOpen * set nobuflisted
augroup END

function! s:matlab_log(message, file)
    execute 'redir >>' . a:file
    silent echo a:message
    silent! redir END
endfunction

function! matlab#RunSelected() range
    execute "'<,'> write! ".expand('%:p:h')."/matlab_tmp.m"
    call s:matlab_log('delete matlab_tmp.m',expand('%:p:h')."/matlab_tmp.m")
    call term_sendkeys(s:matlab_buf,"cd ".expand('%:p:h').";matlab_tmp\n")
endfunction

function! matlab#RunCurrentFile()
    call term_sendkeys(s:matlab_buf,"cd ".expand('%:p:h').";".
                \strpart(expand('%:t'),0,len(expand('%:t'))-2)."\n")
endfunction

function! matlab#RunCell()
    execute '?%%\|\%^?;/%%\|\%$/w!'.expand('%:p:h')."/matlab_tmp.m"
    execute 'nohl'
    call s:matlab_log('delete matlab_tmp.m',expand('%:p:h')."/matlab_tmp.m")
    call term_sendkeys(s:matlab_buf,"cd ".expand('%:p:h').";matlab_tmp\n")
endfunction

function! matlab#GetDoc()
    call term_sendkeys(s:matlab_buf,"doc ".expand("<cword>")."\n")
endfunction

function! matlab#SetBreak()
    call term_sendkeys(s:matlab_buf, "dbstop in ".expand('%:p'." at ".line(".")."\n"))
endfunction

function! matlab#WatchVarible()
    let var_name = substitute(getline('.'),'^.*[a-zA-Z0-9._]\@<!\(\S*\%'.col('.').'c\k*\).*$','\1', '')
    call term_sendkeys(s:matlab_buf, "openvar ".var_name."\n")
endfunction

function! matlab#OpenCurrentFile()
    call term_sendkeys(s:matlab_buf, "edit ".expand('%:p')."\n")
endfunction

function! matlab#OpenAllFile()
    let currentBuffer = 1
    let allFileStr = ''
    while currentBuffer <= bufnr('$')
        if bufexists(currentBuffer)
            if expand('#'.string(currentBuffer).':e') != 'm'
                let currentBuffer = currentBuffer + 1
                continue
            endif
            let allFileStr = allFileStr .' '. expand('#'.string(currentBuffer).':p')
        endif
        let currentBuffer = currentBuffer + 1
    endwhile
    call term_sendkeys(s:matlab_buf, "edit ".allFileStr."\n")
endfunction

function! matlab#OpenWorkspace()
    call term_sendkeys(s:matlab_buf, "workspace\n")
endfunction

function! matlab#ClearVariables()
    call term_sendkeys(s:matlab_buf, "clear\n")
endfunction

function! matlab#GetVariableSize()
    call term_sendkeys(s:matlab_buf, "size(" . expand("<cword>") . ")\n")
endfunction

function! matlab#HighlightCell()
    if exists('g:matlab_screen_highlight_cell') && g:matlab_screen_highlight_cell == 1
        syn region DiffChange start="%%" end="$"
    endif
endfunction
au vimEnter * call matlab#HighlightCell()

" Shortcut
if !exists('g:matlab_screen_default_mapping') || g:matlab_screen_default_mapping == 1
    vnoremap <Leader>mr  :call matlab#RunSelected()<CR>
    nnoremap <Leader>mr  :call matlab#RunCell()<CR>
    nnoremap <Leader>mR  :call matlab#RunCurrentFile()<CR>
    nnoremap <Leader>md  :call matlab#GetDoc()<CR>
    nnoremap <Leader>mb  :call matlab#SetBreak()<CR>
    nnoremap <Leader>mv  :call matlab#WatchVarible()<CR>
    nnoremap <Leader>mf  :call matlab#OpenCurrentFile()<CR>
    nnoremap <Leader>maf :call matlab#OpenAllFile()<CR>
    nnoremap <Leader>mw  :call matlab#OpenWorkspace()<CR>
    nnoremap <Leader>mc  :call matlab#ClearVariables()<CR>
    nnoremap <Leader>ms  :call matlab#GetVariableSize()<CR>
    nnoremap <Leader>mt  :call matlab#Toggle()<CR>
endif
