SHELL = /usr/bin/env bash

PYTHON = python3.4
PIP = pip3
SETUP = setup.py
VERSION = $(shell $(PYTHON) $(SETUP) --version)
PACKNAME = $(shell $(PYTHON) $(SETUP) --name)
INSTALL_FILES = install-files.txt
PYPI_CONFIG_FILE = .pypirc

.PHONY: usage
usage:
	@echo "targets include: usage all version view hidden test gen install deploy download uninstall clean"

.PHONY: all
all: deploy

.PHONY: version
version:
	@echo $(VERSION)

.PHONY: view
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
test:
	### tests ###
	@$(PYTHON) $(SETUP) test

.PHONY: gen
gen:
	### generate python package ###
	@read -p "Do you want to generate this version $(VERSION) ? (y/n): " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	$(PYTHON) $(SETUP) sdist

.PHONY: install
install: gen
	### install python package ###
	@read -p "Do you want to install this version $(VERSION) ? (y/n): " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	$(PYTHON) $(SETUP) install --user --record $(INSTALL_FILES)

.PHONY: deploy
deploy: gen
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
download:
	### download python package from PyPI depot ###
	@read -p "Do you want to download then install this version $(VERSION) ? (y/n): " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	$(PIP) install --user "$(PACKNAME)"=="$(VERSION)"

.PHONY: uninstall
uninstall:
	### uninstall python package ###
	@read -p "Do you want to uninstall this version $(VERSION) ? (y/n): " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi
	### uninstall setup package ###
	@cat $(INSTALL_FILES) | xargs rm -rvf
	@rm -rvf $(INSTALL_FILES)
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
