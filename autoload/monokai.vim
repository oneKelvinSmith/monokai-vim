function! monokai#invert_signs_toggle()
  if g:monokai_invert_signs == 0
    let g:monokai_invert_signs=1
  else
    let g:monokai_invert_signs=0
  endif

  colorscheme monokai
endfunction

" Search Highlighting {{{

function! monokai#hls_show()
  set hlsearch
  call MonokaiHlsShowCursor()
endfunction

function! monokai#hls_hide()
  set nohlsearch
  call MonokaiHlsHideCursor()
endfunction

function! monokai#hls_toggle()
  if &hlsearch
    call monokai#hls_hide()
  else
    call monokai#hls_show()
  endif
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
