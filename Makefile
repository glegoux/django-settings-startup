SHELL = /usr/bin/env bash

onlypyfile = $(shell find $(1) -name '*.py' -type f | grep -v __init__.py)

PYTHON = python
PIP = pip
PEP8 = pep8
PYLINT = pylint
BIN_DIR = /usr/bin
FILES = setup.py $(call onlypyfile,"tests/" "django_settings_startup/")
MANAGE = tests/manage.py
SETUP = setup.py
BUILD = sdist bdist_wheel
REGISTER = pypi
UPLOAD_DIR = dist
BUILD_DIR = build
PYPI_CONFIG_FILE = .pypirc
VERSION = $(shell $(PYTHON) $(SETUP) --version)
PACKNAME = $(shell $(PYTHON) $(SETUP) --name)

.PHONY: usage
usage:
	@echo "targets include: usage all version pyversion switch view hidden register"
	@echo "                 style check pylint test gen install upload download uninstall clean"

.PHONY: all
all: switch install upload uninstall download clean

.PHONY: pyversion
pyversion:
	@$(PYTHON) --version 2>&1

.PHONY: version
version: pyversion
	@$(PIP) --version
	@echo -n "Django "; $(PYTHON) $(MANAGE) --version
	@echo -n "PEP8 "; $(PEP8) --version
	@pylint --version 2> /dev/null | sed 3d
	@echo $(PACKNAME) $(VERSION)

.PHONY: switch
switch: pyversion
	### switch between python 2 and 3 ###
	@read -p "Do you want to switch of python version (y/n)? " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	echo -n 'from '; \
	$(PYTHON) --version 2>&1; \
	if $(PYTHON) --version 2>&1 | grep -q "Python 2"; then \
		sudo ln -sfv "$(BIN_DIR)/python3" "$(BIN_DIR)/python"; \
		sudo ln -sfv "$(BIN_DIR)/pip3" "$(BIN_DIR)/pip"; \
		sudo ln -sfv "$(BIN_DIR)/python3-config" "$(BIN_DIR)/python-config"; \
	elif $(PYTHON) --version 2>&1 | grep -q "Python 3"; then \
		sudo ln -sfv "$(BIN_DIR)/python2" "$(BIN_DIR)/python"; \
		sudo ln -sfv "$(BIN_DIR)/pip2" "$(BIN_DIR)/pip"; \
		sudo ln -sfv "$(BIN_DIR)/python2-config" "$(BIN_DIR)/python-config"; \
	fi; \
	echo -n 'to '; \
	$(PYTHON) --version  2>&1

.PHONY: view
view: version
	### package file system ###
	@tree -C $$PWD; \
	du -sh $$PWD; \
	echo "$(shell cat $(shell find $(FILES) -name '*.py')  | wc -l) python code lines"

.PHONY: hidden
hidden:
	### hidden data ###
	@ls -ad --color .* | sed 1,2d

.PHONY: register
register:
	### register project ###
	@echo -n "Do you want to register this project $(PACKNAME) to $(REGISTER)"; \
	read -p " (y/n)? " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	@$(PYTHON) $(SETUP) egg_info; \
	less */PKG-INFO; \
	$(PYTHON) $(SETUP) register -r $(REGISTER)

.PHONY: style
style: version
	### coding style ###
	@$(PEP8) $(FILES); \
	echo "OK..."

.PHONY: check
check: version
	### check setup.py ###
	@$(PYTHON) $(SETUP) check --restructuredtext

.PHONY: pylint
pylint: version
	### pylint ###
	@$(PYLINT) $(FILES) || exit 0

.PHONY: test
test: version check style pylint
	### unit tests ###
	@$(PYTHON) $(SETUP) test

.PHONY: gen
gen: version test
	### generate python package ###
	@read -p "Do you want to generate this version $(VERSION) (y/n)? " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	$(PYTHON) $(SETUP) $(BUILD)

.PHONY: install
install: version gen
	### install python package ###
	@read -p "Do you want to install this version $(VERSION) (y/n)? " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	$(PIP) install --user .

.PHONY: upload
upload: version gen
	### upload python package to PyPI depot ###
	@read -p "Do you want to upload this version $(VERSION) on register $(REGISTER) (y/n)? " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	echo "Uploading this files :"; \
	ls -1 "$(UPLOAD_DIR)/" | sed 's/^/  /'; \
	read -p "Proceed (y/n)? " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	read -s -p "password: " passwd; \
	echo -e "\n-- Upload on PyPI - the Python Package Index..."; \
	twine upload "$(UPLOAD_DIR)/*" \
		--config-file "$(PYPI_CONFIG_FILE)" \
		-r "$(REGISTER)" \
		--password "$${passwd}"; \
	echo "...OK"

.PHONY: download
download: version
	### download python package from PyPI depot ###
	@read -p "Do you want to download then install this version $(VERSION) (y/n)? " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	$(PIP) install --user "$(PACKNAME)"=="$(VERSION)"

.PHONY: uninstall
uninstall: version
	### uninstall python package ###
	@read -p "Do you want to uninstall this version $(VERSION) (y/n)? " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	### uninstall pip package ###
	$(PIP) uninstall "$(PACKNAME)"

.PHONY: clean
clean:
	### clean python package ###
	@read -p "Do you want to clean the project (y/n)? " answer; \
	if [ "$${answer}" != "y" ]; then exit; fi; \
	rm -rfv ./$(BUILD_DIR)/; \
	rm -rfv ./$(UPLOAD_DIR)/; \
	rm -rfv *.egg-info; \
	rm -rfv $(shell find . -name '*.pyc'); \
	rm -rfv $(shell find . -name '__pycache__'); \
	echo "OK..."
