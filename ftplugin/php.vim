set expandtab tabstop=4 shiftwidth=4
nnoremap [p :!/usr/bin/php -l %

colorscheme elflord

if exists('phplint_loaded')
   finish
endif

let phplint_loaded = 1

function s:PhpLint()
    let b:cl='/usr/bin/php -l ' . shellescape(expand('%'))
    let b:result=system(b:cl)
    let b:results=split(b:result,"\n")
    let b:oldstatus=&statusline
    for b:i in b:results
        " unsilent echom b:i
        let &statusline=b:i
        redrawstatus
        sleep 1
    endfor
    let &statusline=b:oldstatus
endfunction

autocmd BufWritePost *.php PhpLint
command! PhpLint :silent call <SID>PhpLint()
