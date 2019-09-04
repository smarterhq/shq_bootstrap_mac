#!/bin/bash

export HOMEBREW_FORCE_BOTTLE=1
export ACCEPT_EULA=y

## Bootstrap Xcode Command Line Tools First

if xcode-select --install 2>&1 | grep installed; then
  echo "Bootstrap : Skipping xcode-cli tools, already installed..."
else
  echo "Bootstrap : Installing xcode-cli tools..."
  xcode-select --install
fi

## Bootstrap Homebrew

# Check for Homebrew, install if we don't have it
if [[ $(command -v brew) == "" ]]; then 
    echo "Bootstrap : Installing homebrew..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo "Bootstrap : Skipping hombrew tools, already installed..."  
  brew upgrade
fi

# Check Homebrew install
brew doctor

# Make Cask available to Homebrew
brew tap caskroom/cask 
brew tap caskroom/fonts
brew tap caskroom/versions
brew tap homebrew/services
brew tap adoptopenjdk/openjdk
brew tap microsoft/mssql-release
brew tap puppetlabs/puppet

# Update Homebrew recipes
brew update

# Install pre-requisites
brew reinstall brew-cask-completion
brew cask reinstall adoptopenjdk

# Installing Browsers

brew cask install -f \
  brave-browser\
  google-chrome \
  google-chrome-canary \
  google-backup-and-sync \
  google-hangouts \
  firefox

# Installing Desktop Tools

brew cask install -f \
  airtame \
  authy \
  slack \
  zoomus \
  iterm2 \
  keepingyouawake \
  tunnelblick

# Installing Microsoft Office
brew cask reinstall microsoft-office
 
# Installing Developer Tools

brew install -f \
  bash ksh tcsh zsh \
  bash-completion \
  findutils \
  bfg \
  ccache \
  circleci \
  cmake \
  coreutils \
  curl \
  dos2unix \
  git \
  git-flow \
  git-lfs \
  go \
  hub \
  imagemagick \
  leiningen \
  node \
  protobuf \
  python --with-tcl-tk \
  jq \
  wget \
  neovim \
  vim \
  macvim \
  vimpager \
  emacs \
  colordiff \
  htop \
  unzip \
  p7zip \
  rsync \
  rbenv \
  screen \
  terraform \
  tmux \
  zlib

# Installing Puppet Toolchain
brew cask install -f puppetlabs/puppet/puppet-bolt
brew cask install -f puppetlabs/puppet/puppet-agent
brew cask install -f puppetlabs/puppet/pdk

# Installing Developer Data Layers
brew install postgresql
brew install pg_top
brew install redis

# Installing Microsft SQL Command Line Tools
brew install -f --no-sandbox msodbcsql mssql-tools
brew install -f azure-data-studio

brew cask install -f \
  alfred \
  atom \
  datagrip \
  docker \
  cyberduck \
  insomnia \
  keka \
  keybase \
  libreoffice \
  github \
  gpg-suite \
  parallels \
  postman \
  royal-tsx \
  rstudio \
  transmit \
  vagrant \
  vagrant-manager \
  virtualbox \
  virtualbox-extension-pack \
  visual-studio \
  visual-studio-code \
  transmission \
  vlc

# Installing latest version of python pip
pip3 install --upgrade pip setuptools wheel

# Setup system performance parameters

chflags nohidden ~/Library

defaults write com.apple.finder ShowPathbar -bool true

defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults write com.apple.screencapture disable-shadow -bool true

defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -int 0
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write NSGlobalDomain NSWindowResizeTime .001
killall Dock
killall Finder

brew cleanup
brew cask cleanup
