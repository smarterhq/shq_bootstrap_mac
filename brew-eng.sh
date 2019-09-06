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
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
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
brew reinstall ruby
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

# Installing LibreOffice
brew cask reinstall libreoffice

# Installing Microsoft Office
brew cask reinstall microsoft-office

# Installing Developer Tools
brew cask reinstall -f dotnet-sdk

brew install -f bash
brew install -f bash-completion
brew install -f ksh
brew install -f tcsh
brew install -f zsh
brew install -f coreutils
brew install -f findutils

brew install -f black
brew install -f byobu
brew install -f bfg
brew install -f ccache
brew install -f circleci
brew install -f cmake
brew install -f curl
brew install -f dos2unix
brew install -f elixir
brew install -f git
brew install -f git-flow
brew install -f git-lfs
brew install -f git-secrets
brew install -f gnu-sed
brew install -f go
brew install -f hub
brew install -f imagemagick
brew install -f jmeter
brew install -f leiningen
brew install -f node
brew install -f openssl
brew install -f protobuf
brew install -f python
brew install -f pre-commit
brew install -f jq
brew install -f wget
brew install -f neovim
brew install -f vim
brew install -f macvim
brew install -f vimpager
brew install -f emacs
brew install -f colordiff
brew install -f htop
brew install -f unzip
brew install -f p7zip
brew install -f rsync
brew install -f rbenv
brew install -f shellcheck
brew install -f screen
brew install -f terraform
brew install -f tmux
brew install -f zlib

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

brew cask install -f alfred
brew cask install -f atom
brew cask install -f datagrip
brew cask install -f cyberduck
brew cask install -f insomnia
brew cask install -f keka
brew cask install -f keybase
brew cask install -f github
brew cask install -f gpg-suite
brew cask install -f postman
brew cask install -f royal-tsx
brew cask install -f r
brew cask install -f rstudio
brew cask install -f rubymine
brew cask install -f transmit
brew cask install -f visual-studio
brew cask install -f visual-studio-code
brew cask install -f transmission
brew cask install -f vlc

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
