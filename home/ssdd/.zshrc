HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory HIST_IGNORE_DUPS HIST_IGNORE_SPACE AUTO_CD EXTENDED_GLOB MULTIOS CORRECT nohup auto_resume nomatch notify
unsetopt beep share_history

autoload -U compinit
compinit
zstyle ':completion:*' menu select
zstyle ':completion:*:processes-names' command 'ps -e -o comm='
zstyle ':completion:*:processes' command 'ps -au$USER'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;32'


autoload -U promptinit
promptinit
prompt adam2 8bit `uname -ni | sha1sum | cut -c 3` 14 7
[[ -v IN_NIX_SHELL ]] && prompt_nixshell="%B%F{$prompt_adam2_color3} nix-shell  "
prompt_line_1a="$prompt_gfx_tbox$prompt_l_paren${prompt_nixshell}%B%F{$prompt_adam2_color2}%~$prompt_r_paren%b%F{$prompt_adam2_color1}"

#prompt adam2 8bit `uname -ni | sha1sum | cut -c 3` black black black magenta
#prompt_char="%(!.#.%B%F{black}>)"

# key bindings
bindkey -e
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "^[[1;5D" backward-word
bindkey "^[[1;5C" forward-word
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "^H" backward-delete-word
# for rxvt
#bindkey "\e[8~" end-of-line
#bindkey "\e[7~" beginning-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

alias ls='ls -Gh --color'
alias l='ls -lGh --color'
alias ll='ls -lath --color'
alias grep='grep --color'
alias ungz='tar xvzf'
alias unbz='tar xvjf'
alias @='sudo '

alias ta='textadept-curses'
alias s='sublime -n --command toggle_menu'
alias s.='sublime -n --command toggle_menu -a . README*(N)'
alias g='git'

alias t='setsid urxvt -cd $PWD'

alias n='nix-shell --show-trace --command zsh'
alias nr='nix-shell --show-trace command zsh --run "$1"'

nixf(){ nix-env -qaP \* -f '<nixpkgs>' | grep -i "$1"; }
nixh(){ nix-env  -qaP -f '<nixpkgs>' -A haskellPackages | grep -i "$1"; }
just(){ nix-shell -p "$1" --command "$(echo "$@")"; }

alias comp='compton --backend=glx --vsync=opengl-swc'

alias y='noglob youtube-dl --extract-audio --audio-format flac '

[[ -x `command -v keychain` ]] && eval $(keychain --eval -Q --quiet id_ecdsa id_rsa)
#envoy -t gpg-agent
#source <(envoy -p -t gpg-agent)

[[ -x `command -v dircolors` ]] && [[ -e .dircolors ]] && eval `dircolors .dircolors`

export MC_SKIN=$HOME/.config/mc/solarized.ini

eval "$(direnv hook zsh)"

PATH=$PATH:$HOME/.gem/ruby/2.2.0/bin
PATH=$PATH:$HOME/.cabal/bin
PATH=$PATH:$HOME/.npm_global/bin:node_modules/.bin
PATH=$PATH:$HOME/.bin
PATH=$PATH:$HOME/.local/bin

export PATH=/home/ssdd/.local/bin:$PATH
