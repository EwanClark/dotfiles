#!/bin/bash

LOCKFILE="/home/ewan/.config/rclone/bisync.lock"
WORKDIR="/home/ewan/.config/rclone/bisync"
LOGFILE="/home/ewan/.config/rclone/logs.txt"
EXCLUDEFILE="/home/ewan/.config/rclone/exclude.txt"

# Prevent overlapping runs
exec 9>"$LOCKFILE"
flock -n 9 || exit 0

rclone bisync "/home/ewan/Documents/" "gdrive:Documents/" \
  --workdir "$WORKDIR" \
  --copy-links \
  --progress \
  --fast-list \
  --create-empty-src-dirs \
  --log-level=NOTICE \
  --log-file="$LOGFILE" \
  --exclude-from "$EXCLUDEFILE"

# ------------------------------------------------------------------------------
# rclone bisync: Two-way sync between local and remote, tracking changes on both.
# ------------------------------------------------------------------------------
# Syncs /home/ewan/Documents ↔ gdrive:Documents so both sides stay in sync.
# Uses a lock file to prevent overlapping runs (important for timers).
#
#   --workdir=...           Where bisync stores its state/metadata (required)
#   --copy-links            Copy symlink TARGET contents (follow symlinks)
#   --progress              Show live progress output during transfer
#   --fast-list             Load full remote file tree in one request (faster)
#   --create-empty-src-dirs Keep empty folders (Drive normally ignores them)
#   --log-level=NOTICE      Log important and useful information for debugging
#   --log-file=...          Write logs to a text file for debugging
#   --exclude-from=...      Skip files/folders listed in excluderclone.txt
#
# Locking:
#   flock + bisync.lock     Prevents overlapping runs (avoids bisync state corruption)
# ------------------------------------------------------------------------------