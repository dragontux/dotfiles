function! JavaGetComplete( )
	let cline = getline( '.' )
	let type = matchstr( cline, "[a-zA-Z_]*", match( cline, "[a-zA-Z_]" ))
	let var = matchstr( cline, "[a-zA-Z_]*$" )

	if ( strlen( type ) == 0 || strlen( var ) == 0 )
		echo "Don't have a java completion here."
	endif

	let gvar = toupper( var[0] ) . var[1:]
	let javadoc = "/** Gets the ".var.".\r @return The ".var.".\r/\r"
	exe "normal S".javadoc."public ".type." get".gvar."( ){\rreturn this.".var.";\r}\r\<Esc>j"
endfunction

function! JavaSetComplete( )
	let cline = getline( '.' )
	let type = matchstr( cline, "[a-zA-Z_]*", match( cline, "[a-zA-Z_]" ))
	let var = matchstr( cline, "[a-zA-Z_]*$" )

	if ( strlen( type ) == 0 || strlen( var ) == 0 )
		echo "Don't have a java completion here."
		return
	endif

	let gvar = toupper( var[0] ) . var[1:]

	let javadoc = "/** Sets the ".var.".\r @param ".var." The new ".var.".\r/\r"
	let tophalf = "S".javadoc."public void set".gvar."( ".type." ".var." )"
	let bothalf = "{\rthis.".var." = ".var.";\r}\r\<Esc>j"
	let cmd = tophalf . bothalf
	exe "normal " . cmd
endfunction

map <LocalLeader>g :call JavaGetComplete()<CR>
map <LocalLeader>s :call JavaSetComplete()<CR>
