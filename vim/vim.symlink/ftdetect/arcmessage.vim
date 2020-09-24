augroup arc_message_file
  " Mark arc-message-file as a git commit message with some custom highlighting.
  autocmd BufRead,BufNewFile arc-message-file setfiletype gitcommit.arcmessage
augroup END
