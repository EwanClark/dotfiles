#!/usr/bin/env bash

TARGET="www.globalplayer.com"
FOUND_PLAYER=""

# Loop through all players
for p in $(playerctl --list-all); do
  ARTIST=$(playerctl -p "$p" metadata xesam:artist 2>/dev/null)

  if [[ "$ARTIST" == *"$TARGET"* ]]; then
    FOUND_PLAYER="$p"
    break
  fi
done

# If a matching player was found, toggle it
if [[ -n "$FOUND_PLAYER" ]]; then
  playerctl -p "$FOUND_PLAYER" play-pause
else
  # Fall back to Spotify
  playerctl -p spotify play-pause
fi
