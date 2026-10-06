#!/bin/sh
tab=$("$HERDR_BIN_PATH" tab list --workspace "$HERDR_ACTIVE_WORKSPACE_ID" \
  | jq -r --arg cur "$HERDR_ACTIVE_TAB_ID" '.result.tabs[] | select(.tab_id != $cur) | "\(.tab_id)\t\(.number): \(.label)"' \
  | fzf --delimiter='\t' --with-nth=2.. | cut -f1)
[ -n "$tab" ] && "$HERDR_BIN_PATH" pane move "$HERDR_ACTIVE_PANE_ID" --tab "$tab" --split right --focus
