#!/bin/bash
# Watchdog for `claude --remote`
# Usage: ./claude-remote-watchdog.sh [working-directory]
# Restarts the process on exit and logs all events with timestamps.

WORK_DIR="${1:-$PWD}"
LOG_FILE="${HOME}/logs/claude-remote.log"
RESTART_DELAY=5

mkdir -p "$(dirname "$LOG_FILE")"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

if [ ! -d "$WORK_DIR" ]; then
    echo "Directory not found: $WORK_DIR"
    exit 1
fi

cd "$WORK_DIR" || exit 1
log "=== Watchdog started (PID $$, dir=$WORK_DIR) ==="

trap 'log "=== Watchdog stopped ==="; exit 0' SIGINT SIGTERM

ATTEMPT=0
while true; do
    ATTEMPT=$((ATTEMPT + 1))
    log "--- Attempt #${ATTEMPT}: starting claude --remote ---"

    claude --remote >> "$LOG_FILE" 2>&1
    EXIT_CODE=$?

    log "--- Process exited (code=${EXIT_CODE}), restarting in ${RESTART_DELAY}s ---"
    sleep "$RESTART_DELAY"
done
