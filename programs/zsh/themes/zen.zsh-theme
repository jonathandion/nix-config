NEWLINE=$'\n'

getHasNixStoreBin() {
  if [[ "$PATH" == *"/nix/store/"* ]]; then
    echo "[%F{blue}nix%f]"
  fi
}

getJobs() {
  [[ -n $(jobs) ]] && echo ${NEWLINE}"$(jobs -p)"
}

git_prompt_info() {
  [[ -d .git ]] && echo "<git:$(git rev-parse --abbrev-ref HEAD)> "
}

PROMPT='[%F{yellow}%2~%B%b%f%b]$(getHasNixStoreBin)$(getJobs)${NEWLINE}[λ] $(git_prompt_info)'
