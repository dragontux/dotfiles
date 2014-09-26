inoremap <LocalLeader>in #include 
inoremap <LocalLeader>df #define 
inoremap <LocalLeader>sz sizeof( 
inoremap <LocalLeader>db double 
inoremap <LocalLeader>sr struct 
inoremap <LocalLeader>un unsigned 
inoremap <LocalLeader>wh while( 
inoremap <LocalLeader>lg long 
inoremap <LocalLeader>oo <esc>o

function! CTypeDef( )
	let cline = getline( '.' )
	let pos = getpos( '.' )

	let type = matchstr( cline, "[a-zA-Z_]*", match( cline, "[a-zA-Z_]" ))

	let cmdstr = "Stypedef struct ".type." {\r"
	let cmdstr = cmdstr."\r} ".type."_t;"
	exe "normal " . cmdstr

	" Set the line position to one down
	let pos[1] = pos[1] + 1
	call setpos( '.', pos )

	return "\<tab>"
endfunction
inoremap <LocalLeader>td <c-r>=CTypeDef()<CR>

function! CFuncDef( )
	let cline = getline( '.' )
	let pos = getpos( '.' )

	let type = matchstr( cline, "[a-zA-Z_]* [*]*", match( cline, "[a-zA-Z_]" ))
	let fname = matchstr( cline, "[a-zA-Z_]*$" )

	let cmdstr = "S".type.fname."(){\r"

	if type != "void " 
		let cmdstr = cmdstr.type."ret;\r"
		let cmdstr = cmdstr."return ret;\r"
	endif
	let cmdstr = cmdstr."} "
	exe "normal " . cmdstr

	let pos[2] = strlen(type) + strlen(fname) + 2
	call setpos( '.', pos )

	return " "
endfunction
inoremap <LocalLeader>fn <c-r>=CFuncDef()<CR>

function! CIfDef( )
	let cline = getline( '.' )
	let pos = getpos( '.' )

	let expr = matchstr( cline, "[a-zA-Z_].*$" )

	let cmdstr = "Sif ( ".expr." ){\r\r}"
	exe "normal " . cmdstr

	let pos[1] = pos[1] + 1
	call setpos( '.', pos )

	return "\<tab>"
endfunction
inoremap <LocalLeader>if <c-r>=CIfDef()<CR>

function! ReadManPage( )
	let s:cword = expand( "<cword>" )
	if &ft == "c" || &ft == "cpp"
		exe "silent !man 3 " . s:cword
	endif

	redraw!
endfunction
map <LocalLeader>m :call ReadManPage()<CR>

