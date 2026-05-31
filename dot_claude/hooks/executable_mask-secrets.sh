#!/usr/bin/env bash
set -euo pipefail

resp=$(jq -c '.tool_response')

while IFS= read -r path; do
  masked=$(jq -r --argjson p "$path" 'getpath($p)' <<<"$resp" | gat --theme=noop --mask-secrets)
  resp=$(jq -c --argjson p "$path" --arg v "$masked" 'setpath($p; $v)' <<<"$resp")
done < <(jq -c '(select(type=="string")|[]), paths(type=="string")' <<<"$resp")

jq -nc --argjson out "$resp" \
  '{hookSpecificOutput: {hookEventName: "PostToolUse", updatedToolOutput: $out}}'
