#!/bin/sh

# Added by m8jj

# 1. Set default value using the current Git branch name
BRANCH=$(git branch --show-current 2>/dev/null)

# 2. Process arguments
while [ $# -gt 0 ]; do
  case "$1" in
    -b)
      # Ensure $2 is not empty and does not start with a dash
      if [ -n "$2" ] && echo "$2" | grep -qv '^-'; then
        BRANCH="$2"
        shift 2
      else
        echo "Error: -b requires a branch name value." >&2
        exit 1
      fi
      ;;
    *)
      # Ignore other arguments and move to the next one
      shift 1
      ;;
  esac
done

# 3. Ensure we have a branch variable to work with
if [ -z "$BRANCH" ]; then
  echo "Error: No branch provided and not inside a Git repository." >&2
  exit 1
fi

echo "Checking remote existence for branch: $BRANCH..."

# 4. Check if the branch exists on the remote repository
git ls-remote --exit-code --heads origin "$BRANCH" >/dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "Remote branch '$BRANCH' found. Fetching and switching..."
  git fetch origin
  git switch "$BRANCH"
else
  echo "Remote branch '$BRANCH' does not exist. Pulling current tracking branch..."
  git pull
fi

echo "Building..."
pnpm i && pnpm build

echo "Restarting WSTD Service..."
service wstd restart

echo "\nWSTD Updated!"