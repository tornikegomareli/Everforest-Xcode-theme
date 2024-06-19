#!/bin/bash

# Set variables
FONTS_FOLDER=~/Library/Fonts
FONT_NAME="Iosevka-Term.ttf"
FONT_ZIP_URL="https://github.com/adobe-fonts/source-code-pro/archive/2.030R-ro/1.050R-it.zip"
FONT_ZIP_FILE="IosevkaTerm.zip"
FONT_FOLDER="IosevkaTerm"
THEME_FILES=("Everforest_Dark.xccolortheme" "Everforest_Light.xccolortheme")
THEME_SOURCE_PATH=$(dirname "$0")/../
XCODE_THEMES_FOLDER=~/Library/Developer/Xcode/UserData/FontAndColorThemes

# Ensure the fonts folder exists
mkdir -p "$FONTS_FOLDER"

# Download and install the Iosevka-Term font if not already installed
if [ ! -f "$FONTS_FOLDER/$FONT_NAME" ]; then
	echo "🅰️  Downloading Iosevka-Term font..."

	curl -L "$FONT_ZIP_URL" -o "$FONTS_FOLDER/$FONT_ZIP_FILE"

	echo "Installing Iosevka-Term font..."
	unzip "$FONTS_FOLDER/$FONT_ZIP_FILE" -d "$FONTS_FOLDER/$FONT_FOLDER"

	TTF_FOLDER=$(find "$FONTS_FOLDER/$FONT_FOLDER" -type d -name "TTF")
	mv "$TTF_FOLDER"/*.ttf "$FONTS_FOLDER/"

	rm -rf "$FONTS_FOLDER/$FONT_FOLDER"
	rm "$FONTS_FOLDER/$FONT_ZIP_FILE"
fi

# Ensure the Xcode themes folder exists
mkdir -p "$XCODE_THEMES_FOLDER"

# Copy the theme files to the Xcode themes folder
for THEME_FILE in "${THEME_FILES[@]}"; do
	THEME_SOURCE_FILE="$THEME_FILE"
	if [ -f "$THEME_SOURCE_FILE" ]; then
		cp "$THEME_SOURCE_FILE" "$XCODE_THEMES_FOLDER/$THEME_FILE"
		echo "🎨  Installing Xcode theme: $THEME_FILE..."
	else
		echo "❌  Theme file not found: $THEME_SOURCE_FILE"
	fi
done

echo ""
echo "🎉 EverForest Themes successfully installed"
echo "👍 Select them in Xcode's preferences to start using them (you may have to restart Xcode first)"
