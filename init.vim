lua require "init"

syntax enable

" 设置主题
" colorscheme default

" 指定复制，粘贴软件位置
let g:clipboard = {
\ 'name': 'win32yank',
\ 'copy': {
\ '+': 'win32yank.exe -i --crlf',
\ '*': 'win32yank.exe -i --crlf',
\ },
\ 'paste': {
\ '+': 'win32yank.exe -o --lf',
\ '*': 'win32yank.exe -o --lf',
\ },
\ 'cache_enabled': 0,
\ }


" 指定python位置
let g:python_host_skip_check=1
let g:python_host_prog = python_path
let g:python3_host_skip_check=1
let g:python3_host_prog = python_path

" cpp语法高亮
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1
let g:cpp_experimental_template_highlight = 1
let g:cpp_concepts_highlight = 1
" 关闭popupmenu和tabline
" 不然bufferline和coc补全菜单会很丑
set winaltkeys=no
if has('nvim')
    try
        call rpcnotify(1, 'Gui', 'Option', 'Tabline', 0)
        call rpcnotify(1, 'Gui', 'Option', 'Popupmenu', 0)
    catch
    endtry
endif
" 分割线设置
    let g:indent_blankline_char = '¦'
    let g:indent_blankline_show_first_indent_level = v:false

" 设置头文件，main函数
    func SetCPPTitle()
        call setline(1, "#include <bits/stdc++.h>")
        call append(line("."), "")
        call append(line(".")+1, "using namespace std;")
        call append(line(".")+2, "")
        call append(line(".")+3, "int main() {")
        call append(line(".")+4, "")
        call append(line(".")+5, "    return 0;")
        call append(line(".")+6, "}")
    endfunc 
    func SetTitle()
        if &filetype == 'cpp'
            exec ":call SetCPPTitle()"
            exec ":$"
        endif
    endfunc
    nmap<leader>st :call SetTitle()<CR>

" 光标保持在上次退出原处
au BufReadPost * if line("'\"") > 0 | if line("'\"") <= line("$") | exe("norm '\"") | else |exe "norm $"| endif | endif

" rainbow设置
    let g:rainbow_active = 1 "set to 0 if you want to enable it later via :RainbowToggle

" asynctasks, asyncrun
    " 自动打开 quickfix window ，高度为 6
    let g:asyncrun_open = 6
    " 任务结束时候响铃提醒
    let g:asyncrun_bell = 1 
    let g:asynctasks_term_pos = 'external'

