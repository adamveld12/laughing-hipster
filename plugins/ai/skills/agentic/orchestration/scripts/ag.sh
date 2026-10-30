#!/usr/bin/env bash
# Helpers for tmux agent teams. Source this file: `source ag.sh`. Uses the default tmux server.
# Ids: <project>/<role><n>  (e.g. checkout/wk1).  Remote: <host>:<project>/<role><n>.

AG_MAX_HOPS=${AG_MAX_HOPS:-5}
AG_INBOX=${AG_INBOX:-/tmp/agents}

ag_find() {   # ag_find <agent_id> -> pane id (empty if none)
  tmux list-panes -a -F '#{pane_id} #{@agent_id}' | awk -v id="$1" '$2==id{print $1}'
}

ag_whoami() { tmux display -p -t "${TMUX_PANE:?not in tmux}" '#{@agent_id}'; }

ag_list() {   # ag_list [project]
  tmux list-panes -a -F '#{pane_id} #{@agent_id} #{session_name}:#{window_index} #{window_name}' |
    awk -v p="${1:-}" '$2!="" && (p=="" || $2 ~ "^"p"/")'
}

ag_spawn() {  # ag_spawn <project> <role-n> <window-title> <dir> <tool> [args...] -> pane id
  local proj=$1 role=$2 title=$3 dir=$4 tool=$5; shift 4
  local id="$proj/$role" sess="ag-$proj"
  [[ -n $(ag_find "$id") ]] && { echo "id taken: $id" >&2; return 1; }
  tmux has-session -t "=$sess" 2>/dev/null || tmux new-session -d -s "$sess" -n orch -c "$dir"
  local pane; pane=$(tmux new-window -d -P -F '#{pane_id}' -t "=$sess:" -n "$title" -c "$dir")
  tmux set -p -t "$pane" @agent_id "$id"
  tmux set -p -t "$pane" @agent_role "${role%%[0-9]*}"
  tmux set -p -t "$pane" @agent_project "$proj"
  tmux set -p -t "$pane" @agent_tool "$tool"
  tmux send-keys -t "$pane" -l -- "$*"; tmux send-keys -t "$pane" Enter
  echo "$pane"
}

ag_send() {   # ag_send <to_id> <message> [hops_so_far]   (wraps message in the envelope)
  local to=$1 msg=$2 hops=$(( ${3:-0} + 1 )) pane me my_pane
  (( hops <= AG_MAX_HOPS )) || { echo "hop limit ($AG_MAX_HOPS) reached; dropping" >&2; return 1; }
  pane=$(ag_find "$to"); [[ -n $pane ]] || { echo "no pane for $to" >&2; return 1; }
  [[ $pane != "${TMUX_PANE:-}" ]] || { echo "refusing to send to own pane" >&2; return 1; }
  me=$(ag_whoami 2>/dev/null); my_pane=${TMUX_PANE:-none}
  tmux load-buffer -b ag - <<<"[from=${me:-human} pane=$my_pane ts=$(date -u +%FT%TZ) hops=$hops | reply: ag_send ${me:-?} \"<text>\" $hops]
$msg"
  tmux paste-buffer -p -b ag -d -t "$pane"; sleep 0.3; tmux send-keys -t "$pane" Enter
}

ag_read() {   # ag_read <agent_id> [lines]
  local p; p=$(ag_find "$1"); [[ -n $p ]] || { echo "no pane for $1" >&2; return 1; }
  tmux capture-pane -p -J -t "$p" -S "-${2:-80}"
}

ag_kill() { local p; p=$(ag_find "$1"); [[ -n $p ]] && tmux kill-window -t "$p"; }

ag_register() {  # ag_register <project> <role-n> <tool>   tag the current pane (e.g. the orchestrator)
  local id="$1/$2"
  [[ -z $(ag_find "$id") ]] || { echo "id taken: $id" >&2; return 1; }
  tmux set -p -t "${TMUX_PANE:?not in tmux}" @agent_id "$id"
  tmux set -p -t "$TMUX_PANE" @agent_role "${2%%[0-9]*}"
  tmux set -p -t "$TMUX_PANE" @agent_project "$1"
  tmux set -p -t "$TMUX_PANE" @agent_tool "$3"
}
