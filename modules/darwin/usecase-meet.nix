{ pkgs, userSettings, ... }: {

  # 1. Install the Chat Apps
  homebrew.casks = [
    "slack"
    "zoom"
    "signal"
    "microsoft-teams"
    "discord"
    # Add "whatsapp" or "telegram" here if you use them!
  ];

  # 2. Group them on the Dock
  system.activationScripts.createChatGroup.text = ''
    echo "Grouping Chat Apps..."
    echo "Grouping Chat Apps..."
    CHAT_FOLDER="/Users/${userSettings.username}/Applications/Messaging"
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
    ln -sf "/Users/${userSettings.username}/Applications/Chrome Apps.localized/Google Chat.app" "$CHAT_FOLDER/" || true
    chown -R ${userSettings.username}:staff "$CHAT_FOLDER"
  '';

  system.activationScripts.addChatStack.text = ''
    # Only run if dockutil is installed
    if command -v dockutil >/dev/null; then
      # Check if the stack is already there
      if ! dockutil --find "Messaging" >/dev/null; then
        echo "Pinning Messaging Stack to Dock..."
        # --view grid: Shows icons in a grid
        # --display stack: Shows a stack of icons when closed
        dockutil --add "/Users/${userSettings.username}/Applications/Messaging" --view grid --display stack --sort name --folder --no-restart
        killall Dock
      fi
    fi
  '';
}