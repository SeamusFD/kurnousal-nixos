HYPR_CONFIG="/etc/nixos/kurnousal-nixos/home-manager/hyprland/conf/"
ACTIVEWINDOW=$(hyprctl activewindow -j | jq -r ".class")

REGEX_LINE=$(grep -n $ACTIVEWINDOW $HYPR_CONFIG/window_rules.conf | cut -d : -f 1)

if [ -n "$REGEX_LINE" ]; then
	sed -i "${REGEX_LINE}s|\([^0-9]*\)\([^a-z]*\)\([^0-9]*\)\([.0-9]*\)\([^0-9]*\)\([.0-9]*\)|\1\2\3\6\5\4|" $HYPR_CONFIG/window_rules.conf
else
	sed -i "6 i windowrulev2 = opacity 1.0,class:${ACTIVEWINDOW} #!0.9" $HYPR_CONFIG/window_rules.conf
fi
