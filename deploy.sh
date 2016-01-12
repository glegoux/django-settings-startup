#!/usr/bin/env bash

packname=`./setup.py --name`
config_file=".pypirc"
version=`./setup.py --version`

read -s -p "password: " passwd

echo -e "\n-- Upload on PyPI - the Python Package Index..."
twine upload "dist/${packname}-${version}.tar.gz" --config-file ".pypirc" --password "${passwd}"
echo "...OK"
