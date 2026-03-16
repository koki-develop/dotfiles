#!/bin/bash

input=$(cat)

# ANSI colors (may not be supported — remove if statusline renders raw codes)
C_RESET='\033[0m'
C_MODEL='\033[1;36m'     # bold cyan
C_DIR='\033[0;33m'       # yellow
C_BRANCH='\033[0;32m'    # green
C_BAR_FILL='\033[0;32m'  # green
C_BAR_EMPTY='\033[0;90m' # dark gray
C_LABEL='\033[0;90m'     # dark gray
C_VALUE='\033[0;37m'     # white

eval "$(jq -r '
  @sh "raw_cwd=\(.cwd // "")",
  @sh "model=\(.model.display_name // "")",
  @sh "used=\(.context_window.used_percentage // 0)",
  @sh "remaining=\(.context_window.remaining_percentage // 100)",
  @sh "session_id=\(.session_id // "")"
' <<< "$input")"

cwd="${raw_cwd/#"$HOME"/\~}"

branch=""
if [[ -n "$raw_cwd" ]] && command -v git &>/dev/null; then
  branch=$(git -C "$raw_cwd" branch --show-current 2>/dev/null)
fi

# Build progress bar (25 segments)
filled=$((used * 25 / 100))
empty=$((25 - filled))
bar="${C_BAR_FILL}"
for ((i = 0; i < filled; i++)); do bar+="█"; done
bar+="${C_BAR_EMPTY}"
for ((i = 0; i < empty; i++)); do bar+="░"; done
bar+="${C_RESET}"

# Line 1: model, cwd, branch
line1=""
[[ -n "$model" ]] && line1+="${C_MODEL}${model}${C_RESET}"
[[ -n "$cwd" ]] && line1+=" ${C_DIR}${cwd}${C_RESET}"
[[ -n "$branch" ]] && line1+=" ${C_BRANCH} ${branch}${C_RESET}"

# Line 2: usage
line2="${bar} ${C_VALUE}${used}% used (${remaining}% remaining)${C_RESET}"

# Line 3: session id
line3=""
[[ -n "$session_id" ]] && line3="${C_LABEL}Session: ${session_id}${C_RESET}"

echo -e "$line1"
echo -e "$line2"
[[ -n "$line3" ]] && echo -e "$line3"
