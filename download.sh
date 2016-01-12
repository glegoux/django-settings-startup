#!/usr/bin/env bash

packname=$(./setup.py --name)
version=$(./setup.py --version)

pip3 install --user "${packname}"=="${version}"
