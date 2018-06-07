function! RunMatlabSelected() range
    execute "'<,'> write! ".expand('%:p:h')."/matlab_tmp.m"
    let matlabcmd = 'cd '.expand('%:p:h').';matlab_tmp^M'
    let precmd = "silent !echo delete\\\(\\\'matlab_tmp.m\\\'\\\)\\\;>> "
                \.expand('%:p:h')."/matlab_tmp.m && screen -S matlab -X stuff "
    execute precmd."'".matlabcmd."'"
    redraw!
endfunction
function! RunMatlabCurrentFile()
    let matlabcmd = 'cd '.expand('%:p:h').';'.
                \strpart(expand('%:t'),0,len(expand('%:t'))-2).'^M'
    let precmd = 'silent !screen -S matlab -X stuff '
    execute precmd."'".matlabcmd."'"
    redraw!
endfunction
function! GetMatlabDoc()
    execute "silent !screen -S matlab -X stuff 'doc ".expand("<cword>")."^M'"
    redraw!
endfunction
function! SetMatlabBreak()
    execute "silent !screen -S matlab -X stuff 'dbstop in ".expand('%:p')." at ".line(".")."^M'"
    redraw!
endfunction
function! WatchMatlabVarible()
    let var_name = substitute(getline('.'),'^.*[a-zA-Z0-9._]\@<!\(\S*\%'.col('.').'c\k*\).*$','\1', '')
    execute "silent !screen -S matlab -X stuff 'openvar ".var_name."^M'"
    redraw!
endfunction
function! OpenMatlabCurrentFile()
    execute "silent !screen -S matlab -X stuff 'edit ".expand('%:p')."^M'"
    redraw!
endfunction
function! OpenMatlabAllFile()
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
    execute "silent !screen -S matlab -X stuff 'edit ".allFileStr."^M'"
    redraw!
endfunction
function! OpenMatlabWorkspace()
    execute "silent !screen -S matlab -X stuff 'workspace^M'"
    redraw!
endfunction
function! ClearMatlabVariables()
    execute "silent !screen -S matlab -X stuff 'clear^M'"
    redraw!
endfunction
function! GetMatlabVariableSize()
    execute "silent !screen -S matlab -X stuff 'size(".expand("<cword>").")^M'"
    redraw!
endfunction

vnoremap <Leader>mr  :call RunMatlabSelected()<CR>
nnoremap <Leader>mr  :call RunMatlabCurrentFile()<CR>
nnoremap <Leader>md  :call GetMatlabDoc()<CR>
nnoremap <Leader>mb  :call SetMatlabBreak()<CR>
nnoremap <Leader>mv  :call WatchMatlabVarible()<CR>
nnoremap <Leader>mf  :call OpenMatlabCurrentFile()<CR>
nnoremap <Leader>maf :call OpenMatlabAllFile()<CR>
nnoremap <Leader>mw  :call OpenMatlabWorkspace()<CR>
nnoremap <Leader>mc  :call ClearMatlabVariables()<CR>
nnoremap <Leader>ms  :call GetMatlabVariableSize()<CR>
