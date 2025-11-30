#!/bin/bash

# Media Control Script for YouTube Music PWA
# Usage: ./media-control.sh [playpause|next|prev]

COMMAND=$1

case $COMMAND in
  playpause)
    osascript -e 'tell application "Google Chrome"
      repeat with w in windows
        repeat with t in tabs of w
          if URL of t contains "music.youtube.com" then
            execute t javascript "document.querySelector(\"#play-pause-button\").click()"
            return
          end if
        end repeat
      end repeat
    end tell'
    ;;
  next)
    osascript -e 'tell application "Google Chrome"
      repeat with w in windows
        repeat with t in tabs of w
          if URL of t contains "music.youtube.com" then
            execute t javascript "document.querySelector(\".next-button\").click()"
            return
          end if
        end repeat
      end repeat
    end tell'
    ;;
  prev)
    osascript -e 'tell application "Google Chrome"
      repeat with w in windows
        repeat with t in tabs of w
          if URL of t contains "music.youtube.com" then
            execute t javascript "document.querySelector(\".previous-button\").click()"
            return
          end if
        end repeat
      end repeat
    end tell'
    ;;
  *)
    echo "Usage: $0 [playpause|next|prev]"
    exit 1
    ;;
esac
