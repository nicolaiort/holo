# reload hyprland
hyprctl reload

# start waybar if not started
if ! pgrep -x "waybar" > /dev/null; then
	waybar &
else
	killall waybar
	waybar &
fi

# update chezmoi
chezmoi update