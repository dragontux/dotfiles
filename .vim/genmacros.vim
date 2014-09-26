" Some function definitions
" Search for the word under the cursor in duckduckgo
function! OnlineDoc( )
	let s:browser = "dwb"
	let s:cword = expand( "<cword>" )
	
	if &ft != "text"
		let s:url = "http://www.ddg.gg/html/?q=".&ft." ".s:cword
	else
		let s:url = "http://www.ddg.gg/html/?q=".s:cword
	endif

	let s:cmd = "silent !" . s:browser . " \"" . s:url . "\""
	execute s:cmd
	redraw!
endfunction
map <LocalLeader>k :call OnlineDoc()<CR>

" Hexidecimal editing
function ToggleHex()
	if !exists( "b:in_hex" )
		let b:in_hex = 0
	endif
	
	if !b:in_hex
		%!xxd
	else
		%!xxd -r
	endif

	let b:in_hex = !b:in_hex
endfunction
map <LocalLeader>h :call ToggleHex()<CR>

" Disassemble stuff
function Disassemble( )
	let s:temp = getline( 1 )

	if ( strlen( s:temp ) > 3 )
		if s:temp[1:3] == "ELF"
			%!objdump -d /dev/stdin
		else
			%!ndisasm -u -
		endif
	else
		echo "Have no data to disassemble."
	endif
endfunction
map <LocalLeader>d :call Disassemble()<CR>

" From vim's site
function! Smart_TabComplete()
	let line = getline( '.' )
	let substr = strpart( line, -1, col('.'))
	let substr = matchstr( substr, "[^ \t]*$" )
	if ( strlen( substr ) == 0 )
		return "\<tab>"
	endif

	let has_period = match( substr, '\.' ) != -1
	let has_slash = match( substr, '\/' ) != -1

	if ( has_slash )
		return "\<C-X>\<C-F>"
	else
		return "\<C-N>"
	endif
endfunction
" Map tab to word completion
inoremap <tab> <c-r>=Smart_TabComplete()<CR>
