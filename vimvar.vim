
" to ensure all names are proper for the file system
" replace all non-alphanumerics with a round hashed
" alphanumeric using the char value
" formula: 'A' + match % ('z' - 'A')
let s:pat = '[^A-Z0-9]'
let s:sub = '\=s:Lambda(submatch(0))'

let s:base = $HOME . "/.vimvar/"

function! s:Lambda ( char )
  let l:n = char2nr(a:char) % 52
  return nr2char((l:n < 26 ? 65 : 71) + l:n)
endfunction

function! s:GetFileName ( name )
  return s:base . substitute(a:name, s:pat, s:sub, "gi") . ".v"
endfunction

" VarSave("cached_variable_reference", { key: "value" })
function! VarSave ( name, data )
  call writefile([string(a:data)], s:GetFileName(a:name))
endfunction

" let saved_var = VarRead("cached_variable_reference")
function! VarRead ( name )
  execute "let l:result = " . readfile(s:GetFileName(a:name))[0]
  return l:result
endfunction

" ensure storage directory exists
if !isdirectory(glob(s:base))
  execute 'silent !mkdir -p ' . s:base
endif

