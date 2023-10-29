#! /bin/bash
DOTS_DIR=$HOME/code/dots
CONF_DIR=$HOME/.config

DOTS_FOR_CONF_DIR=(
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

DOTS_FOR_HOME_DIR=(
  ".zsh"
  ".zshrc"
)

for dot in "${DOTS_FOR_CONF_DIR[@]}";do
	rm -rf "${CONF_DIR}/${dot}"
	ln -sf "${DOTS_DIR}/${dot}" "${CONF_DIR}/${dot}"
done

for dot in "${DOTS_FOR_HOME_DIR[@]}";do
	rm -rf "${HOME}/${dot}"
	ln -sf "${DOTS_DIR}/${dot}" "${HOME}/${dot}"
done

