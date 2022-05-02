#!/bin/bash

# This files sourced from my bashrc

# Simple options
BORDER='rounded'
PREVIEW_WIDTH='65%'

alias fzf="fzf --border=${BORDER} --preview-window=right:${PREVIEW_WIDTH} --preview 'cat {}'"
