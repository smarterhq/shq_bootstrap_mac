#!/usr/bin/env bash

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
#brew tap homebrew/cask
brew tap homebrew/cask-fonts
brew tap homebrew/cask-versions
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
brew cask install brave-browser
brew cask install google-chrome
brew cask install google-chrome-canary
brew cask install google-backup-and-sync
brew cask install google-hangouts
brew cask install firefox

# Installing Desktop Tools
brew cask install airtame
brew cask install authy
brew cask install keepingyouawake

brew cask reinstall slack
brew cask reinstall amazon-chime
brew cask reinstall bluejeans
brew cask reinstall zoomus

brew cask reinstall powershell
brew cask reinstall iterm2

brew cask reinstall tunnelblick

# Installing LibreOffice
brew cask reinstall libreoffice

# Installing Microsoft Office
brew cask reinstall microsoft-office

# Installing Developer Tools
brew cask reinstall dotnet-sdk

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
brew install -f freetds
brew install -f git
brew install -f git-flow
brew install -f git-lfs
brew install -f git-secrets
brew install -f gnu-sed
brew install -f go
brew install -f hadolint
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
brew install -f watch
brew install -f zlib

# Installing Developer VM Toolchain
brew cask install docker
brew install docker-compose
brew cask install parallels
brew cask install vagrant
brew cask install vagrant-manager
# if you see any issues while running virtualbox or virtualbox-extension-pack make sure you allow "Oracle-America" in security and privacy. 
brew cask install virtualbox
brew cask install virtualbox-extension-pack

## Enforce user and group permissions on /usr/local/share...
## - fixes root:wheel blocking proper brew install operations due to manpage directories being created as root:sheel under sudo required installs
sudo chown -R "$USER" /usr/local/share
sudo chgrp -fRh admin /usr/local/share
sudo chmod -fR g+w /usr/local/share

# Installing Puppet Toolchain
brew cask install puppetlabs/puppet/puppet-bolt
brew cask install puppetlabs/puppet/puppet-agent
brew cask install puppetlabs/puppet/pdk

# Installing Developer Data Layers
brew install postgresql
brew install pg_top
brew install redis

# Installing Microsft SQL Command Line Tools
ACCEPT_EULA="Y" brew install msodbcsql
ACCEPT_EULA="Y" brew install mssql-tools
ACCEPT_EULA="Y" brew cask install azure-data-studio

brew cask install alfred
brew cask install atom
brew cask install datagrip
brew cask install cyberduck
brew cask install insomnia
brew cask install keka
brew cask install keybase
brew cask install github
brew cask install gpg-suite
brew cask install postman
brew cask install royal-tsx
brew cask install r
brew cask install rstudio
brew cask install rubymine
brew cask install transmit
brew cask install visual-studio
brew cask install visual-studio-code
brew cask install transmission
brew cask install vlc

# Installing latest version of python pip
pip3 install --upgrade pip pipenv setuptools wheel

# Setup system performance parameters
chflags nohidden ~/Library

defaults write com.apple.finder ShowPathbar -bool true

defaults write com.apple.desktopservices DSDontWriteNetworkStores true
defaults write com.apple.screencapture disable-shadow -bool true

defaults write com.apple.dock autohide-delay -float 0
defaults write com.apple.dock autohide-time-modifier -int 0
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write NSGlobalDomain NSWindowResizeTime .001

#new commands for bootstrap
brew install homebrew/bundle
brew cask install brewservicesmenubar
brew install tfsec 
brew tap wata727/tflint

# Cryptography and SSL/TLS Toolkit
brew install openssl@1.1

# General-purpose data compression with high compression ratio
brew install xz

# Interpreted, interactive, object-oriented programming language
brew install python@3.8

# Software library to render fonts
brew install freetype

# Core application library for C
brew install glib

# Vector graphics library with cross-device output support
brew install cairo

# Arbitrary precision calculator
brew install calc

# Command-line tool for Amazon Route 53
brew install cli53

# Statistics utility to count lines of code
brew install cloc

# Get a file from an HTTP, HTTPS or FTP server
brew install curl

# Docker Credential Helper for Amazon ECR
brew install docker-credential-helper-ecr

# GNU multiple precision arithmetic library
brew install gmp

# Manage compile and link flags for libraries
brew install pkg-config

# OpenType text shaping engine
brew install harfbuzz

# Command-line outline and bitmap font editor/converter
brew cask install fontforge

# Library for manipulating fonts
brew install fonttools

# GNU version of the tar archiving utility
brew install -f gnu-tar

# GNU grep, egrep and fgrep
brew install grep

# JSON parser and validator with a CLI
brew install jsonlint

# Sophisticated file transfer program
brew install lftp

# Count lines of code quickly
brew install loc

# Drop-in replacement for MySQL
#To have launchd start mariadb now and restart at login:
#brew services start mariadb
brew install mariadb

# Collection of tools that nobody wrote when UNIX was young
brew install moreutils

# FTP client with an advanced user interface
brew install ncftp

# Utility for managing network connections
brew install netcat

# PNG file optimizer
brew install optipng

# General-purpose scripting language
brew install php

# Object-relational database system
brew install postgresql@11

# HTTP regression testing and benchmarking utility
brew install siege

# S/MIME signing utility for use with Git
brew install smimesign

# User interface to the TELNET protocol
brew install telnet

# Tool to generate documentation from Terraform modules
brew install terraform-docs

# Library to create, extract, and modify Windows Imaging files
brew install wimlib

# tool to install snowflake db
brew cask install snowflake-snowsql

killall Dock
killall Finder

brew cleanup
