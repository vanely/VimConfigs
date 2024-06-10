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
      echo "---------------------------------------------"
    elif [[ "${OSTYPE}" == "msys" ]]; then
      # install for windows(Git Bash)
      powershell scoop_install.ps1
      source ~/.bashrc
      scoop install ripgrep
      echo "---------------------------------------------"
      echo "Usupported operating system."
    fi
  fi
}


install_ack-grep() {
  if [[ -n "$(which ripgrep)" ]]; then
    echo "ack-grep is already installed on this machine."
    echo "---------------------------------------------"
    echo
  else
    echo "Installing ack-grep"
    echo "---------------------------------------------"
    echo
    if [[ "${OSTYPE}" == "linux-gnu" ]]; then
      # install for linux(ubuntu/debian)
      sudo apt update -y
      sudo apt install ack-grep -y
      echo "---------------------------------------------"
      echo
    elif [[ "${OSTYPE}" == "darwin" ]]; then
      # install for mac
      brew install ack
      echo "---------------------------------------------"
    elif [[ "${OSTYPE}" == "msys" ]]; then
      # install for windows(Git Bash)
      scoop install ack
      echo "---------------------------------------------"
    else
      echo "Usupported operating system."
    fi
  fi
}
