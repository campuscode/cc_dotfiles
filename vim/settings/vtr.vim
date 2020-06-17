let is_tmux = $TMUX
if is_tmux != ""
  autocmd VimEnter * VtrAttachToPane
endif

if filereadable(expand("./bin/rspec"))
  let g:rspec_command = "VtrSendCommandToRunner! ./bin/rspec {spec}"
else
  let g:rspec_command = "VtrSendCommandToRunner! rspec {spec}"
endif
