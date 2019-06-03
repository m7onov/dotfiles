function! JsonPretty()
  %!python -m json.tool
endfunction

function! JsonUnescape()
  %s/\\u\(\x\{4\}\)/\=nr2char('0x'.submatch(1),1)/g
endfunction

