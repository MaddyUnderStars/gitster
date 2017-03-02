#
# Gitster theme
# https://github.com/shashankmehta/dotfiles/blob/master/thesetup/zsh/.oh-my-zsh/custom/themes/gitster.zsh-theme
#
# Requires the `git-info` zmodule to be included in the .zimrc file.

prompt_gitster_status() {
  print -n '%(?:%F{green}➜:%F{red}➜) '
}

prompt_gitster_pwd() {
  prompt_short_dir=$(short_pwd)
  git_root=$(command git rev-parse --show-toplevel 2> /dev/null) && prompt_short_dir=${prompt_short_dir#${$(short_pwd $git_root):h}/}
  print -n "%F{white}${prompt_short_dir}"
}

prompt_gitster_git() {
  [[ -n ${git_info} ]] && print -n "${(e)git_info[prompt]}"
}

prompt_gitster_precmd() {
  (( ${+functions[git-info]} )) && git-info
}

prompt_gitster_setup() {
  autoload -Uz colors && colors
  autoload -Uz add-zsh-hook

  prompt_opts=(cr percent subst)

  add-zsh-hook precmd prompt_gitster_precmd

  zstyle ':zim:git-info:branch' format '%b'
  zstyle ':zim:git-info:commit' format '%c'
  zstyle ':zim:git-info:clean' format '%F{green}✓'
  zstyle ':zim:git-info:dirty' format '%F{yellow}✗'
  zstyle ':zim:git-info:keys' format \
    'prompt' ' %F{cyan}%b%c %C%D'

  PROMPT='$(prompt_gitster_status)$(prompt_gitster_pwd)$(prompt_gitster_git)%f '
  RPROMPT=''
}

prompt_gitster_setup "$@"
