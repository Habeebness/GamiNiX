#!/bin/bash

# Kitty config installer
echo "Installing kitty config..."
mkdir -p ~/.config/kitty/
cp apps/configs/kitty.conf ~/.config/kitty/kitty.conf

# Flameshot config installer
echo "Installing flameshot config..."
mkdir -p ~/.config/flameshot/
cp apps/configs/flameshot.ini ~/.config/flameshot/flameshot.ini

# Mangohud config installer
echo "Installing mangohud config..."
mkdir -p ~/.config/MangoHud/
cp apps/configs/MangoHud.conf ~/.config/MangoHud/MangoHud.conf

# Sunshine config installer
echo "Installing sunshine config..."
mkdir -p ~/.config/sunshine/
cp apps/configs/sunshine.conf ~/.config/sunshine/sunshine.conf
