{ pkgs, ... }: {

  # 1. Install the Chat Apps
  homebrew.casks = [
    "slack"
    "zoom"
    "signal"
    "microsoft-teams"
    "discord"
    "google-chat"
    # Add "whatsapp" or "telegram" here if you use them!
  ];

  # 2. Group them on the Dock
  system.activationScripts.createChatGroup.text = ''
    echo "Grouping Chat Apps..."
    CHAT_FOLDER="$HOME/Applications/Messaging"
    mkdir -p "$CHAT_FOLDER"
    
    # Clear old links to keep it fresh
    rm -f "$CHAT_FOLDER"/*.app

    # Create shortcuts (Symbolic Links)
    # We use '|| true' so it doesn't break if an app isn't installed yet
    ln -sf "/Applications/Slack.app" "$CHAT_FOLDER/" || true
    ln -sf "/Applications/zoom.us.app" "$CHAT_FOLDER/" || true
    ln -sf "/Applications/Signal.app" "$CHAT_FOLDER/" || true
    ln -sf "/Applications/Microsoft Teams.app" "$CHAT_FOLDER/" || true
    ln -sf "/Applications/Discord.app" "$CHAT_FOLDER/" || true
    ln -sf "/Applications/Google Chat.app" "$CHAT_FOLDER/" || true
  '';

  system.activationScripts.addChatStack.text = ''
    # Only run if dockutil is installed
    if command -v dockutil >/dev/null; then
      # Check if the stack is already there
      if ! dockutil --find "Messaging" >/dev/null; then
        echo "Pinning Messaging Stack to Dock..."
        # --view grid: Shows icons in a grid
        # --display stack: Shows a stack of icons when closed
        dockutil --add "$HOME/Applications/Messaging" --view grid --display stack --sort name --folder --no-restart
        killall Dock
      fi
    fi
  '';
}