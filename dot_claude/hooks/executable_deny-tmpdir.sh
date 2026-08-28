#!/usr/bin/env bash
set -euo pipefail

# Fails open: a malformed payload should not turn every tool call into a hook error.
target=$(jq -r '[.tool_input.command, .tool_input.file_path, .tool_input.notebook_path]
  | map(select(. != null)) | join("\n")' 2>/dev/null || true)

# Stripping quotes catches "$TMPDIR"/name and '$TMPDIR'/name too.
normalized=${target//\"/}
normalized=${normalized//\'/}

# The accident is a stable shared path: two sessions that each evaluate
# $TMPDIR/name reach the same file, and one reads what the other wrote. A
# generator that mints a fresh name per call cannot collide that way, so
# mktemp is left alone. The trailing slash means a path is being built, so a
# bare mention like `grep -rn TMPDIR .` passes. Splitting the variable from the
# slash — `cd "$TMPDIR"`, or assigning it and using the copy — slips through;
# catching that needs a bare TMPDIR match, which denies far too much.
case "$normalized" in
*'$TMPDIR/'* | *'${TMPDIR}/'* | *'${TMPDIR:'*'}/'*)
  jq -nc '{
    hookSpecificOutput: {
      hookEventName: "PreToolUse",
      permissionDecision: "deny",
      permissionDecisionReason: "TMPDIR is banned by CLAUDE.md. Put temp files under the session scratchpad directory given in your environment."
    }
  }'
  exit 2
  ;;
esac
