#! /usr/bin/env bash

# Search upwards through parent directories for a file/directory
upfind () {
  local searchDir=$2
  if [[ -z $1 ]]; then
    return 1
  fi
  if [[ "$(realpath -q $searchDir)" = "/" ]]; then
    ls -d $searchDir$1 2>/dev/null
  else
    ls -d $searchDir$1 2>/dev/null || upfind $1 ../$searchDir
  fi
}

# Create a new worktree for the given branch
# Enhancements:
# - Adding a new worktree takes longer than I'd like, I've wondered about having
#   a special "on deck" worktree that is always ready to go and when we create a
#   new worktree, we just rename that folder, pull in the latest develop changes
#   and alias the new worktree. Hmm...this is going to take some though as it
#   isn't imediately clear how to do this sort of thing with native git commands.
new-worktree() {
  local worktree=$1
  local worktreeRootRepo=$(upfind .bare)
  if [[ -z $worktreeRootRepo ]]; then
    echo "Unable to find repository root. Are you in a git repository?"
    return 1
  fi
  local worktreeRoot=$(realpath -q "$worktreeRootRepo/..")
  local newWorktreeDir="$worktreeRoot/$worktree"
  git worktree add "$newWorktreeDir" $worktree
  if [[ $? -ne 0 ]]; then
    echo "Failed to add worktree '$worktree' at '$newWorktreeDir'"
    return 1
  fi
  # Create a hard link to the root vscode workspace settings file.
  ln "$worktreeRoot/settings.json" "$newWorktreeDir/.vscode/settings.json"
  # TODO: switch to new worktree?
}

# Switch to a worktree. Right now this prompts the user with a list of available worktrees to pick from.
# Enhancements:
# support "-" to switch to the previous worktree.
# support "-N" to swith to the previous Nth worktree
switch-worktree () {
  local worktree=$1
  if [[ -z $worktree ]]; then
    # This requires git 2.41.0 as `--stdin` was added in that release.
    local worktrees=$(git worktree list --porcelain | awk -F ' ' '$1 == "branch" {print $2}' | git for-each-ref --format='%(refname:short)' --stdin)
    worktree=$(echo "$worktrees" | fzf)
  fi
  local worktreeDir=$(upfind "$worktree")
  if [[ -z $worktreeDir ]]; then
    return 1
  fi
  # This is making an assumption that worktrees are always in a folder that matches their branch name...
  cd $worktreeDir
}

watch-pr() {
  local pr=$1
  gh pr checks $pr --watch --fail-fast --required -i 60
  if [[ $? -eq 0 ]]; then
    terminal-notifier -title "PR Checks Successful!" -message "Checks for PR $pr succeeded."
  else
    terminal-notifier -title "PR Checks Failed" -message "Checks for PR $pr failed."
  fi
}
