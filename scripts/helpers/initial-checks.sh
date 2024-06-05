#!/usr/bin/bash

install_homebrew() {
  echo "Preparing to install brew package manager"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
}

generate_random_char() {
  tr -dc 'a-zA-Z0-9' </dev/urandom | head -c 1
}

install_vim() {
  # Detect operating system
  if [[ "${OSTYPE}" == "linux-gnu" ]]; then
    # Linux(ubuntu/debian)
    if command -v apt-get >/dev/null 2>&1; then
      sudo apt-get update
      sudo apt-get install -y vim
    else
      echo "Unsuported Linux distribution. Please install vim manually."
    fi
  elif [[ "${OSTYPE}" == "darwin" ]]; then
    # macOS
    if command -v brew >/dev/null 2>&1; then
      brew update
      brew install vim
    else
      install_homebrew
      brew update
      brew install vim
    fi
  elif [[ "${OSTYPE}" == "msys" ]]; then
    # Windows(Git Bash/MSYS2)
    curl -fLo ./vim_install.exe  https://github.com/vim/vim-win32-installer/releases/download/v9.1.0/gvim_9.1.0_x64_signed.exe
    powershell ./vim_install.exe
  else
    echo "Unsupported operating system. Please install vim manually."
  fi
}

create_vim_directories() {
  VIM_DIR="${HOME}/.vim"

  DIRS=("autoload" "backup" "colors" "plugged")
  if [[ ! -d "${VIM_DIR}" ]]; then
    echo "Creating ${VIM_DIR} directory."
    mkdir "${VIM_DIR}"
  fi

  for dir in "${DIRS[@]}"; do
    if [[ ! -d "${VIM_DIR}/${dir}" ]]; then
      echo "Creating ${VIM_DIR} directory."
      mkdir "${VIM_DIR}/${dir}"
    else
      echo "${VIM_DIR}/${dir} already exists."
    fi
  done
}

copy_config_to_home() {
  CURRENT_DIR="$(pwd)"
  NEW_VIMRC_PATH="../configs/personal/.vimrc"

  # Check if .vimrc already exists in home directory, to make way for the new one.
  if [[ -f "${HOME}/.vimrc" ]]; then
    RANDOM_CHAR="$(generate_random_char)"

    # Rename the existing .vimrc ile
    echo "Renaming existing .vimrc to .vimrc_${RANDOM_CHAR}"
    mv "${HOME}/.vimrc" "${HOME}/.vimrc_${RANDOM_CHAR}"
  fi

  # Copy new .vimrc to home directory
  if [[ -f "${CURRENT_DIR}/${NEW_VIMRC_PATH}" ]]; then
    cp "${CURRENT_DIR}/${NEW_VIMRC_PATH}" "${HOME}/.vimrc"
    echo "Copied new .vimrc to ${HOME}"
  else
    echo "The file ${CURRENT_DIR}/${NEW_VIMRC_PATH} does not exist."
  fi
}

install_vim_plug() {
  VIM_PLUG_PATH="${HOME}/.vim/autoload/plug.vim"
  VIM_PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

  if [[ -f "${VIM_PLUG_PATH}" ]]; then
    echo "vim-plug is already installed"
  else
    echo "installing vim-plug..."

    # Check if either curl or wget are installed and use to install vim-plug
    if command -v curl >/dev/null 2>&1; then
      curl -fLo "${VIM_PLUG_PATH}" --create-dirs "${VIM_PLUG_URL}"
    elif command -v wget >/dev/null 2>&1; then
      wget -O "${VIM_PLUG_PATH}" "${VIM_PLUG_URL}"
    else
      echo "Neither curl, nor wget is installed please install one of the utilities to continue."
      exit 1
    fi
    echo "vim-plug installed successfully."
  fi
}

install_prefered_themes() {
  # -------------------------------------------------------------------------------
  # Add gruvbox theme to vim

  # Checking if Gitbash supports 256 color when running on windows
  if [[ "${OSTYPE}" == "msys" ]]; then
  CURRENT_COLOR_RANGE="$(tput colors)"
    if [[ "${CURRENT_COLOR_RANGE}" == "256" ]]; then
      echo "Windows Git Bash already supporting 256 colors."
    else
      if [[ -f ~/.bashrc ]] && [[ -f ~/.profile ]] ; then
      echo export TERM=xterm-256color >> ~/.profile
      echo source ~/.profile >> ~/.bashrc
      elif [[ -f ~/.bashrc ]] && [[ ! -f ~/.profile ]]; then
        touch ~/.profile
        echo export TERM=xterm-256color >> ~/.profile
        echo source ~/.profile >> ~/.bashrc
      elif [[ ! -f ~/.bashrc ]] && [[ -f ~/.profile ]]; then
        touch ~/.bashrc
        touch ~/.profile
        echo export TERM=xterm-256color >> ~/.profile
        echo source ~/.profile >> ~/.bashrc
      fi
    fi
  fi
  GRUVBOX_REPO_URL="https://github.com/morhetz/gruvbox.git"
  THEMES_DIR="${HOME}/vim-themes"
  GRUVBOX_COLORS_DIR="${THEMES_DIR}/gruvbox/colors"
  TARGET_COLORS_DIR="${HOME}/.vim/colors"
  GRUVBOX_VIM_FILE="${GRUVBOX_COLORS_DIR}/gruvbox.vim"

  # Clone gruvbox repo if the dir doesn't exist
  if [[ ! -d "${THEMES_DIR}/gruvbox" ]]; then
    echo "Cloning gruvbox repository..."
    mkdir -p "${THEMES_DIR}"
    git clone "${GRUVBOX_REPO_URL}" "${THEMES_DIR}/gruvbox"
  else
   echo "Gruvbox repository already exists."
  fi

  if [[ -f "${GRUVBOX_VIM_FILE}" ]]; then
    echo "Copying gruvbox.vim to ~/.vim/colors/..."
    cp "${GRUVBOX_VIM_FILE}" "${TARGET_COLORS_DIR}"
    echo "gruvbox.vim installed successfully."
  else
    echo "The file ${GRUVBOX_VIM_FILE} does not exist. Please check the repository."
    exit 1
  fi

  # -------------------------------------------------------------------------------
}
