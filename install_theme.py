import os
import subprocess
import urllib.request

def run_command(cmd):
    try:
        subprocess.run(cmd, shell=True, check=True)
        print(f"✅ Executed: {cmd}")
    except subprocess.CalledProcessError:
        print(f"⚠️ Failed (Safe to ignore if already done): {cmd}")

print("🌹 Installing Rosé Pine Aesthetic...")

# 1. Install VS Code Extension (Rosé Pine)
print("\n--- VS Code / VSCodium ---")
# Try standard 'code' (VS Code) and 'codium' (VSCodium)
run_command("code --install-extension mvllow.rose-pine")
run_command("codium --install-extension mvllow.rose-pine")
run_command("code --install-extension PKief.material-icon-theme") # Icons match the aesthetic
run_command("codium --install-extension PKief.material-icon-theme")

# 2. Install iTerm2 Color Schemes
print("\n--- iTerm2 ---")
repo_root = os.path.dirname(os.path.abspath(__file__))
themes_dir = os.path.join(repo_root, "assets", "themes")

# Find all .itermcolors files
theme_files = [f for f in os.listdir(themes_dir) if f.endswith(".itermcolors")]

if theme_files:
    print(f"Found {len(theme_files)} theme files in {themes_dir}")
    for theme_file in theme_files:
        full_path = os.path.join(themes_dir, theme_file)
        try:
            run_command(f"open '{full_path}'")
            print(f"🎨 Imported: {theme_file}")
        except Exception as e:
            print(f"❌ Failed to import {theme_file}: {e}")
    print("\nSelect your preferred variant (Main, Moon, or Dawn) in iTerm > Settings > Profiles > Colors.")
else:
    print(f"⚠️ No .itermcolors files found in: {themes_dir}")

print("\n--- Antigravity (Manual Step) ---")
print("1. Open Antigravity.")
print("2. Press Cmd+Shift+X to open Extensions.")
print("3. Search for 'Rose Pine'.")
print("4. Click Install on the one by 'mvllow'.")
print("5. Press Cmd+K, Cmd+T and select 'Rosé Pine'.")

print("\n✨ Aesthetic Setup Complete!")
