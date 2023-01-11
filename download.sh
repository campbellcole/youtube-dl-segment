#!/usr/bin/env bash

showusage() (
  echo "This script allows you to download part of a youtube video."
  echo "Usage: $0 [-h] <youtube url> <start time> <duration> <output file>"
  echo "  -h Show this help message"
  echo
  echo "<start time> and <duration> must obey the following format:"
  echo "MM:SS (ex. 15:00, 00:00, 160:32)"
  echo "IMPORTANT: set the <start time> to 30 seconds BEFORE you"
  echo "want your snippet to start. This is to ensure an key frame"
  echo "is grabbed. The 30 seconds will be trimmed off automatically"
  echo
  echo "<output file> can have any extension supported by ffmpeg"
)

if [[ "$1" = "-h" ]]; then
  showusage
else
  YT_URL="$1"
  START_TIME="$2"
  DURATION="$3"
  OUT_FILE="$4"

  if [[ "$YT_URL" = "" ]] || [[ "$START_TIME" = "" ]] || [[ "$DURATION" = "" ]] || [[ "$OUT_FILE" = "" ]]; then
    echo "Wrong number of arguments!"
    showusage
    exit 1
  fi

  OUTPUT="$(youtube-dl --youtube-skip-dash-manifest -g "$YT_URL" 2>/dev/null)"

  readarray -t URLS <<< "$OUTPUT"

  VIDEO_URL="${URLS[0]}"
  AUDIO_URL="${URLS[1]}"

  echo "URLs grabbed. Starting ffmpeg..."

  echo "original url = $YT_URL"
  echo "start time = $START_TIME"
  echo "duration = $DURATION"
  echo "output file = $OUT_FILE (if this file exists it will be overwritten)"

  ffmpeg -ss "$START_TIME" -i "$VIDEO_URL" -ss "$START_TIME" -i "$AUDIO_URL" -map 0:v -map 1:a -ss 30 -t "$DURATION" -c:v libx264 -c:a aac "$OUT_FILE" -y
fi
