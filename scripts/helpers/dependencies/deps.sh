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
    if [[ "${OSTYPE}" == "linux-gnu" ]]; then
      # install for linux(ubuntu/debian)
      sudo apt update -y
      sudo apt install ripgrep -y
      echo "---------------------------------------------"
      echo
    elif [[ "${OSTYPE}" == "darwin" ]]; then
      # install for mac
      brew install ripgrep
    elif [[ "${OSTYPE}" == "msys" ]]; then
      # install for windows(Git Bash)
      powershell scoop_install.ps1
      source ~/.bashrc
      scoop install ripgrep
    else
      echo "Usupported operating system."
    fi
  fi
}
