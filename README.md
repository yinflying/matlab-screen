# matlab-screen
vim matlab plugin pass specified commands through gnu screen

The branch is for vim8 User, Mose smoothly and more powerful with matlab DEBUG!

** Under DevelopMent **

# Plugin Description
Suitable for:

    1. who uses LINUX(not sure about MAC)
    2. who uses vim8
    3. who uses matlab

The plugin will help you complete following functions:

    ** DEBUG function Support! **
    1. execute the matlab code you selected in vim
    2. execute the matlab script of vim's current buffer
    3. open vim buffer's file in matlab editor and begin to debug
    4. consult the function name under current cursor in matlab doc
    5. show the variable under current cursor in matlab variables editor
    6. pass a set of command from vim to matlab directly(e.g. clear,workspace)

# INSTALL
As with all other vim plugin.

However you should install another software `screen`, it could be found in all official repositories, just search and install it.

# Usage
1. Open matlab in screen which session names `matlab` without desktop under terminal:
```bash
$ screen -S matlab -m sh -c "<MATLAB>/bin/glnxa64/MATLAB -nosplash -nodesktop"
```
`<MATLAB>/bin/glnxa64/MATLAB` is the full path of the matlab executable binary file, just replace it with your matlab location.

Note: In order to be more convenient, you could make a alias in your ~/.bashrc or ~/.zshrc,such as:
```bash
alias smatlab='screen -S matlab -m sh -c "<MATLAB/bin/glnxa64/MATLAB -nosplash -nodesktop"'
```
2. Open a matlab script file (*.m), and then type following shortcut:
    1. `<Leader>mr`           : (matlab run           ) execute current matlab script
    2. `Shift+v jj<Leader>mr` : (matlab run           ) execute current selected line
    3. `<Leader>md`           : (matlab doc           ) consult the function name under current cursor
    5. `<Leader>mv`           : (matlab variable      ) show variable under current cursor
    6. `<Leader>mf`           : (matlab open file     ) open current buffer's file in matlab editor
    7. `<Leader>maf`          : (matlab open all file ) open all buffers' file in matlab editor
    8. `<Leader>mw`           : (matlab workspace     ) open matlab workspace
    9. `<Leader>mc`           : (matlab clear         ) clear matlab all variables
    10. `<Leader>ms`          : (matlab size          ) show variable size under current cursor

3. Debug Default ShortCut(See Default KeyMaps)

NOTE 1: `<Leader>` key can be set in `.vimrc` such as:
```vimscript
let mapleader=";"
```
NOTE 2: Don't use `matlab_tmp.m` as your matlab script name.

NOTE 3: It is easy to add more shortcut

# Default KeyMaps
Here are the all Default KeyMaps:
```
vnoremap <Leader>mr  :call matlab#runSeleted()<CR>
nnoremap <Leader>mr  :call matlab#runCurrentFile()<CR>
nnoremap <Leader>md  :call matlab#getDoc()<CR>
nnoremap <Leader>mv  :call matlab#openVariable()<CR>
nnoremap <Leader>mV  :call matlab#dispVariable()<CR>
nnoremap <Leader>mf  :call matlab#openCurrentFile()<CR>
nnoremap <Leader>maf :call matlab#openAllFiles()<CR>
nnoremap <Leader>mw  :call matlab#openWorkspace()<CR>
nnoremap <Leader>mc  :call matlab#clearAllVaribles()<CR>
nnoremap <Leader>ms  :call matlab#getVaribleSize()<CR>
nnoremap <Leader>mu  :call matlab#update()<CR>

nnoremap <Leader>mb  :call matlab#debug_setBreak()<CR>
nnoremap <Leader>mB  :call matlab#debug_clearAllBreaks()<CR>
nnoremap <F5>  :call matlab#debug_continue()<CR>
nnoremap <F9>  :call matlab#debug_step()<CR>
nnoremap <F7>  :call matlab#debug_stepIn()<CR>
nnoremap <F8>  :call matlab#debug_stepOut()<CR>
nnoremap <F10> :call matlab#debug_quit()<CR>
```
# THANKS
Inspired by [daeyun/vim-matlab](https://github.com/daeyun/vim-matlab) and vscode matlab plugin
