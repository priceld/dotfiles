ULTRA_DIR="/Users/Logan.Price/work/ultra"
ULTRA_WORKTREE_DIR="/Users/Logan.Price/work/ultra-worktree"
if [[ ! $PWD/ = $ULTRA_WORKTREE_DIR/* ]]; then
  if [[ ! $PWD/ = $ULTRA_DIR/* ]]; then
    echo "Command must be run from an ultra directory."
    exit 1
  fi
fi

# Use fzf to select the branch from which to create the worktree.
branch=$(git for-each-ref --format='%(refname:short)' --sort=authorname | fzf)

# Start a new tmux session with the branch name, if one with that name already
# exists, attach to it.
tmux new-session -A -d -c "$ULTRA_WORKTREE_DIR" -s "$branch"
# Run a command in the first window of the new session (note tmux by default
# starts windows at 0, not 1, but I've changed my tmux.config to start at 1).
tmux send-keys -t "$branch.1" "echo 'Hello world'" ENTER
# I probably want this command to be a shell script that does the following:
# 1. Create a worktree for the given branch
# 2. Run ./update.sh
# 3. Notify when done.

# Might be nice to have another script that goes to the apps/ultra-ui directory
# and runs the following command:
# yarn start
# I would then have another script which sends this command to the tmux window.
# This script, instead of fuzzy finding a branch, would fuzzy find a tmux session.