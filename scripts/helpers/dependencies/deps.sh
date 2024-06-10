#!/usr/bin/bash

install_ripgrep() {
  if [[ -n "$(which ripgrep)" ]]; then
    echo "ripgrep is already installed on this machine."
    echo "---------------------------------------------"
    echo
  else
    echo "Installing ripgrep."
    echo "---------------------------------------------"
    echo
    sudo apt update -y
    sudo apt install ripgrep -y
    echo "---------------------------------------------"
    echo
  fi
}
