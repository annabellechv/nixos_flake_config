{ pkgs, ... }:
{
  programs.neovim = {
    enable = true;
    vimAlias = true;

    extraConfig = ''    
      """"""""""""""""""""""""""""""""""""""
      " => Settings
      """"""""""""""""""""""""""""""""""""""
      set nocompatible
      set clipboard=unnamedplus
      set number relativenumber
      set encoding=UTF-8
      set autoindent
      set smartindent
      set mouse=a
      highlight OverLength ctermbg=red ctermfg=white guibg=#592929
      match OverLength /\%80v.\+/
      set showmatch
      set wildmode=longest,list   " get bash-like tab completions

          """"""""""""""""""""""""""""""""""""""
      " => File explorer   
      """"""""""""""""""""""""""""""""""""""
      :nnoremap <C-e> :NERDTree<CR>
      :nnoremap <C-p> :FZF<CR>

      """""""""""""""""""""""""""""""""""""""
      " => Theme
      """""""""""""""""""""""""""""""""""""""
      syntax on
      set t_Co=256
      set termguicolors
      "let ayucolor="dark"
      "colorscheme ayu
      set cursorline
      colorscheme tender
      let g:airline_theme='tender'

      "transparent background
      autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE

      """""""""""""""""""""""""""""""""""""""
      " => Statusbar
      """""""""""""""""""""""""""""""""""""""
      let g:airline_powerline_fonts = 1
      let g:airline#extensions#tabline#enabled = 1
      let g:airline#extensions#tabline#formatter = 'unique_tail'
      
      """""""""""""""""""""""""""""""""""""""
      " => Code sytling
      """""""""""""""""""""""""""""""""""""""
      set tabstop=4
      set shiftwidth=4
      set expandtab

      """""""""""""""""""""""""""""""""""""""
      " => Keymaps
      """""""""""""""""""""""""""""""""""""""
      " reload vim.rc
      nnoremap <Leader>vr :source $MYVIMRC<CR>	" reload

      " rainbow parentheses
      let g:rainbow_active = 1

      """
      " Auto reformat clang
      """
      autocmd FileType c ClangFormatAutoEnable
      let g:clang_format#auto_format = 1
      let g:clang_format#detect_style_file = 1
      let g:clang_format#enable_fallback_style = 0

      " if hidden is not set, TextEdit might fail.
      set hidden

      " Some servers have issues with backup files, see #649
      set nobackup
      set nowritebackup

      " Better display for messages
      set cmdheight=2

      " You will have bad experience for diagnostic messages when it's default 4000.
      set updatetime=300

      " don't give |ins-completion-menu| messages.
      set shortmess+=c

      " always show signcolumns
      set signcolumn=yes

      " Use tab for trigger completion with characters ahead and navigate.
      " Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
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

      " Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
      " Coc only does snippet and additional edit on confirm.
      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

      " Use `[c` and `]c` to navigate diagnostics
      nmap <silent> [c <Plug>(coc-diagnostic-prev)
      nmap <silent> ]c <Plug>(coc-diagnostic-next)

      " Remap keys for gotos
      nmap <silent> gd <Plug>(coc-definition)
      nmap <silent> gy <Plug>(coc-type-definition)
      nmap <silent> gi <Plug>(coc-implementation)
      nmap <silent> gr <Plug>(coc-references)

      " Use K to show documentation in preview window
      nnoremap <silent> K :call <SID>show_documentation()<CR>
      
      function! s:show_documentation()
        if (index(['vim','help'], &filetype) >= 0)
          execute 'h '.expand('<cword>')
        else
          call CocAction('doHover')
        endif
      endfunction

      " Highlight symbol under cursor on CursorHold
      autocmd CursorHold * silent call CocActionAsync('highlight')

      " Remap for rename current word
      nmap <leader>rn <Plug>(coc-rename)

      " Remap for format selected region
      xmap <leader>f  <Plug>(coc-format-selected)
      nmap <leader>f  <Plug>(coc-format-selected)

      augroup mygroup
        autocmd!
        " Setup formatexpr specified filetype(s).
        autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
        " Update signature help on jump placeholder
        autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
      augroup end

      " Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
      xmap <leader>a  <Plug>(coc-codeaction-selected)
      nmap <leader>a  <Plug>(coc-codeaction-selected)

      " Remap for do codeAction of current line
      nmap <leader>ac  <Plug>(coc-codeaction)
      " Fix autofix problem of current line
      nmap <leader>qf  <Plug>(coc-fix-current)

      " Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
      nmap <silent> <TAB> <Plug>(coc-range-select)
      xmap <silent> <TAB> <Plug>(coc-range-select)
      xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

      " Use `:Format` to format current buffer
      command! -nargs=0 Format :call CocAction('format')

      " Use `:Fold` to fold current buffer
      command! -nargs=? Fold :call     CocAction('fold', <f-args>)

      " use `:OR` for organize import of current buffer
      command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

      " Add status line support, for integration with other plugin, checkout `:h coc-status`
      set statusline^=%{coc#status()}%{get(b:,'coc_current_function','\')}

      " Using CocList
        " Show all diagnostics
        nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
        " Manage extensions
        nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
        " Show commands
        nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
        " Find symbol of current document
        nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
        " Search workspace symbols
        nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
        " Do default action for next item.
        nnoremap <silent> <space>j  :<C-u>CocNext<CR>
        " Do default action for previous item.
        nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
        " Resume latest coc list
        nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

        " Add GDB Debugger
        packadd termdebug

        " Gdb config
        let g:termdebug_wide=1

        " Map ESC to exit terminal mode
        tnoremap <Esc> <C-\><C-n>
        nnoremap <silent> <C-b> :Break<CR>
        nnoremap <silent> <C-c> :ClearCR>
        nnoremap <silent> <F5> :Continue<CR>

        " Tab Map
        noremap <A-1> 1gt
        noremap <A-2> 2gt
        noremap <A-3> 3gt
        noremap <A-4> 4gt
        noremap <A-5> 5gt
        noremap <A-6> 6gt
        noremap <A-7> 7gt
        noremap <A-8> 8gt
        noremap <A-9> 9gt
        noremap <A-t> :tabnew<CR>
        noremap <A-w> :tabclose<CR>
        noremap <A-h> :tabprevious<CR>
        noremap <A-l> :tabnext<CR>

    '';

    plugins = with pkgs.vimPlugins; [ 
      vim-polyglot
      vim-airline
      vim-airline-themes
      lightline-vim
      vim-devicons
      nerdtree
      fzf-vim
      coc-nvim
      coc-pairs
      coc-yaml
      rainbow
      DoxygenToolkit-vim
      vim-clang-format
      ayu-vim
      palenight-vim
      onehalf
      tender-vim
    ];
  };
}
