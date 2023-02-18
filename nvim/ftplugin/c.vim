
function! Compile()
	silent !gcc %:p -o %:p:r
	redraw!
endfunction

nnoremap <buffer> <localleader>c :call Compile()<LF>
nnoremap <buffer> <localleader>s :source ~/.config/nvim/ftplugin/c.vim <LF>
nnoremap <buffer> <localleader>e :!%:p:r<LF>
nnoremap <buffer> <localleader>r :!gcc %:p && ./a.out<LF>
