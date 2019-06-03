let g:psql_pane_idx = 2

" TODO: доделать выозможность выбирать панель в которой нужно выполнить
" запрос, если панелей с psql-ем много (pstree, confirm)
" function! GetPSQLPane()
"   let panes = system("tmux list-panes -F '#{pane_active} #{pane_pid}'")
"   let i = 0
"   for v in split(panes)
"     if i % 2 == 1
"       echo v
"     endif
"     i=i+1
"   endfor
" endfunction

function! SendSelectionToPSQLTmuxPane()
  execute '!tmux send-keys -R -t ' . g:psql_pane_idx . ' q'
  execute '!tmux send-keys -R -t ' . g:psql_pane_idx . ' q'
  execute '!tmux send-keys -R -t ' . g:psql_pane_idx . ' C-c'
  execute '!tmux paste-buffer -t ' . g:psql_pane_idx
  execute '!tmux send-keys -t ' . g:psql_pane_idx . ' Enter'
endfunction


