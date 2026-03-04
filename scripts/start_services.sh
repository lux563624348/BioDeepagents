#!/usr/bin/env sh
set -e

DEEPAGENTS_BIN="/workspace/cli/.venv/bin/deepagents"
LOG_DIR="/workspace/logs"

mkdir -p "$LOG_DIR"

exec "$DEEPAGENTS_BIN"
