
export PATH="/usr/local/bin:$PATH"

[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# Shows name (in cyan), current working directory (in green), current branch (in pink)
PS1='\[\e[1;96m\]\u: \[\e[0;32m\]\W \[\033[00m\]$(git branch &>/dev/null; if [ $? -eq 0 ]; then echo "\[\e[0;35m\][$(git branch | grep ^*|sed s/\*\ //)] \[\033[00m\]"; fi)>> '

# grab git branch & branch autocomplete
parse_git_branch() { git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'; }
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# ------------ Git

alias gco='git checkout'
alias gcob='git checkout -b'
alias gs='git status'
alias ga='git add .'
alias gall='git add --all'
alias gc='git commit -m'
alias gpo='git push origin'
alias gpull='git pull origin master'

# ------------ Bash
alias code="cd ~/dropbox/code"
alias portfolio="cd ~/dropbox/code/portfolio"
alias blog="cd ~/dropbox/code/blog"
alias projecteuler="cd ~/dropbox/code/projecteuler"
alias desk='cd ~/Desktop'
alias ls='ls -GFh'
alias reload='source ~/.bash_profile'
alias ebash='subl ~/.bash_profile'

#---------------Ruby
alias be="bundle exec"


# Open GitHub webpage of current git repo
function github() {
  local github_url

  if ! git remote -v >/dev/null; then
    return 1
  fi

  # get remotes for fetch
  github_url="`git remote -v | grep github\.com | grep \(fetch\)$`"

  if [ -z "$github_url" ]; then
    echo "A GitHub remote was not found for this repository."
    return 1
  fi

  # look for origin in remotes, use that if found, otherwise use first result
  if [ "echo $github_url | grep '^origin' >/dev/null 2>&1" ]; then
    github_url="`echo $github_url | grep '^origin'`"
  else
    github_url="`echo $github_url | head -n1`"
  fi

  github_url="`echo $github_url | awk '{ print $2 }' | sed 's/git@github\.com:/http:\/\/github\.com\//g'`"
  open $github_url
}

# Make and cd into a directory
function mcd() {
  mkdir -p "$1" && cd "$1";
}

# Find a string in the entire git history
alias gitsearch='git rev-list --all | xargs git grep -F'

# Creates regenerating Jekyll server
alias js='jekyll serve --watch'

# Some tests with database commands in development
alias boom='be rake db:drop; be rake db:create && be rake db:migrate'
alias seed='be rake db:drop; be rake db:create && be rake db:migrate && rake db:seed'
alias booms='be rake db:drop; be rake db:create && be rake db:migrate && rails s'
alias seeds='be rake db:drop; be rake db:create && be rake db:migrate && rake db:seed && rails s'



