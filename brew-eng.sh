#!/usr/bin/env bash

# Make sure homebrew sbin is in path
export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
export HOMEBREW_FORCE_BOTTLE=1
export ACCEPT_EULA=Y
# export HOMEBREW_NO_ENV_FILTERING=1

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
brew tap homebrew/bundle
brew tap homebrew/cask-fonts
brew tap homebrew/cask-versions
brew tap homebrew/services
brew tap adoptopenjdk/openjdk
brew tap microsoft/mssql-release
brew tap puppetlabs/puppet
brew tap wata727/tflint

# Update Homebrew recipes
brew update

# Install pre-requisites
brew install brew-cask-completion
brew install ruby
brew install --cask adoptopenjdk

# Installing Browsers
brew install --cask brave-browser
brew install --cask google-chrome
brew install --cask google-chrome-canary
brew install --cask google-backup-and-sync
brew install --cask google-hangouts
brew install --cask firefox

# Installing Desktop Tools
brew install --cask airtame
brew install --cask authy
brew install --cask keepingyouawake

brew install --cask slack
brew install --cask amazon-chime
brew install --cask bluejeans
brew uninstall zoomus
brew install --cask zoom

brew install --cask powershell
brew install --cask iterm2

brew install --cask tunnelblick

# Installing LibreOffice
brew install --cask libreoffice

# Installing Microsoft Office
brew install --cask microsoft-office

# Installing Developer Tools
brew install --cask dotnet-sdk

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
brew uninstall -f terraform
brew install -f tfenv
brew install -f tfsec
brew install -f tmux
brew install -f watch
brew install -f zlib

# Installing Developer VM Toolchain
brew uninstall docker-compose
brew install --cask docker
brew install --cask parallels
brew install --cask vagrant
brew install --cask vagrant-manager
# if you see any issues while running virtualbox or virtualbox-extension-pack make sure you allow "Oracle-America" in security and privacy.
brew install --cask virtualbox
brew install --cask virtualbox-extension-pack

## Enforce user and group permissions on /usr/local/share...
## - fixes root:wheel blocking proper brew install operations due to manpage directories being created as root:sheel under sudo required installs
sudo chown -R "$USER" /usr/local/share
sudo chgrp -fRh admin /usr/local/share
sudo chmod -fR g+w /usr/local/share

# Installing Puppet Toolchain
brew install --cask puppetlabs/puppet/puppet-bolt
brew install --cask puppetlabs/puppet/puppet-agent
brew install --cask puppetlabs/puppet/pdk

# Installing Developer Data Layers
brew install postgresql
brew install pg_top
brew install redis

# Installing Microsft SQL Command Line Tools
ACCEPT_EULA="Y" brew install msodbcsql
ACCEPT_EULA="Y" brew install mssql-tools
ACCEPT_EULA="Y" brew install --cask azure-data-studio

brew install --cask alfred
brew install --cask atom
brew install --cask brewservicesmenubar
brew install --cask cyberduck
brew install --cask datagrip
brew install --cask insomnia
brew install --cask keka
brew install --cask keybase
brew install --cask github
brew install --cask gpg-suite
brew install --cask postman
brew install --cask royal-tsx
brew install --cask r
brew install --cask rstudio
brew install --cask rubymine
brew install --cask transmit
brew install --cask visual-studio
brew install --cask visual-studio-code
brew install --cask transmission
brew install --cask vlc

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
brew install --cask fontforge

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
brew install --cask snowflake-snowsql

## Enforce user and group permissions on /usr/local/share...
## - fixes root:wheel blocking proper brew install operations due to manpage directories being created as root:sheel under sudo required installs
sudo chown -R "$USER" /usr/local/share
sudo chgrp -fRh admin /usr/local/share
sudo chmod -fR g+w /usr/local/share

killall Dock
killall Finder

brew cleanup
