# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# extra files in ~/.zsh/configs/pre , ~/.zsh/configs , and ~/.zsh/configs/post
# these are loaded first, second, and third, respectively.
_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*(N-.); do
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [ -f $config ]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*(N-.); do
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

source <(kubectl completion zsh)
alias kct='kubectl config use-context $(( kubectl config get-contexts -o name; kubectl config current-context ) | fzf -0 -1 --tac)'

function driveby() {
  lsof -i tcp:$1 | awk 'NR!=1 {print $2}' | xargs kill
  printf "Killed everything on port $1\n"
}

# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
# bind UP and DOWN arrow keys (compatibility fallback
# for Ubuntu 12.04, Fedora 21, and MacOSX 10.9 users)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

export PATH=$PATH:$(go env GOPATH)/bin
export PATH="/usr/local/opt/qt@5.5/bin:$PATH"

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export FASTLY_API_KEY='RTyCDccLUwlItQKu8CBo15XjZ-xK8w1q'

eval "$(nodenv init -)"

# aliases

# Unix
alias ll="ls -al"
alias ln="ln -v"
alias mkdir="mkdir -p"
alias e="$EDITOR"
alias v="$VISUAL"
alias k=kubectl
alias kx=kubectx

alias rfc='git ls-files -m | xargs ls -1 2>/dev/null | grep '\.rb$' | xargs rubocop -a'

# Bundler
alias b="bundle"
alias bec='bundle exec cucumber'
alias be='bundle exec'
alias bu='bundle update'

# Rails
alias migrate="rake db:migrate db:rollback && rake db:migrate db:test:prepare"
alias s="rspec"

alias retag='ctags -R --exclude=.gitignore --exclude=.git --exclude=log --exclude=tmp *'

# Pretty print the path
alias path='echo $PATH | tr -s ":" "\n"'

# Include custom aliases
[[ -f ~/.aliases.local ]] && source ~/.aliases.local


source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="/usr/local/opt/libxml2/bin:$PATH"

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
export GPG_TTY=$(tty)
