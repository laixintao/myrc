#!/bin/bash

brew list | sort > brew-formula.list
brew list --cask | sort > brew-cask.list
pipx list --json > pipx.json
