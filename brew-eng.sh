#!/bin/bash

# Make sure homebrew sbin is in path
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
export HOMEBREW_FORCE_BOTTLE=1
export HOMEBREW_NO_ENV_FILTERING=1

## Bootstrap Xcode Command Line Tools First

if xcode-select --install 2>&1 | grep installed; then
  echo "Bootstrap : Skipping xcode-cli tools, already installed..."
else
  echo "Bootstrap : Installing xcode-cli tools..."
  xcode-select --install
fi

## Enforce user and group permissions on /usr/local/share...
## - fixes root:wheel blocking proper brew install operations due to manpage directories being created as root:sheel under sudo required installs
sudo chown -R "$USER" /usr/local/share
sudo chgrp -fRh admin /usr/local/share
sudo chmod -fR g+w /usr/local/share

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
brew cask install -f brave-browser
brew cask install -f google-chrome
brew cask install -f google-chrome-canary
brew cask install -f google-backup-and-sync
brew cask install -f google-hangouts
brew cask install -f firefox

# Installing Desktop Tools
brew cask install -f airtame
brew cask install -f authy
brew cask install -f keepingyouawake

brew cask reinstall -f slack
brew cask reinstall -f amazon-chime
brew cask reinstall -f blue-jeans
brew cask reinstall -f zoomus

brew cask reinstall -f powershell
brew cask reinstall -f iterm2

brew cask reinstall tunnelblick

# Installing Microsoft Office
brew cask reinstall microsoft-office

# Installing Developer Tools
brew cask reinstall -f dotnet-sdk

brew install -f \
  bash ksh tcsh zsh \
  bash-completion \
  findutils \
  byobu \
  bfg \
  ccache \
  circleci \
  cmake \
  coreutils \
  curl \
  dos2unix \
  elixir \
  git \
  git-flow \
  git-lfs \
  gnu-sed \
  go \
  hub \
  imagemagick \
  jmeter \
  leiningen \
  node \
  openssl \
  protobuf \
  python \
  pre-commit \
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
  shellcheck \
  screen \
  terraform \
  tmux \
  zlib

# Installing Developer VM Toolchain
brew cask install -f docker
brew cask install -f parallels
brew cask install -f virtualbox
brew cask install -f parallels
brew cask install -f vagrant
brew cask install -f vagrant-manager
brew cask install -f virtualbox
brew cask install -f virtualbox-extension-pack

## Enforce user and group permissions on /usr/local/share...
## - fixes root:wheel blocking proper brew install operations due to manpage directories being created as root:sheel under sudo required installs
sudo chown -R "$USER" /usr/local/share
sudo chgrp -fRh admin /usr/local/share
sudo chmod -fR g+w /usr/local/share

# Installing Puppet Toolchain
brew cask install -f puppetlabs/puppet/puppet-bolt
brew cask install -f puppetlabs/puppet/puppet-agent
brew cask install -f puppetlabs/puppet/pdk

# Installing Developer Data Layers
brew install postgresql
brew install pg_top
brew install redis

# Installing Microsft SQL Command Line Tools
ACCEPT_EULA="Y" brew install -f msodbcsql
ACCEPT_EULA="Y" brew install -f mssql-tools
ACCEPT_EULA="Y" brew cask install -f azure-data-studio

brew cask install -f \
  alfred \
  atom \
  datagrip \
  cyberduck \
  insomnia \
  keka \
  keybase \
  libreoffice \
  github \
  gpg-suite \
  postman \
  royal-tsx \
  rstudio \
  rubymine \
  transmit \
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
