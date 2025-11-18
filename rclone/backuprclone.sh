#!/bin/bash
rclone sync "/home/ewan/Documents/" "gdrive:Documents/" --copy-links --progress --fast-list --update --create-empty-src-dirs --log-level=NOTICE --log-file=/home/ewan/.config/rclone/logsrclone.txt --exclude-from /home/ewan/.config/rclone/excluderclone.txt

# ------------------------------------------------------------------------------
# rclone sync: Mirror the local folder to the remote, removing deleted files.
# ------------------------------------------------------------------------------
# Syncs /home/ewan/Documents → gdrive:Documents so that Drive matches local files.
#
#   --copy-links            Copy target file's contents using the links metadata
#   --progress              Show live progress output during transfer
#   --fast-list             Load full remote file tree in one request (faster)
#   --update                Skip files that are newer on Google Drive
#   --create-empty-src-dirs Keep empty folders (Drive normally ignores them)
#   --log-level=NOTICE      Log important and useful infomation for debuging
#   --log-file=...          Write logs to a text file for debuging
#   --exclude-from=...      Skip files/folders listed in excluderclone.txt
# ------------------------------------------------------------------------------
