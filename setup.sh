#!/bin/bash

# Install Geist Mono font
FONT_DIR="${HOME}/.local/share/fonts"

mkdir -p "$FONT_DIR"
curl -LO 'https://github.com/ryanoasis/nerd-fonts/releases/latest/download/GeistMono.zip' "$FONT_DIR"
unzip "${FONT_DIR}/GeistMono.zip"
rm "${FONT_DIR}/LICENSE" "${FONT_DIR}/README.md"
