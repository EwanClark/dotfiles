#!/bin/bash

# Sinks to exclude
EXCLUDE_NAMES=(
  "alsa_output.pci-0000_01_00.1.hdmi-stereo"
  "alsa_output.pci-0000_00_1f.3.iec958-stereo"
)

# Friendly names for sinks
declare -A FRIENDLY_NAMES=(
  ["alsa_output.usb-SteelSeries_Arctis_Nova_4X-00.analog-stereo"]="Headphones"
  ["alsa_output.pci-0000_03_00.0.analog-stereo"]="Speakers"
  ["bluez_output.98_47_44_BD_06_54.1"]="Earbuds"
)

# Get current default sink
CURRENT_SINK=$(pactl get-default-sink)

# Get all available sinks
mapfile -t ALL_SINKS < <(pactl list short sinks | awk '{print $2}')

# Filter out excluded sinks
VALID_SINKS=()
for sink in "${ALL_SINKS[@]}"; do
  exclude=false
  for excluded in "${EXCLUDE_NAMES[@]}"; do
    if [[ "$sink" == "$excluded" ]]; then
      exclude=true
      break
    fi
  done
  [[ "$exclude" == false ]] && VALID_SINKS+=("$sink")
done

# Exit if no valid sinks
if [[ ${#VALID_SINKS[@]} -eq 0 ]]; then
  echo "No valid sinks found"
  exit 1
fi

# Find current sink index in valid sinks array
CURRENT_INDEX=-1
for i in "${!VALID_SINKS[@]}"; do
  if [[ "${VALID_SINKS[$i]}" == "$CURRENT_SINK" ]]; then
    CURRENT_INDEX=$i
    break
  fi
done

# Calculate next sink index (wrap around)
if [[ $CURRENT_INDEX -eq -1 ]]; then
  NEXT_INDEX=0
else
  NEXT_INDEX=$(( (CURRENT_INDEX + 1) % ${#VALID_SINKS[@]} ))
fi

NEXT_SINK="${VALID_SINKS[$NEXT_INDEX]}"

# Set the new default sink
pactl set-default-sink "$NEXT_SINK"

# Move all currently playing streams to the new sink
pactl list short sink-inputs | awk '{print $1}' | while read -r stream; do
  pactl move-sink-input "$stream" "$NEXT_SINK" 2>/dev/null
done

# Get friendly name from our list, or fall back to sink name
DISPLAY_NAME="${FRIENDLY_NAMES[$NEXT_SINK]:-$NEXT_SINK}"

echo "Switched to: $DISPLAY_NAME"

# Optional: Send desktop notification if notify-send is available
if command -v notify-send &> /dev/null; then
  notify-send --app-name="Output Switcher" "Audio Output" "Switched to: $DISPLAY_NAME"

fi