#!/usr/bin/env bash
set -e

# cd to your config dir
pushd /etc/nixos/kurnousal-nixos

# Autoformat your nix files
# alejandra . &>/dev/null ||
# 	(
# 		alejandra .
# 		echo "formatting failed!" && exit 1
# 	)

# Ensure all changes are staged
git add .

# Early return if no changes were detected (thanks @singiamtel!)
if git diff --quiet --staged; then
	echo "No changes detected, exiting."
	popd
	exit 0
fi

# Shows your changes
git diff -U0

echo "Starting Nix Helper command line..."

# Rebuild, output simplified errors, log trackebacks
nh os switch --update | tee -a "$(tty)" &>nixos-switch.log

# Get current generation metadata
current=$(nixos-rebuild list-generations | grep current)

# Commit all changes witih the generation metadata
git commit -am "$current"

# Back to where you were
popd

# Notify all OK!
notify-send -e "NixOS Rebuilt Successfully!" --icon=software-update-available
