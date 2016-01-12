#!/usr/bin/env bash

# setup install
cat install-files.txt | xargs rm -v

# pip install
packname=$(./setup.py --name)
version=$(./setup.py --version)

pip3 uninstall "${packname}"=="${version}"
