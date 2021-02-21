" Thing that is added because it is

if !exists('g:vscode')
	set nocompatible
	
	" Plugin Config
	" =======================================================================================
	call plug#begin()
	
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	
	Plug 'jsit/disco.vim'
	
	" Useful plugins that I am not currently using
	"
	"Plug 'itchyny/lightline.vim'
	"
	"Plug 'airblade/vim-gitgutter'
	"
	"Plug 'SirVer/ultisnips'
	"let g:UltiSnipsExpandTrigger = '<tab>'
	"let g:UltiSnipsJumpForwardTrigger = '<tab>'
	"let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
	"
	"Plug 'dylanaraps/wal.vim'
	"
	"
	"Plug 'lervag/vimtex'
	"let g:tex_flavor='latex'
	"let g:vimtex_quickfix_mode=0
	"set conceallevel=1
	"let g:tex_conceal='abdmg'
	
	call plug#end()
	" =======================================================================================
	
	" Personal Config
	" =======================================================================================
	"
	
	" For desktops other than Gnome
	"if $DESKTOP_SESSION == 'gnome'
	colorscheme disco
	highlight SignColumn guibg=none ctermbg=none
	"else
	"        " Use Zathura for vimtex
	"        let g:vimtex_view_method='zathura'
	     
	"        " Set colour scheme
	"        "let g:lightline = {'colorscheme': 'wal'}
	"        colorscheme wal
	"endif
	
	" Split better
	set splitbelow
	set splitright
	
	" Show line numbers in text
	set number
	"autocmd TermOpen * setlocal nonumber
	
	" Search into subfolders
	set path+=**
	
	" Display all matching files when tab completing
	set wildmenu
	
	setlocal spell
	set spelllang=en_ca
	inoremap <C-l> <c-g>u<Esc>[s1z=`]a<c-g>u
	hi clear SpellBad
	hi SpellBad cterm=underline
	hi SpellBad ctermfg=red
	hi SpellBad gui=undercurl
	" =======================================================================================
	
	" NetRW config
	" =======================================================================================
	" Make NetRW look fancy
	let g:netrw_banner = 0
	let g:netrw_liststyle = 3
	let g:netrw_browse_split = 4
	let g:netrw_altv = 1
	let g:netrw_winsize = 25
	"augroup ProjectDrawer
	"  autocmd!
	"  autocmd VimEnter * :Vexplore
	"augroup END
	
	" Ignore default clipboard to fix flickering in netrw
	let g:clipboard = {
	          \   'name': 'myClipboard',
	          \   'copy': {
	          \      '+': 'wl-copy -',
	          \      '*': 'wl-copy -p -',
	          \    },
	          \   'paste': {
	          \      '+': 'wl-paste -',
	          \      '*': 'wl-paste -p -',
	          \   },
	          \   'cache_enabled': 1,
	          \ }
	" =======================================================================================
	
	" LSP Config
	" TextEdit might fail if hidden is not set.
	" =======================================================================================
	set hidden
	
	" Some servers have issues with backup files, see #649.
	set nobackup
	set nowritebackup
	
	" Give more space for displaying messages.
	set cmdheight=2
	
	" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
	" delays and poor user experience.
	set updatetime=300
	
	" Don't pass messages to |ins-completion-menu|.
	set shortmess+=c
	
	" Always show the signcolumn, otherwise it would shift the text each time
	" diagnostics appear/become resolved.
	set signcolumn=yes
	
	" Use tab for trigger completion with characters ahead and navigate.
	" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
	" other plugin before putting this into your config.
	inoremap <silent><expr> <TAB>
	      \ pumvisible() ? "\<C-n>" :
	      \ <SID>check_back_space() ? "\<TAB>" :
	      \ coc#refresh()
	inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
	
	function! s:check_back_space() abort
	  let col = col('.') - 1
	  return !col || getline('.')[col - 1]  =~# '\s'
	endfunction
	
	" Use <c-space> to trigger completion.
	inoremap <silent><expr> <c-space> coc#refresh()
	
	" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
	" position. Coc only does snippet and additional edit on confirm.
	if has('patch8.1.1068')
	  " Use `complete_info` if your (Neo)Vim version supports it.
	  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
	else
	  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
	endif
	
	" Use `[g` and `]g` to navigate diagnostics
	nmap <silent> [g <Plug>(coc-diagnostic-prev)
	nmap <silent> ]g <Plug>(coc-diagnostic-next)
	
	" GoTo code navigation.
	nmap <silent> gd <Plug>(coc-definition)
	nmap <silent> gy <Plug>(coc-type-definition)
	nmap <silent> gi <Plug>(coc-implementation)
	nmap <silent> gr <Plug>(coc-references)
	
	" Use K to show documentation in preview window.
	nnoremap <silent> K :call <SID>show_documentation()<CR>
	
	function! s:show_documentation()
	  if (index(['vim','help'], &filetype) >= 0)
	    execute 'h '.expand('<cword>')
	  else
	    call CocAction('doHover')
	  endif
	endfunction
	
	" Highlight the symbol and its references when holding the cursor.
	autocmd CursorHold * silent call CocActionAsync('highlight')
	
	" Symbol renaming.
	nmap <leader>rn <Plug>(coc-rename)
	
	" Formatting selected code.
	xmap <leader>f  <Plug>(coc-format-selected)
	nmap <leader>f  <Plug>(coc-format-selected)
	
	augroup mygroup
	  autocmd!
	  " Setup formatexpr specified filetype(s).
	  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
	  " Update signature help on jump placeholder.
	  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
	augroup end
	
	" Applying codeAction to the selected region.
	" Example: `<leader>aap` for current paragraph
	xmap <leader>a  <Plug>(coc-codeaction-selected)
	nmap <leader>a  <Plug>(coc-codeaction-selected)
	
	" Remap keys for applying codeAction to the current line.
	nmap <leader>ac  <Plug>(coc-codeaction)
	" Apply AutoFix to problem on the current line.
	nmap <leader>qf  <Plug>(coc-fix-current)
	
	" Introduce function text object
	" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
	xmap if <Plug>(coc-funcobj-i)
	xmap af <Plug>(coc-funcobj-a)
	omap if <Plug>(coc-funcobj-i)
	omap af <Plug>(coc-funcobj-a)
	
	" Use <TAB> for selections ranges.
	" NOTE: Requires 'textDocument/selectionRange' support from the language server.
	" coc-tsserver, coc-python are the examples of servers that support it.
	nmap <silent> <TAB> <Plug>(coc-range-select)
	xmap <silent> <TAB> <Plug>(coc-range-select)
	
	" Add `:Format` command to format current buffer.
	command! -nargs=0 Format :call CocAction('format')
	
	" Add `:Fold` command to fold current buffer.
	command! -nargs=? Fold :call     CocAction('fold', <f-args>)
	
	" Add `:OR` command for organize imports of the current buffer.
	command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
	
	" Add (Neo)Vim's native statusline support.
	" NOTE: Please see `:h coc-status` for integrations with external plugins that
	" provide custom statusline: lightline.vim, vim-airline.
	set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
	
	" Mappings using CoCList:
	" Show all diagnostics.
	nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
	" Manage extensions.
	nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
	" Show commands.
	nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
	" Find symbol of current document.
	nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
	" Search workspace symbols.
	nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
	" Do default action for next item.
	nnoremap <silent> <space>j  :<C-u>CocNext<CR>
	" Do default action for previous item.
	nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
	" Resume latest coc list.
	nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
	" =======================================================================================
endif
