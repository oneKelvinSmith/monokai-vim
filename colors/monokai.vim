" Supporting code -------------------------------------------------------------
" Initialisation: {{{

if version > 580
  hi clear
  if exists("syntax_on")
    syntax reset
  endif
endif

let g:colors_name='monokai'

if !(has('termguicolors') && &termguicolors) && !has('gui_running') && &t_Co != 256
  finish
endif

" }}}
" Global Settings: {{{

if !exists('g:monokai_bold')
  let g:monokai_bold=1
endif
if !exists('g:monokai_italic')
  if has('gui_running') || $TERM_ITALICS == 'true'
    let g:monokai_italic=1
  else
    let g:monokai_italic=0
  endif
endif
if !exists('g:monokai_undercurl')
  let g:monokai_undercurl=1
endif
if !exists('g:monokai_underline')
  let g:monokai_underline=1
endif
if !exists('g:monokai_inverse')
  let g:monokai_inverse=1
endif

if !exists('g:monokai_guisp_fallback') || index(['fg', 'bg'], g:monokai_guisp_fallback) == -1
  let g:monokai_guisp_fallback='NONE'
endif

if !exists('g:monokai_improved_strings')
  let g:monokai_improved_strings=0
endif

if !exists('g:monokai_improved_warnings')
  let g:monokai_improved_warnings=0
endif

if !exists('g:monokai_termcolors')
  let g:monokai_termcolors=256
endif

if !exists('g:monokai_invert_indent_guides')
  let g:monokai_invert_indent_guides=0
endif

if exists('g:monokai_contrast')
  echo 'g:monokai_contrast is deprecated; use g:monokai_contrast_light and g:monokai_contrast_dark instead'
endif

if !exists('g:monokai_contrast_dark')
  let g:monokai_contrast_dark='medium'
endif

if !exists('g:monokai_contrast_light')
  let g:monokai_contrast_light='medium'
endif

let s:is_dark=(&background == 'dark')

" }}}
" Palette: {{{

" setup palette dictionary
let s:gb = {}

" fill it with absolute colors
let s:gb.dark0_hard  = ['#1d2021', 234]     " 29-32-33
let s:gb.dark0       = ['#282828', 235]     " 40-40-40
let s:gb.dark0_soft  = ['#32302f', 236]     " 50-48-47
let s:gb.dark1       = ['#3c3836', 237]     " 60-56-54
let s:gb.dark2       = ['#504945', 239]     " 80-73-69
let s:gb.dark3       = ['#665c54', 241]     " 102-92-84
let s:gb.dark4       = ['#7c6f64', 243]     " 124-111-100
let s:gb.dark4_256   = ['#7c6f64', 243]     " 124-111-100

let s:gb.gray_245    = ['#928374', 245]     " 146-131-116
let s:gb.gray_244    = ['#928374', 244]     " 146-131-116

let s:gb.light0_hard = ['#f9f5d7', 230]     " 249-245-215
let s:gb.light0      = ['#fbf1c7', 229]     " 253-244-193
let s:gb.light0_soft = ['#f2e5bc', 228]     " 242-229-188
let s:gb.light1      = ['#ebdbb2', 223]     " 235-219-178
let s:gb.light2      = ['#d5c4a1', 250]     " 213-196-161
let s:gb.light3      = ['#bdae93', 248]     " 189-174-147
let s:gb.light4      = ['#a89984', 246]     " 168-153-132
let s:gb.light4_256  = ['#a89984', 246]     " 168-153-132

let s:gb.bright_red     = ['#fb4934', 167]     " 251-73-52
let s:gb.bright_green   = ['#b8bb26', 142]     " 184-187-38
let s:gb.bright_yellow  = ['#fabd2f', 214]     " 250-189-47
let s:gb.bright_blue    = ['#83a598', 109]     " 131-165-152
let s:gb.bright_purple  = ['#d3869b', 175]     " 211-134-155
let s:gb.bright_aqua    = ['#8ec07c', 108]     " 142-192-124
let s:gb.bright_orange  = ['#fe8019', 208]     " 254-128-25

let s:gb.neutral_red    = ['#cc241d', 124]     " 204-36-29
let s:gb.neutral_green  = ['#98971a', 106]     " 152-151-26
let s:gb.neutral_yellow = ['#d79921', 172]     " 215-153-33
let s:gb.neutral_blue   = ['#458588', 66]      " 69-133-136
let s:gb.neutral_purple = ['#b16286', 132]     " 177-98-134
let s:gb.neutral_aqua   = ['#689d6a', 72]      " 104-157-106
let s:gb.neutral_orange = ['#d65d0e', 166]     " 214-93-14

let s:gb.faded_red      = ['#9d0006', 88]      " 157-0-6
let s:gb.faded_green    = ['#79740e', 100]     " 121-116-14
let s:gb.faded_yellow   = ['#b57614', 136]     " 181-118-20
let s:gb.faded_blue     = ['#076678', 24]      " 7-102-120
let s:gb.faded_purple   = ['#8f3f71', 96]      " 143-63-113
let s:gb.faded_aqua     = ['#427b58', 66]      " 66-123-88
let s:gb.faded_orange   = ['#af3a03', 130]     " 175-58-3

" }}}
" Setup Emphasis: {{{

let s:bold = 'bold,'
if g:monokai_bold == 0
  let s:bold = ''
endif

let s:italic = 'italic,'
if g:monokai_italic == 0
  let s:italic = ''
endif

let s:underline = 'underline,'
if g:monokai_underline == 0
  let s:underline = ''
endif

let s:undercurl = 'undercurl,'
if g:monokai_undercurl == 0
  let s:undercurl = ''
endif

let s:inverse = 'inverse,'
if g:monokai_inverse == 0
  let s:inverse = ''
endif

" }}}
" Setup Colors: {{{

let s:vim_bg = ['bg', 'bg']
let s:vim_fg = ['fg', 'fg']
let s:none = ['NONE', 'NONE']

" determine relative colors
if s:is_dark
  let s:bg0  = s:gb.dark0
  if g:monokai_contrast_dark == 'soft'
    let s:bg0  = s:gb.dark0_soft
  elseif g:monokai_contrast_dark == 'hard'
    let s:bg0  = s:gb.dark0_hard
  endif

  let s:bg1  = s:gb.dark1
  let s:bg2  = s:gb.dark2
  let s:bg3  = s:gb.dark3
  let s:bg4  = s:gb.dark4

  let s:gray = s:gb.gray_245

  let s:fg0 = s:gb.light0
  let s:fg1 = s:gb.light1
  let s:fg2 = s:gb.light2
  let s:fg3 = s:gb.light3
  let s:fg4 = s:gb.light4

  let s:fg4_256 = s:gb.light4_256

  let s:red    = s:gb.bright_red
  let s:green  = s:gb.bright_green
  let s:yellow = s:gb.bright_yellow
  let s:blue   = s:gb.bright_blue
  let s:purple = s:gb.bright_purple
  let s:aqua   = s:gb.bright_aqua
  let s:orange = s:gb.bright_orange
else
  let s:bg0  = s:gb.light0
  if g:monokai_contrast_light == 'soft'
    let s:bg0  = s:gb.light0_soft
  elseif g:monokai_contrast_light == 'hard'
    let s:bg0  = s:gb.light0_hard
  endif

  let s:bg1  = s:gb.light1
  let s:bg2  = s:gb.light2
  let s:bg3  = s:gb.light3
  let s:bg4  = s:gb.light4

  let s:gray = s:gb.gray_244

  let s:fg0 = s:gb.dark0
  let s:fg1 = s:gb.dark1
  let s:fg2 = s:gb.dark2
  let s:fg3 = s:gb.dark3
  let s:fg4 = s:gb.dark4

  let s:fg4_256 = s:gb.dark4_256

  let s:red    = s:gb.faded_red
  let s:green  = s:gb.faded_green
  let s:yellow = s:gb.faded_yellow
  let s:blue   = s:gb.faded_blue
  let s:purple = s:gb.faded_purple
  let s:aqua   = s:gb.faded_aqua
  let s:orange = s:gb.faded_orange
endif

" reset to 16 colors fallback
if g:monokai_termcolors == 16
  let s:bg0[1]    = 0
  let s:fg4[1]    = 7
  let s:gray[1]   = 8
  let s:red[1]    = 9
  let s:green[1]  = 10
  let s:yellow[1] = 11
  let s:blue[1]   = 12
  let s:purple[1] = 13
  let s:aqua[1]   = 14
  let s:fg1[1]    = 15
endif

" save current relative colors back to palette dictionary
let s:gb.bg0 = s:bg0
let s:gb.bg1 = s:bg1
let s:gb.bg2 = s:bg2
let s:gb.bg3 = s:bg3
let s:gb.bg4 = s:bg4

let s:gb.gray = s:gray

let s:gb.fg0 = s:fg0
let s:gb.fg1 = s:fg1
let s:gb.fg2 = s:fg2
let s:gb.fg3 = s:fg3
let s:gb.fg4 = s:fg4

let s:gb.fg4_256 = s:fg4_256

let s:gb.red    = s:red
let s:gb.green  = s:green
let s:gb.yellow = s:yellow
let s:gb.blue   = s:blue
let s:gb.purple = s:purple
let s:gb.aqua   = s:aqua
let s:gb.orange = s:orange

" }}}
" Setup Terminal Colors For Neovim: {{{

if has('nvim')
  let g:terminal_color_0 = s:bg0[0]
  let g:terminal_color_8 = s:gray[0]

  let g:terminal_color_1 = s:gb.neutral_red[0]
  let g:terminal_color_9 = s:red[0]

  let g:terminal_color_2 = s:gb.neutral_green[0]
  let g:terminal_color_10 = s:green[0]

  let g:terminal_color_3 = s:gb.neutral_yellow[0]
  let g:terminal_color_11 = s:yellow[0]

  let g:terminal_color_4 = s:gb.neutral_blue[0]
  let g:terminal_color_12 = s:blue[0]

  let g:terminal_color_5 = s:gb.neutral_purple[0]
  let g:terminal_color_13 = s:purple[0]

  let g:terminal_color_6 = s:gb.neutral_aqua[0]
  let g:terminal_color_14 = s:aqua[0]

  let g:terminal_color_7 = s:fg4[0]
  let g:terminal_color_15 = s:fg1[0]
endif

" }}}
" Overload Setting: {{{

let s:hls_cursor = s:orange
if exists('g:monokai_hls_cursor')
  let s:hls_cursor = get(s:gb, g:monokai_hls_cursor)
endif

let s:number_column = s:none
if exists('g:monokai_number_column')
  let s:number_column = get(s:gb, g:monokai_number_column)
endif

let s:sign_column = s:bg1

if exists('g:gitgutter_override_sign_column_highlight') &&
      \ g:gitgutter_override_sign_column_highlight == 1
  let s:sign_column = s:number_column
else
  let g:gitgutter_override_sign_column_highlight = 0

  if exists('g:monokai_sign_column')
    let s:sign_column = get(s:gb, g:monokai_sign_column)
  endif
endif

let s:color_column = s:bg1
if exists('g:monokai_color_column')
  let s:color_column = get(s:gb, g:monokai_color_column)
endif

let s:vert_split = s:bg0
if exists('g:monokai_vert_split')
  let s:vert_split = get(s:gb, g:monokai_vert_split)
endif

let s:invert_signs = ''
if exists('g:monokai_invert_signs')
  if g:monokai_invert_signs == 1
    let s:invert_signs = s:inverse
  endif
endif

let s:invert_selection = s:inverse
if exists('g:monokai_invert_selection')
  if g:monokai_invert_selection == 0
    let s:invert_selection = ''
  endif
endif

let s:invert_tabline = ''
if exists('g:monokai_invert_tabline')
  if g:monokai_invert_tabline == 1
    let s:invert_tabline = s:inverse
  endif
endif

let s:italicize_comments = s:italic
if exists('g:monokai_italicize_comments')
  if g:monokai_italicize_comments == 0
    let s:italicize_comments = ''
  endif
endif

let s:italicize_strings = ''
if exists('g:monokai_italicize_strings')
  if g:monokai_italicize_strings == 1
    let s:italicize_strings = s:italic
  endif
endif

" }}}
" Highlighting Function: {{{

function! s:HL(group, fg, ...)
  " Arguments: group, guifg, guibg, gui, guisp

  " foreground
  let fg = a:fg

  " background
  if a:0 >= 1
    let bg = a:1
  else
    let bg = s:none
  endif

  " emphasis
  if a:0 >= 2 && strlen(a:2)
    let emstr = a:2
  else
    let emstr = 'NONE,'
  endif

  " special fallback
  if a:0 >= 3
    if g:monokai_guisp_fallback != 'NONE'
      let fg = a:3
    endif

    " bg fallback mode should invert higlighting
    if g:monokai_guisp_fallback == 'bg'
      let emstr .= 'inverse,'
    endif
  endif

  let histring = [ 'hi', a:group,
        \ 'guifg=' . fg[0], 'ctermfg=' . fg[1],
        \ 'guibg=' . bg[0], 'ctermbg=' . bg[1],
        \ 'gui=' . emstr[:-2], 'cterm=' . emstr[:-2]
        \ ]

  " special
  if a:0 >= 3
    call add(histring, 'guisp=' . a:3[0])
  endif

  execute join(histring, ' ')
endfunction

" }}}
" Monokai Hi Groups: {{{

" memoize common hi groups
call s:HL('MonokaiFg0', s:fg0)
call s:HL('MonokaiFg1', s:fg1)
call s:HL('MonokaiFg2', s:fg2)
call s:HL('MonokaiFg3', s:fg3)
call s:HL('MonokaiFg4', s:fg4)
call s:HL('MonokaiGray', s:gray)
call s:HL('MonokaiBg0', s:bg0)
call s:HL('MonokaiBg1', s:bg1)
call s:HL('MonokaiBg2', s:bg2)
call s:HL('MonokaiBg3', s:bg3)
call s:HL('MonokaiBg4', s:bg4)

call s:HL('MonokaiRed', s:red)
call s:HL('MonokaiRedBold', s:red, s:none, s:bold)
call s:HL('MonokaiGreen', s:green)
call s:HL('MonokaiGreenBold', s:green, s:none, s:bold)
call s:HL('MonokaiYellow', s:yellow)
call s:HL('MonokaiYellowBold', s:yellow, s:none, s:bold)
call s:HL('MonokaiBlue', s:blue)
call s:HL('MonokaiBlueBold', s:blue, s:none, s:bold)
call s:HL('MonokaiPurple', s:purple)
call s:HL('MonokaiPurpleBold', s:purple, s:none, s:bold)
call s:HL('MonokaiAqua', s:aqua)
call s:HL('MonokaiAquaBold', s:aqua, s:none, s:bold)
call s:HL('MonokaiOrange', s:orange)
call s:HL('MonokaiOrangeBold', s:orange, s:none, s:bold)

call s:HL('MonokaiRedSign', s:red, s:sign_column, s:invert_signs)
call s:HL('MonokaiGreenSign', s:green, s:sign_column, s:invert_signs)
call s:HL('MonokaiYellowSign', s:yellow, s:sign_column, s:invert_signs)
call s:HL('MonokaiBlueSign', s:blue, s:sign_column, s:invert_signs)
call s:HL('MonokaiPurpleSign', s:purple, s:sign_column, s:invert_signs)
call s:HL('MonokaiAquaSign', s:aqua, s:sign_column, s:invert_signs)

" }}}

" Vanilla colorscheme ---------------------------------------------------------
" General UI: {{{

" Normal text
call s:HL('Normal', s:fg1, s:bg0)

" Correct background (see issue #7):
" --- Problem with changing between dark and light on 256 color terminal
" --- https://github.com/morhetz/monokai/issues/7
if s:is_dark
  set background=dark
else
  set background=light
endif

if version >= 700
  " Screen line that the cursor is
  call s:HL('CursorLine',   s:none, s:bg1)
  " Screen column that the cursor is
  hi! link CursorColumn CursorLine

  " Tab pages line filler
  call s:HL('TabLineFill', s:bg4, s:bg1, s:invert_tabline)
  " Active tab page label
  call s:HL('TabLineSel', s:green, s:bg1, s:invert_tabline)
  " Not active tab page label
  hi! link TabLine TabLineFill

  " Match paired bracket under the cursor
  call s:HL('MatchParen', s:none, s:bg3, s:bold)
endif

if version >= 703
  " Highlighted screen columns
  call s:HL('ColorColumn',  s:none, s:color_column)

  " Concealed element: \lambda → λ
  call s:HL('Conceal', s:blue, s:none)

  " Line number of CursorLine
  call s:HL('CursorLineNr', s:yellow, s:bg1)
endif

hi! link NonText MonokaiBg2
hi! link SpecialKey MonokaiBg2

call s:HL('Visual',    s:none,  s:bg3, s:invert_selection)
hi! link VisualNOS Visual

call s:HL('Search',    s:yellow, s:bg0, s:inverse)
call s:HL('IncSearch', s:hls_cursor, s:bg0, s:inverse)

call s:HL('Underlined', s:blue, s:none, s:underline)

call s:HL('StatusLine',   s:bg2, s:fg1, s:inverse)
call s:HL('StatusLineNC', s:bg1, s:fg4, s:inverse)

" The column separating vertically split windows
call s:HL('VertSplit', s:bg3, s:vert_split)

" Current match in wildmenu completion
call s:HL('WildMenu', s:blue, s:bg2, s:bold)

" Directory names, special names in listing
hi! link Directory MonokaiGreenBold

" Titles for output from :set all, :autocmd, etc.
hi! link Title MonokaiGreenBold

" Error messages on the command line
call s:HL('ErrorMsg',   s:bg0, s:red, s:bold)
" More prompt: -- More --
hi! link MoreMsg MonokaiYellowBold
" Current mode message: -- INSERT --
hi! link ModeMsg MonokaiYellowBold
" 'Press enter' prompt and yes/no questions
hi! link Question MonokaiOrangeBold
" Warning messages
hi! link WarningMsg MonokaiRedBold

" }}}
" Gutter: {{{

" Line number for :number and :# commands
call s:HL('LineNr', s:bg4, s:number_column)

" Column where signs are displayed
call s:HL('SignColumn', s:none, s:sign_column)

" Line used for closed folds
call s:HL('Folded', s:gray, s:bg1, s:italic)
" Column where folds are displayed
call s:HL('FoldColumn', s:gray, s:bg1)

" }}}
" Cursor: {{{

" Character under cursor
call s:HL('Cursor', s:none, s:none, s:inverse)
" Visual mode cursor, selection
hi! link vCursor Cursor
" Input moder cursor
hi! link iCursor Cursor
" Language mapping cursor
hi! link lCursor Cursor

" }}}
" Syntax Highlighting: {{{

if g:monokai_improved_strings == 0
  hi! link Special MonokaiOrange
else
  call s:HL('Special', s:orange, s:bg1, s:italicize_strings)
endif

call s:HL('Comment', s:gray, s:none, s:italicize_comments)
call s:HL('Todo', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('Error', s:red, s:vim_bg, s:bold . s:inverse)

" Generic statement
hi! link Statement MonokaiRed
" if, then, else, endif, swicth, etc.
hi! link Conditional MonokaiRed
" for, do, while, etc.
hi! link Repeat MonokaiRed
" case, default, etc.
hi! link Label MonokaiRed
" try, catch, throw
hi! link Exception MonokaiRed
" sizeof, "+", "*", etc.
hi! link Operator Normal
" Any other keyword
hi! link Keyword MonokaiRed

" Variable name
hi! link Identifier MonokaiBlue
" Function name
hi! link Function MonokaiGreenBold

" Generic preprocessor
hi! link PreProc MonokaiAqua
" Preprocessor #include
hi! link Include MonokaiAqua
" Preprocessor #define
hi! link Define MonokaiAqua
" Same as Define
hi! link Macro MonokaiAqua
" Preprocessor #if, #else, #endif, etc.
hi! link PreCondit MonokaiAqua

" Generic constant
hi! link Constant MonokaiPurple
" Character constant: 'c', '/n'
hi! link Character MonokaiPurple
" String constant: "this is a string"
if g:monokai_improved_strings == 0
  call s:HL('String',  s:green, s:none, s:italicize_strings)
else
  call s:HL('String',  s:fg1, s:bg1, s:italicize_strings)
endif
" Boolean constant: TRUE, false
hi! link Boolean MonokaiPurple
" Number constant: 234, 0xff
hi! link Number MonokaiPurple
" Floating point constant: 2.3e10
hi! link Float MonokaiPurple

" Generic type
hi! link Type MonokaiYellow
" static, register, volatile, etc
hi! link StorageClass MonokaiOrange
" struct, union, enum, etc.
hi! link Structure MonokaiAqua
" typedef
hi! link Typedef MonokaiYellow

" }}}
" Completion Menu: {{{

if version >= 700
  " Popup menu: normal item
  call s:HL('Pmenu', s:fg1, s:bg2)
  " Popup menu: selected item
  call s:HL('PmenuSel', s:bg2, s:blue, s:bold)
  " Popup menu: scrollbar
  call s:HL('PmenuSbar', s:none, s:bg2)
  " Popup menu: scrollbar thumb
  call s:HL('PmenuThumb', s:none, s:bg4)
endif

" }}}
" Diffs: {{{

call s:HL('DiffDelete', s:red, s:bg0, s:inverse)
call s:HL('DiffAdd',    s:green, s:bg0, s:inverse)
"call s:HL('DiffChange', s:bg0, s:blue)
"call s:HL('DiffText',   s:bg0, s:yellow)

" Alternative setting
call s:HL('DiffChange', s:aqua, s:bg0, s:inverse)
call s:HL('DiffText',   s:yellow, s:bg0, s:inverse)

" }}}
" Spelling: {{{

if has("spell")
  " Not capitalised word, or compile warnings
  if g:monokai_improved_warnings == 0
    call s:HL('SpellCap',   s:none, s:none, s:undercurl, s:red)
  else
    call s:HL('SpellCap',   s:green, s:none, s:bold . s:italic)
  endif
  " Not recognized word
  call s:HL('SpellBad',   s:none, s:none, s:undercurl, s:blue)
  " Wrong spelling for selected region
  call s:HL('SpellLocal', s:none, s:none, s:undercurl, s:aqua)
  " Rare word
  call s:HL('SpellRare',  s:none, s:none, s:undercurl, s:purple)
endif

" }}}

" Plugin specific -------------------------------------------------------------
" EasyMotion: {{{

hi! link EasyMotionTarget Search
hi! link EasyMotionShade Comment

" }}}
" Sneak: {{{

autocmd ColorScheme monokai hi! link Sneak Search
autocmd ColorScheme monokai hi! link SneakLabel Search

" }}}
" Indent Guides: {{{

if !exists('g:indent_guides_auto_colors')
  let g:indent_guides_auto_colors = 0
endif

if g:indent_guides_auto_colors == 0
  if g:monokai_invert_indent_guides == 0
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg1)
  else
    call s:HL('IndentGuidesOdd', s:vim_bg, s:bg2, s:inverse)
    call s:HL('IndentGuidesEven', s:vim_bg, s:bg3, s:inverse)
  endif
endif

" }}}
" IndentLine: {{{

if !exists('g:indentLine_color_term')
  let g:indentLine_color_term = s:bg2[1]
endif
if !exists('g:indentLine_color_gui')
  let g:indentLine_color_gui = s:bg2[0]
endif

" }}}
" Rainbow Parentheses: {{{

if !exists('g:rbpt_colorpairs')
  let g:rbpt_colorpairs =
    \ [
      \ ['blue', '#458588'], ['magenta', '#b16286'],
      \ ['red',  '#cc241d'], ['166',     '#d65d0e']
    \ ]
endif

let g:rainbow_guifgs = [ '#d65d0e', '#cc241d', '#b16286', '#458588' ]
let g:rainbow_ctermfgs = [ '166', 'red', 'magenta', 'blue' ]

if !exists('g:rainbow_conf')
   let g:rainbow_conf = {}
endif
if !has_key(g:rainbow_conf, 'guifgs')
   let g:rainbow_conf['guifgs'] = g:rainbow_guifgs
endif
if !has_key(g:rainbow_conf, 'ctermfgs')
   let g:rainbow_conf['ctermfgs'] = g:rainbow_ctermfgs
endif

let g:niji_dark_colours = g:rbpt_colorpairs
let g:niji_light_colours = g:rbpt_colorpairs

"}}}
" GitGutter: {{{

hi! link GitGutterAdd MonokaiGreenSign
hi! link GitGutterChange MonokaiAquaSign
hi! link GitGutterDelete MonokaiRedSign
hi! link GitGutterChangeDelete MonokaiAquaSign

" }}}
" GitCommit: "{{{

hi! link gitcommitSelectedFile MonokaiGreen
hi! link gitcommitDiscardedFile MonokaiRed

" }}}
" Signify: {{{

hi! link SignifySignAdd MonokaiGreenSign
hi! link SignifySignChange MonokaiAquaSign
hi! link SignifySignDelete MonokaiRedSign

" }}}
" Syntastic: {{{

call s:HL('SyntasticError', s:none, s:none, s:undercurl, s:red)
call s:HL('SyntasticWarning', s:none, s:none, s:undercurl, s:yellow)

hi! link SyntasticErrorSign MonokaiRedSign
hi! link SyntasticWarningSign MonokaiYellowSign

" }}}
" Signature: {{{
hi! link SignatureMarkText   MonokaiBlueSign
hi! link SignatureMarkerText MonokaiPurpleSign

" }}}
" ShowMarks: {{{

hi! link ShowMarksHLl MonokaiBlueSign
hi! link ShowMarksHLu MonokaiBlueSign
hi! link ShowMarksHLo MonokaiBlueSign
hi! link ShowMarksHLm MonokaiBlueSign

" }}}
" CtrlP: {{{

hi! link CtrlPMatch MonokaiYellow
hi! link CtrlPNoEntries MonokaiRed
hi! link CtrlPPrtBase MonokaiBg2
hi! link CtrlPPrtCursor MonokaiBlue
hi! link CtrlPLinePre MonokaiBg2

call s:HL('CtrlPMode1', s:blue, s:bg2, s:bold)
call s:HL('CtrlPMode2', s:bg0, s:blue, s:bold)
call s:HL('CtrlPStats', s:fg4, s:bg2, s:bold)

" }}}
" Startify: {{{

hi! link StartifyBracket MonokaiFg3
hi! link StartifyFile MonokaiFg1
hi! link StartifyNumber MonokaiBlue
hi! link StartifyPath MonokaiGray
hi! link StartifySlash MonokaiGray
hi! link StartifySection MonokaiYellow
hi! link StartifySpecial MonokaiBg2
hi! link StartifyHeader MonokaiOrange
hi! link StartifyFooter MonokaiBg2

" }}}
" Vimshell: {{{

let g:vimshell_escape_colors = [
  \ s:bg4[0], s:red[0], s:green[0], s:yellow[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg4[0],
  \ s:bg0[0], s:red[0], s:green[0], s:orange[0],
  \ s:blue[0], s:purple[0], s:aqua[0], s:fg0[0]
  \ ]

" }}}
" BufTabLine: {{{

call s:HL('BufTabLineCurrent', s:bg0, s:fg4)
call s:HL('BufTabLineActive', s:fg4, s:bg2)
call s:HL('BufTabLineHidden', s:bg4, s:bg1)
call s:HL('BufTabLineFill', s:bg0, s:bg0)

" }}}
" Asynchronous Lint Engine: {{{

call s:HL('ALEError', s:none, s:none, s:undercurl, s:red)
call s:HL('ALEWarning', s:none, s:none, s:undercurl, s:yellow)
call s:HL('ALEInfo', s:none, s:none, s:undercurl, s:blue)

hi! link ALEErrorSign MonokaiRedSign
hi! link ALEWarningSign MonokaiYellowSign
hi! link ALEInfoSign MonokaiBlueSign

" }}}
" Dirvish: {{{

hi! link DirvishPathTail MonokaiAqua
hi! link DirvishArg MonokaiYellow

" }}}
" Netrw: {{{

hi! link netrwDir MonokaiAqua
hi! link netrwClassify MonokaiAqua
hi! link netrwLink MonokaiGray
hi! link netrwSymLink MonokaiFg1
hi! link netrwExe MonokaiYellow
hi! link netrwComment MonokaiGray
hi! link netrwList MonokaiBlue
hi! link netrwHelpCmd MonokaiAqua
hi! link netrwCmdSep MonokaiFg3
hi! link netrwVersion MonokaiGreen

" }}}
" NERDTree: {{{

hi! link NERDTreeDir MonokaiAqua
hi! link NERDTreeDirSlash MonokaiAqua

hi! link NERDTreeOpenable MonokaiOrange
hi! link NERDTreeClosable MonokaiOrange

hi! link NERDTreeFile MonokaiFg1
hi! link NERDTreeExecFile MonokaiYellow

hi! link NERDTreeUp MonokaiGray
hi! link NERDTreeCWD MonokaiGreen
hi! link NERDTreeHelp MonokaiFg1

hi! link NERDTreeToggleOn MonokaiGreen
hi! link NERDTreeToggleOff MonokaiRed

" }}}
" Vim Multiple Cursors: {{{

call s:HL('multiple_cursors_cursor', s:none, s:none, s:inverse)
call s:HL('multiple_cursors_visual', s:none, s:bg2)

" }}}

" Filetype specific -----------------------------------------------------------
" Diff: {{{

hi! link diffAdded MonokaiGreen
hi! link diffRemoved MonokaiRed
hi! link diffChanged MonokaiAqua

hi! link diffFile MonokaiOrange
hi! link diffNewFile MonokaiYellow

hi! link diffLine MonokaiBlue

" }}}
" Html: {{{

hi! link htmlTag MonokaiBlue
hi! link htmlEndTag MonokaiBlue

hi! link htmlTagName MonokaiAquaBold
hi! link htmlArg MonokaiAqua

hi! link htmlScriptTag MonokaiPurple
hi! link htmlTagN MonokaiFg1
hi! link htmlSpecialTagName MonokaiAquaBold

call s:HL('htmlLink', s:fg4, s:none, s:underline)

hi! link htmlSpecialChar MonokaiOrange

call s:HL('htmlBold', s:vim_fg, s:vim_bg, s:bold)
call s:HL('htmlBoldUnderline', s:vim_fg, s:vim_bg, s:bold . s:underline)
call s:HL('htmlBoldItalic', s:vim_fg, s:vim_bg, s:bold . s:italic)
call s:HL('htmlBoldUnderlineItalic', s:vim_fg, s:vim_bg, s:bold . s:underline . s:italic)

call s:HL('htmlUnderline', s:vim_fg, s:vim_bg, s:underline)
call s:HL('htmlUnderlineItalic', s:vim_fg, s:vim_bg, s:underline . s:italic)
call s:HL('htmlItalic', s:vim_fg, s:vim_bg, s:italic)

" }}}
" Xml: {{{

hi! link xmlTag MonokaiBlue
hi! link xmlEndTag MonokaiBlue
hi! link xmlTagName MonokaiBlue
hi! link xmlEqual MonokaiBlue
hi! link docbkKeyword MonokaiAquaBold

hi! link xmlDocTypeDecl MonokaiGray
hi! link xmlDocTypeKeyword MonokaiPurple
hi! link xmlCdataStart MonokaiGray
hi! link xmlCdataCdata MonokaiPurple
hi! link dtdFunction MonokaiGray
hi! link dtdTagName MonokaiPurple

hi! link xmlAttrib MonokaiAqua
hi! link xmlProcessingDelim MonokaiGray
hi! link dtdParamEntityPunct MonokaiGray
hi! link dtdParamEntityDPunct MonokaiGray
hi! link xmlAttribPunct MonokaiGray

hi! link xmlEntity MonokaiOrange
hi! link xmlEntityPunct MonokaiOrange
" }}}
" Vim: {{{

call s:HL('vimCommentTitle', s:fg4_256, s:none, s:bold . s:italicize_comments)

hi! link vimNotation MonokaiOrange
hi! link vimBracket MonokaiOrange
hi! link vimMapModKey MonokaiOrange
hi! link vimFuncSID MonokaiFg3
hi! link vimSetSep MonokaiFg3
hi! link vimSep MonokaiFg3
hi! link vimContinue MonokaiFg3

" }}}
" Clojure: {{{

hi! link clojureKeyword MonokaiBlue
hi! link clojureCond MonokaiOrange
hi! link clojureSpecial MonokaiOrange
hi! link clojureDefine MonokaiOrange

hi! link clojureFunc MonokaiYellow
hi! link clojureRepeat MonokaiYellow
hi! link clojureCharacter MonokaiAqua
hi! link clojureStringEscape MonokaiAqua
hi! link clojureException MonokaiRed

hi! link clojureRegexp MonokaiAqua
hi! link clojureRegexpEscape MonokaiAqua
call s:HL('clojureRegexpCharClass', s:fg3, s:none, s:bold)
hi! link clojureRegexpMod clojureRegexpCharClass
hi! link clojureRegexpQuantifier clojureRegexpCharClass

hi! link clojureParen MonokaiFg3
hi! link clojureAnonArg MonokaiYellow
hi! link clojureVariable MonokaiBlue
hi! link clojureMacro MonokaiOrange

hi! link clojureMeta MonokaiYellow
hi! link clojureDeref MonokaiYellow
hi! link clojureQuote MonokaiYellow
hi! link clojureUnquote MonokaiYellow

" }}}
" C: {{{

hi! link cOperator MonokaiPurple
hi! link cStructure MonokaiOrange

" }}}
" Python: {{{

hi! link pythonBuiltin MonokaiOrange
hi! link pythonBuiltinObj MonokaiOrange
hi! link pythonBuiltinFunc MonokaiOrange
hi! link pythonFunction MonokaiAqua
hi! link pythonDecorator MonokaiRed
hi! link pythonInclude MonokaiBlue
hi! link pythonImport MonokaiBlue
hi! link pythonRun MonokaiBlue
hi! link pythonCoding MonokaiBlue
hi! link pythonOperator MonokaiRed
hi! link pythonException MonokaiRed
hi! link pythonExceptions MonokaiPurple
hi! link pythonBoolean MonokaiPurple
hi! link pythonDot MonokaiFg3
hi! link pythonConditional MonokaiRed
hi! link pythonRepeat MonokaiRed
hi! link pythonDottedName MonokaiGreenBold

" }}}
" CSS: {{{

hi! link cssBraces MonokaiBlue
hi! link cssFunctionName MonokaiYellow
hi! link cssIdentifier MonokaiOrange
hi! link cssClassName MonokaiGreen
hi! link cssColor MonokaiBlue
hi! link cssSelectorOp MonokaiBlue
hi! link cssSelectorOp2 MonokaiBlue
hi! link cssImportant MonokaiGreen
hi! link cssVendor MonokaiFg1

hi! link cssTextProp MonokaiAqua
hi! link cssAnimationProp MonokaiAqua
hi! link cssUIProp MonokaiYellow
hi! link cssTransformProp MonokaiAqua
hi! link cssTransitionProp MonokaiAqua
hi! link cssPrintProp MonokaiAqua
hi! link cssPositioningProp MonokaiYellow
hi! link cssBoxProp MonokaiAqua
hi! link cssFontDescriptorProp MonokaiAqua
hi! link cssFlexibleBoxProp MonokaiAqua
hi! link cssBorderOutlineProp MonokaiAqua
hi! link cssBackgroundProp MonokaiAqua
hi! link cssMarginProp MonokaiAqua
hi! link cssListProp MonokaiAqua
hi! link cssTableProp MonokaiAqua
hi! link cssFontProp MonokaiAqua
hi! link cssPaddingProp MonokaiAqua
hi! link cssDimensionProp MonokaiAqua
hi! link cssRenderProp MonokaiAqua
hi! link cssColorProp MonokaiAqua
hi! link cssGeneratedContentProp MonokaiAqua

" }}}
" JavaScript: {{{

hi! link javaScriptBraces MonokaiFg1
hi! link javaScriptFunction MonokaiAqua
hi! link javaScriptIdentifier MonokaiRed
hi! link javaScriptMember MonokaiBlue
hi! link javaScriptNumber MonokaiPurple
hi! link javaScriptNull MonokaiPurple
hi! link javaScriptParens MonokaiFg3

" }}}
" YAJS: {{{

hi! link javascriptImport MonokaiAqua
hi! link javascriptExport MonokaiAqua
hi! link javascriptClassKeyword MonokaiAqua
hi! link javascriptClassExtends MonokaiAqua
hi! link javascriptDefault MonokaiAqua

hi! link javascriptClassName MonokaiYellow
hi! link javascriptClassSuperName MonokaiYellow
hi! link javascriptGlobal MonokaiYellow

hi! link javascriptEndColons MonokaiFg1
hi! link javascriptFuncArg MonokaiFg1
hi! link javascriptGlobalMethod MonokaiFg1
hi! link javascriptNodeGlobal MonokaiFg1
hi! link javascriptBOMWindowProp MonokaiFg1
hi! link javascriptArrayMethod MonokaiFg1
hi! link javascriptArrayStaticMethod MonokaiFg1
hi! link javascriptCacheMethod MonokaiFg1
hi! link javascriptDateMethod MonokaiFg1
hi! link javascriptMathStaticMethod MonokaiFg1

" hi! link javascriptProp MonokaiFg1
hi! link javascriptURLUtilsProp MonokaiFg1
hi! link javascriptBOMNavigatorProp MonokaiFg1
hi! link javascriptDOMDocMethod MonokaiFg1
hi! link javascriptDOMDocProp MonokaiFg1
hi! link javascriptBOMLocationMethod MonokaiFg1
hi! link javascriptBOMWindowMethod MonokaiFg1
hi! link javascriptStringMethod MonokaiFg1

hi! link javascriptVariable MonokaiOrange
" hi! link javascriptVariable MonokaiRed
" hi! link javascriptIdentifier MonokaiOrange
" hi! link javascriptClassSuper MonokaiOrange
hi! link javascriptIdentifier MonokaiOrange
hi! link javascriptClassSuper MonokaiOrange

" hi! link javascriptFuncKeyword MonokaiOrange
" hi! link javascriptAsyncFunc MonokaiOrange
hi! link javascriptFuncKeyword MonokaiAqua
hi! link javascriptAsyncFunc MonokaiAqua
hi! link javascriptClassStatic MonokaiOrange

hi! link javascriptOperator MonokaiRed
hi! link javascriptForOperator MonokaiRed
hi! link javascriptYield MonokaiRed
hi! link javascriptExceptions MonokaiRed
hi! link javascriptMessage MonokaiRed

hi! link javascriptTemplateSB MonokaiAqua
hi! link javascriptTemplateSubstitution MonokaiFg1

" hi! link javascriptLabel MonokaiBlue
" hi! link javascriptObjectLabel MonokaiBlue
" hi! link javascriptPropertyName MonokaiBlue
hi! link javascriptLabel MonokaiFg1
hi! link javascriptObjectLabel MonokaiFg1
hi! link javascriptPropertyName MonokaiFg1

hi! link javascriptLogicSymbols MonokaiFg1
hi! link javascriptArrowFunc MonokaiYellow

hi! link javascriptDocParamName MonokaiFg4
hi! link javascriptDocTags MonokaiFg4
hi! link javascriptDocNotation MonokaiFg4
hi! link javascriptDocParamType MonokaiFg4
hi! link javascriptDocNamedParamType MonokaiFg4

hi! link javascriptBrackets MonokaiFg1
hi! link javascriptDOMElemAttrs MonokaiFg1
hi! link javascriptDOMEventMethod MonokaiFg1
hi! link javascriptDOMNodeMethod MonokaiFg1
hi! link javascriptDOMStorageMethod MonokaiFg1
hi! link javascriptHeadersMethod MonokaiFg1

hi! link javascriptAsyncFuncKeyword MonokaiRed
hi! link javascriptAwaitFuncKeyword MonokaiRed

" }}}
" PanglossJS: {{{

hi! link jsClassKeyword MonokaiAqua
hi! link jsExtendsKeyword MonokaiAqua
hi! link jsExportDefault MonokaiAqua
hi! link jsTemplateBraces MonokaiAqua
hi! link jsGlobalNodeObjects MonokaiFg1
hi! link jsGlobalObjects MonokaiFg1
hi! link jsFunction MonokaiAqua
hi! link jsFuncParens MonokaiFg3
hi! link jsParens MonokaiFg3
hi! link jsNull MonokaiPurple
hi! link jsUndefined MonokaiPurple
hi! link jsClassDefinition MonokaiYellow

" }}}
" TypeScript: {{{

hi! link typeScriptReserved MonokaiAqua
hi! link typeScriptLabel MonokaiAqua
hi! link typeScriptFuncKeyword MonokaiAqua
hi! link typeScriptIdentifier MonokaiOrange
hi! link typeScriptBraces MonokaiFg1
hi! link typeScriptEndColons MonokaiFg1
hi! link typeScriptDOMObjects MonokaiFg1
hi! link typeScriptAjaxMethods MonokaiFg1
hi! link typeScriptLogicSymbols MonokaiFg1
hi! link typeScriptDocSeeTag Comment
hi! link typeScriptDocParam Comment
hi! link typeScriptDocTags vimCommentTitle
hi! link typeScriptGlobalObjects MonokaiFg1
hi! link typeScriptParens MonokaiFg3
hi! link typeScriptOpSymbols MonokaiFg3
hi! link typeScriptHtmlElemProperties MonokaiFg1
hi! link typeScriptNull MonokaiPurple
hi! link typeScriptInterpolationDelimiter MonokaiAqua

" }}}
" PureScript: {{{

hi! link purescriptModuleKeyword MonokaiAqua
hi! link purescriptModuleName MonokaiFg1
hi! link purescriptWhere MonokaiAqua
hi! link purescriptDelimiter MonokaiFg4
hi! link purescriptType MonokaiFg1
hi! link purescriptImportKeyword MonokaiAqua
hi! link purescriptHidingKeyword MonokaiAqua
hi! link purescriptAsKeyword MonokaiAqua
hi! link purescriptStructure MonokaiAqua
hi! link purescriptOperator MonokaiBlue

hi! link purescriptTypeVar MonokaiFg1
hi! link purescriptConstructor MonokaiFg1
hi! link purescriptFunction MonokaiFg1
hi! link purescriptConditional MonokaiOrange
hi! link purescriptBacktick MonokaiOrange

" }}}
" CoffeeScript: {{{

hi! link coffeeExtendedOp MonokaiFg3
hi! link coffeeSpecialOp MonokaiFg3
hi! link coffeeCurly MonokaiOrange
hi! link coffeeParen MonokaiFg3
hi! link coffeeBracket MonokaiOrange

" }}}
" Ruby: {{{

hi! link rubyStringDelimiter MonokaiGreen
hi! link rubyInterpolationDelimiter MonokaiAqua

" }}}
" ObjectiveC: {{{

hi! link objcTypeModifier MonokaiRed
hi! link objcDirective MonokaiBlue

" }}}
" Go: {{{

hi! link goDirective MonokaiAqua
hi! link goConstants MonokaiPurple
hi! link goDeclaration MonokaiRed
hi! link goDeclType MonokaiBlue
hi! link goBuiltins MonokaiOrange

" }}}
" Lua: {{{

hi! link luaIn MonokaiRed
hi! link luaFunction MonokaiAqua
hi! link luaTable MonokaiOrange

" }}}
" MoonScript: {{{

hi! link moonSpecialOp MonokaiFg3
hi! link moonExtendedOp MonokaiFg3
hi! link moonFunction MonokaiFg3
hi! link moonObject MonokaiYellow

" }}}
" Java: {{{

hi! link javaAnnotation MonokaiBlue
hi! link javaDocTags MonokaiAqua
hi! link javaCommentTitle vimCommentTitle
hi! link javaParen MonokaiFg3
hi! link javaParen1 MonokaiFg3
hi! link javaParen2 MonokaiFg3
hi! link javaParen3 MonokaiFg3
hi! link javaParen4 MonokaiFg3
hi! link javaParen5 MonokaiFg3
hi! link javaOperator MonokaiOrange

hi! link javaVarArg MonokaiGreen

" }}}
" Elixir: {{{

hi! link elixirDocString Comment

hi! link elixirStringDelimiter MonokaiGreen
hi! link elixirInterpolationDelimiter MonokaiAqua

hi! link elixirModuleDeclaration MonokaiYellow

" }}}
" Scala: {{{

" NB: scala vim syntax file is kinda horrible
hi! link scalaNameDefinition MonokaiFg1
hi! link scalaCaseFollowing MonokaiFg1
hi! link scalaCapitalWord MonokaiFg1
hi! link scalaTypeExtension MonokaiFg1

hi! link scalaKeyword MonokaiRed
hi! link scalaKeywordModifier MonokaiRed

hi! link scalaSpecial MonokaiAqua
hi! link scalaOperator MonokaiFg1

hi! link scalaTypeDeclaration MonokaiYellow
hi! link scalaTypeTypePostDeclaration MonokaiYellow

hi! link scalaInstanceDeclaration MonokaiFg1
hi! link scalaInterpolation MonokaiAqua

" }}}
" Markdown: {{{

call s:HL('markdownItalic', s:fg3, s:none, s:italic)

hi! link markdownH1 MonokaiGreenBold
hi! link markdownH2 MonokaiGreenBold
hi! link markdownH3 MonokaiYellowBold
hi! link markdownH4 MonokaiYellowBold
hi! link markdownH5 MonokaiYellow
hi! link markdownH6 MonokaiYellow

hi! link markdownCode MonokaiAqua
hi! link markdownCodeBlock MonokaiAqua
hi! link markdownCodeDelimiter MonokaiAqua

hi! link markdownBlockquote MonokaiGray
hi! link markdownListMarker MonokaiGray
hi! link markdownOrderedListMarker MonokaiGray
hi! link markdownRule MonokaiGray
hi! link markdownHeadingRule MonokaiGray

hi! link markdownUrlDelimiter MonokaiFg3
hi! link markdownLinkDelimiter MonokaiFg3
hi! link markdownLinkTextDelimiter MonokaiFg3

hi! link markdownHeadingDelimiter MonokaiOrange
hi! link markdownUrl MonokaiPurple
hi! link markdownUrlTitleDelimiter MonokaiGreen

call s:HL('markdownLinkText', s:gray, s:none, s:underline)
hi! link markdownIdDeclaration markdownLinkText

" }}}
" Haskell: {{{

" hi! link haskellType MonokaiYellow
" hi! link haskellOperators MonokaiOrange
" hi! link haskellConditional MonokaiAqua
" hi! link haskellLet MonokaiOrange
"
hi! link haskellType MonokaiFg1
hi! link haskellIdentifier MonokaiFg1
hi! link haskellSeparator MonokaiFg1
hi! link haskellDelimiter MonokaiFg4
hi! link haskellOperators MonokaiBlue
"
hi! link haskellBacktick MonokaiOrange
hi! link haskellStatement MonokaiOrange
hi! link haskellConditional MonokaiOrange

hi! link haskellLet MonokaiAqua
hi! link haskellDefault MonokaiAqua
hi! link haskellWhere MonokaiAqua
hi! link haskellBottom MonokaiAqua
hi! link haskellBlockKeywords MonokaiAqua
hi! link haskellImportKeywords MonokaiAqua
hi! link haskellDeclKeyword MonokaiAqua
hi! link haskellDeriving MonokaiAqua
hi! link haskellAssocType MonokaiAqua

hi! link haskellNumber MonokaiPurple
hi! link haskellPragma MonokaiPurple

hi! link haskellString MonokaiGreen
hi! link haskellChar MonokaiGreen

" }}}
" Json: {{{

hi! link jsonKeyword MonokaiGreen
hi! link jsonQuote MonokaiGreen
hi! link jsonBraces MonokaiFg1
hi! link jsonString MonokaiFg1

" }}}


" Functions -------------------------------------------------------------------
" Search Highlighting Cursor {{{

function! MonokaiHlsShowCursor()
  call s:HL('Cursor', s:bg0, s:hls_cursor)
endfunction

function! MonokaiHlsHideCursor()
  call s:HL('Cursor', s:none, s:none, s:inverse)
endfunction

" }}}

" vim: set sw=2 ts=2 sts=2 et tw=80 ft=vim fdm=marker:
