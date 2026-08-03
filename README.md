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

PowerShell
----------

This PowerShell config is mostly copied from [Scott Hanselman](https://github.com/shanselman) config. See his [tutorial video](https://www.youtube.com/watch?v=VT2L1SXFq9U) for more. Note that you must have installed these beforehand:

- [fzf][fuzzy]
- [bat][bat]
- [oh-my-posh][ohmyposh]

Neovim
------

My higly configured little by little over a long period of time and perfectionized for my own use neovim config. It uses builtin nvim-pack as plugin manager. After installation, make sure you install required packages shown in `:checkhealth`, and run `:BuildFzf` to compile [fzf.nvim](https://github.com/junegunn/fzf.vim) for fzf to work properly. I recommend [PyLatexEnc](https://pypi.org/project/pylatexenc/) for parsing latex in markdown files.


[delta]: https://github.com/dandavison/delta
[fuzzy]: https://github.com/junegunn/fzf
[ohmyposh]: https://github.com/jandedobbeleer/oh-my-posh
[bat]: https://github.com/sharkdp/bat
