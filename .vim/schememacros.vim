function! MacroExpand( word, endpos, vpos )
	let pos = getpos( '.' )

	let cmdstr = "i" . a:word
	exe "normal " . cmdstr

	let pos[2] = pos[2] + a:endpos
	let pos[1] = pos[1] + a:vpos
	call setpos( '.', pos )

	return ""
endfunction

inoremap <LocalLeader>df <c-r>=MacroExpand( "(define )", 8, 0 )<CR>
inoremap <LocalLeader>lm <c-r>=MacroExpand( "(lambda ())", 9, 0 )<CR>
inoremap <LocalLeader>ds <c-r>=MacroExpand( "(define-syntax )", 15, 0 )<CR>
inoremap <LocalLeader>sr <c-r>=MacroExpand( "(syntax-rules ()\r)", 15, 0 )<CR>
imap d-s <LocalLeader>ds
imap lmb <LocalLeader>lm
