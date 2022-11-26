function! CreateCenteredFloatingWindow(title) abort
    let width = min([&columns - 4, max([80, &columns - 20])])
    let height = min([&lines - 4, max([20, &lines - 10])])
    let top = ((&lines - height) / 2) - 1
    let left = (&columns - width) / 2
    let opts = {
      \ 'relative': 'editor',
      \ 'row': top,
      \ 'col': left,
      \ 'width': width,
      \ 'height': height,
      \ 'focusable': v:true,
      \ 'border': 'rounded'
    \ }
    let border_bufnr = nvim_create_buf(v:false, v:true)
    call nvim_open_win(border_bufnr, v:true, opts)
    set winhl=Normal:Floating
    return border_bufnr
endfunction

function! FloatingWindowEdit(query) abort
    let l:buf = CreateCenteredFloatingWindow(a:query)
    " call nvim_set_current_buf(l:buf)
    execute 'edit ' . a:query
endfunction

command! -complete=file -nargs=? Fe call FloatingWindowEdit(<q-args>)
