#! /bin/bash
DOTS_DIR=$HOME/code/dots
CONF_DIR=$HOME/.config

CONF_DIR_DOTS=(
	"nvim"
	"wezterm"
  "tmux"
  "betterlockscreen"
  "wallpapers"
  "bspwm"
  "polybar"
  "dunst"
  "rofi"
  "sxhkd"
)

HOME_DIR_DOTS=(
  ".zsh"
  ".zshrc"
  ".ideavimrc"
)

for dot in "${CONF_DIR_DOTS[@]}";do
	rm -rf "${CONF_DIR}/${dot}"
	ln -sf "${DOTS_DIR}/${dot}" "${CONF_DIR}/${dot}"
done

for dot in "${HOME_DIR_DOTS[@]}";do
	rm -rf "${HOME}/${dot}"
	ln -sf "${DOTS_DIR}/${dot}" "${HOME}/${dot}"
done

