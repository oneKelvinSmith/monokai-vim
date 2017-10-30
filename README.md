# About

Monokai for Vim is a port of the popular TextMate theme [Monokai](http://www.monokai.nl/blog/2006/07/15/textmate-color-theme/) by Wimer Hazenberg.

The theme code is based on [gruvbox](https://github.com/morhetz/gruvbox) by Pavel Pertsev and is heavily derivative.

I like the colors and I'm learning to like Vim. This followed.

# Installation

Choose a plugin manager, these seem to be the current contenders:
* [Pathogen](https://github.com/tpope/vim-pathogen)
* [Vundle](https://github.com/gmarik/vundle)
* [vim-plug](https://github.com/junegunn/vim-plug)
* [dein](https://github.com/Shougo/dein.vim)

- Pathogen
  + `git clone https://github.com/oneKelvinSmith/monokai-vim.git ~/.vim/bundle/monokai-vim`
- Vundle
  + Add `Plugin 'oneKelvinSmith/monokai-vim'` to your `init.vim` and run `:PluginInstall`
- vim-plug
  + Add `Plug 'oneKelvinSmith/monokai-vim'` to your `init.vim` and run `:PlugInstall`
- Dein
  + Add the following  to your `init.vim` and run `:call dein#install()`:
    This assumes you have a plugin directory of `~/.cache/vimfiles` and have installed `dein` to `~/.cache/vimfiles/repos/github.com/Shougo/dein.vim`
    ```vimscript
    if &compatible
      set nocompatible
    endif

    set runtimepath+=~/.cache/vimfiles/repos/github.com/Shougo/dein.vim

    if dein#load_state(~/.cache/vimfiles)
      call dein#begin(~/.cache/vimfiles)
      call dein#add(~/.cache/vimfiles/repos/github.com/Shougo/dein.vim)

      " ...

      call dein#add('oneKelvinSmith/monokai-vim')

      " ...

      call dein#end()
      call dein#save_state()
    endif

    filetype plugin indent on
    syntax enable

    if dein#check_install()
      call dein#install()
    endif
    ```

Then add the line `colorscheme monokai` to your .vimrc file, and restart vim.

# Customization

...

# Bugs & Improvements

Please, report any problems that you find on the projects integrated
issue tracker. If you've added some improvements and you want them
included upstream please send a pull request.

Thank you,
Kelvin
