SHELL = /usr/bin/env bash

PYTHON = python
PIP = pip
BIN_DIR = /usr/bin
MANAGE = tests/manage.py
SETUP = setup.py
BUILD = sdist bdist_wheel
VERSION = $(shell $(PYTHON) $(SETUP) --version)
PACKNAME = $(shell $(PYTHON) $(SETUP) --name)
PYPI_CONFIG_FILE = .pypirc

.PHONY: usage
usage:
	@echo "targets include: usage all version pyversion switch view hidden test gen install deploy download uninstall clean"

.PHONY: all
all: switch install deploy uninstall download clean

.PHONY: pyversion
pyversion:
	@$(PYTHON) --version 2>&1

.PHONY: version
version: pyversion
	@$(PIP) --version
	@echo -n "Django "; $(PYTHON) $(MANAGE) --version
	@echo $(PACKNAME) $(VERSION)

.PHONY: switch
switch: pyversion
	### switch between python 2 and 3 ###
	@read -p "Do you want to switch of python version ? (y/n): " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	echo -n 'from '; \
	$(PYTHON) --version 2>&1; \
	if $(PYTHON) --version 2>&1 | grep -q "Python 2"; then \
		sudo ln -sfv "$(BIN_DIR)/python3" "$(BIN_DIR)/python"; \
		sudo ln -sfv "$(BIN_DIR)/pip3" "$(BIN_DIR)/pip"; \
	elif $(PYTHON) --version 2>&1 | grep -q "Python 3"; then \
		sudo ln -sfv "$(BIN_DIR)/python2" "$(BIN_DIR)/python"; \
		sudo ln -sfv "$(BIN_DIR)/pip2" "$(BIN_DIR)/pip"; \
	fi; \
	echo -n 'to '; \
	$(PYTHON) --version  2>&1

.PHONY: version view
view:
	### package file system ###
	@tree -C $$PWD; \
	du -sh $$PWD; \
	echo "$(shell cat $(shell find . -name '*.py')  | wc -l) python code lines"

.PHONY: hidden
hidden:
	### hidden data ###
	@ls -ad --color .* | sed 1,2d

.PHONY: test
test: version
	### tests ###
	@$(PYTHON) $(SETUP) test

.PHONY: gen
gen: version test
	### generate python package ###
	@read -p "Do you want to generate this version $(VERSION) ? (y/n): " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	$(PYTHON) $(SETUP) $(BUILD)

.PHONY: install
install: version gen
	### install python package ###
	@read -p "Do you want to install this version $(VERSION) ? (y/n): " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	$(PIP) install --user .

.PHONY: deploy
deploy: version gen
	### deploy python package to PyPI depot ###
	@read -p "Do you want to deploy this version $(VERSION) ? (y/n): " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	read -s -p "password: " passwd; \
	echo -e "\n-- Upload on PyPI - the Python Package Index..."; \
	twine upload "dist/$(PACKNAME)-$(VERSION).tar.gz" \
		--config-file "$(PYPI_CONFIG_FILE)" \
		--password "$${passwd}"; \
	echo "...OK"

.PHONY: download
download: version
	### download python package from PyPI depot ###
	@read -p "Do you want to download then install this version $(VERSION) ? (y/n): " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	$(PIP) install --user "$(PACKNAME)"=="$(VERSION)"

.PHONY: uninstall
uninstall: version
	### uninstall python package ###
	@read -p "Do you want to uninstall this version $(VERSION) ? (y/n): " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi
	### uninstall pip package ###
	@$(PIP) uninstall "$(PACKNAME)"

.PHONY: clean
clean:
	### clean python package ###
	@read -p "Do you want to clean the project ? (y/n): " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi;
	@rm -rfv ./build/
	@rm -rfv ./dist/
	@rm -rfv *.egg-info
	@rm -rfv $(shell find . -name '*.pyc')
	@rm -rfv $(shell find . -name '__pycache__')
