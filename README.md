Dotfiles
========

My own highly customized configuration files for my own use. It may give ideas for yours or you can copy any configuration altogether.

Git
---

I use [delta][delta] for git diffs. Make sure you installed it before.

Bash
----

I use this [bashrc](bash/bashrc) file in archlinux. It is basically copied from [Josean Martinez's zshrc file](https://github.com/josean-dev/dev-environment-files/blob/main/.zshrc). Check his [tutorial video](https://www.youtube.com/watch?v=mmqDYw9C30I&t=798s) for more.

### The list of packages needed:

- [fd](https://github.com/sharkdp/fd)
- [eza](https://github.com/eza-community/eza)
- [bat][bat]
- [fzf][fuzzy]
- [Homebrew](https://github.com/homebrew/brew)
- [oh-my-posh][ohmyposh]
- [pyEnv](https://github.com/pyenv/pyenv): Comment it out if you don't use it

Neovim
------

My higly configured little by little over a long period of time and perfectionized for my own use neovim config. It uses builtin nvim.pack as plugin manager. During installation, a C compiler (`gcc` or `clang`) and `make` are needed to build [telescope-fzf-native](https://github.com/nvim-telescope/telescope-fzf-native.nvim). After installation, make sure you install required packages shown in `:checkhealth`. I recommend [PyLatexEnc](https://pypi.org/project/pylatexenc/) for parsing latex in markdown files.


[delta]: https://github.com/dandavison/delta
[fuzzy]: https://github.com/junegunn/fzf
[ohmyposh]: https://github.com/jandedobbeleer/oh-my-posh
[bat]: https://github.com/sharkdp/bat
