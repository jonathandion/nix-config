NEWLINE=$'\n'

renderBlue() {
  $word=$1
  echo "%F{blue}$word%f%b"
}

getJobs() {
  [[ -n $(jobs) ]] && echo ${NEWLINE}"$(jobs -p)"
}

getStatus(){
  [[ `git status --porcelain` ]] && echo "|~"
}

git_prompt_info() {
  [[ -d .git ]] && echo "<git:$(git rev-parse --abbrev-ref HEAD)> "
}

PROMPT='[%F{blue}%2~%B%b%f%b]$(getJobs)${NEWLINE}[λ] $(git_prompt_info)'
