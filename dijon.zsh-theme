# vim:ft=zsh ts=2 sw=2 sts=2
# ininfallible's zsh theme
# basically agnoster theme with some aesthetic changes and stuff ripped out
# hacked together with minimal zsh scripting knowledge - your eyes will suffer :P
#
CURRENT_BG='black'
CURRENT_FG='black'

() {
	local LC_ALL="" LC_CTYPE="en_US.UTF-8"
	SEGMENT_START=$'\ue0b2'
	#SEGMENT_START=$'▌'
	#SEGMENT_START=$'▒ '
	SEGMENT_END=$'\ue0b0'
	#SEGMENT_END=$'▐'
	#SEGMENT_END=$' '
	#SEGMENT_END=$' ▒'
}

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
start_segment() {
	echo -n "%F{$1}$SEGMENT_START%F{$2}%K{$1}"
	[[ -n $3 ]] && echo -n $3
}

# Close a segment
end_segment() {
  echo -n "%S$SEGMENT_END%s"
  echo -n "%k%f"
}

# Dir: current working directory
prompt_dir() {
  start_segment blue black '%~'
	end_segment
}


# Context: user@hostname
prompt_context() {
  if [[ "$USER" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    start_segment magenta black "%(!.%{%F{yellow}%}.)%n@%m"
		end_segment
  fi
}

# Dir: current work
# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local -a symbols

  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}X"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}!"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && start_segment black default "$symbols"
}
# Git: branch/detached head, dirty status
prompt_git() {
  (( $+commands[git] )) || return
  if [[ "$(git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]]; then
    return
  fi
  local PL_BRANCH_CHAR
  () {
    local LC_ALL="" LC_CTYPE="en_US.UTF-8"
    PL_BRANCH_CHAR=$'\ue0a0'         # 
  }
  local ref dirty mode repo_path

  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    repo_path=$(git rev-parse --git-dir 2>/dev/null)
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git rev-parse --short HEAD 2> /dev/null)"
    if [[ -n $dirty ]]; then
      start_segment yellow black
    else
      start_segment green $CURRENT_FG
    fi

    if [[ -e "${repo_path}/BISECT_LOG" ]]; then
      mode=" <B>"
    elif [[ -e "${repo_path}/MERGE_HEAD" ]]; then
      mode=" >M<"
    elif [[ -e "${repo_path}/rebase" || -e "${repo_path}/rebase-apply" || -e "${repo_path}/rebase-merge" || -e "${repo_path}/../.dotest" ]]; then
      mode=" >R>"
    fi

    setopt promptsubst
    autoload -Uz vcs_info

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' get-revision true
    zstyle ':vcs_info:*' check-for-changes true
    zstyle ':vcs_info:*' stagedstr '✚'
    zstyle ':vcs_info:*' unstagedstr '●'
    zstyle ':vcs_info:*' formats ' %u%c'
    zstyle ':vcs_info:*' actionformats ' %u%c'
    vcs_info
    echo -n "${ref/refs\/heads\//$PL_BRANCH_CHAR }${vcs_info_msg_0_%% }${mode}"
		end_segment
  fi
}
 
build_prompt() {
	RETVAL=$?
	prompt_context
	prompt_dir
	prompt_git
}
# end snippet is for adding an newline if not enough space to the right (20 chars)
NEWLINE=$'\n'
PROMPT='%{%f%b%k%}$(build_prompt) %-20(l::${NEWLINE})'
