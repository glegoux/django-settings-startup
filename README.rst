Django Settings On Startup
==========================

See your chosen settings on standard output when django is starting with ``runserver`` command with   
an additional CLI option.


For Django 1.8.5 and Python 2.7, 3.2, 3.3, 3.4.

**Latest python package information**

.. image:: https://img.shields.io/pypi/status/django-settings-startup.svg
    :target: https://pypi.python.org/pypi/django-settings-startup
    :alt: pypi-stability

.. image:: https://img.shields.io/pypi/v/django-settings-startup.svg
    :target: https://pypi.python.org/pypi/django-settings-startup
    :alt: pypi-version

.. image:: https://img.shields.io/pypi/pyversions/django-settings-startup.svg
    :target: https://pypi.python.org/pypi/django-settings-startup
    :alt: pypi-pythonversion

.. image:: https://img.shields.io/pypi/implementation/django-settings-startup.svg
    :target: https://pypi.python.org/pypi/django-settings-startup
    :alt: pypi-implementation

.. image:: https://img.shields.io/pypi/wheel/django-settings-startup.svg
    :target: https://pypi.python.org/pypi/django-settings-startup
    :alt: pypi-build

**Other information**

.. image:: https://travis-ci.org/glegoux/django-settings-startup.svg?branch=master
    :target: https://travis-ci.org/glegoux/django-settings-startup
    :alt: travis-status

.. image:: https://img.shields.io/badge/docs-latest-brightgreen.svg
    :target: http://django-settings-startup.readthedocs.org/en/latest/
    :alt: doc

.. image:: https://img.shields.io/packagist/l/doctrine/orm.svg
    :target: https://github.com/glegoux/django-settings-startup/blob/master/LICENSE
    :alt: license

.. image:: https://img.shields.io/pypi/dm/django-settings-startup.svg
    :target: http://pypi-ranking.info/module/django-settings-startup
    :alt: pypi-download

Usage
-----

Once installed, using this command::

    python manage.py runserver --config


**Additional CLI Options**

--config
  Show your settings on standard output.

Please see ``python manage.py runserver --help`` for more information additional options.

Install
-------

1. Download package::

    pip install django-settings-startup

2. Add "django_settings_startup" in first rank to your INSTALLED_APPS settings like this::

    INSTALLED_APPS = [
        'django_settings_startup',
        ...
    ]

It is important to install this app in first (before native django apps), to override the command ``runserver``.

Version
-------

See `VERSION <https://github.com/glegoux/django-settings-startup/blob/2.x/VERSION>`_.

Changelog
---------

See `CHANGELOG <https://github.com/glegoux/django-settings-startup/blob/2.x/CHANGELOG.md>`_.

Read The Docs : Documentation
-----------------------------

* http://django-settings-startup.readthedocs.org/en/2.x/

GitHub : Source Code
--------------------

* https://github.com/glegoux/django-settings-startup/tree/2.x/

PyPI : open source Python packages
----------------------------------

* home page: https://pypi.python.org/pypi/django-settings-startup/2.0
* ranking: http://pypi-ranking.info/module/django-settings-startup

Travis CI : continous integration
---------------------------------

* https://travis-ci.org/glegoux/django-settings-startup

Coveralls : code coverage
-------------------------

* https://coveralls.io/github/glegoux/django-settings-startup

PyLint : source code bug
------------------------

* home page: http://www.pylint.org/
* all codes: http://pylint-messages.wikidot.com/all-codes

PEP8 : coding style
-------------------

* https://www.python.org/dev/peps/pep-0008/

Useful links
------------

* https://github.com/django/django/blob/stable/1.8.x/django/core/management/commands/runserver.py
* https://github.com/django/django/blob/stable/1.8.x/django/core/management/base.py
* https://github.com/django/django/blob/stable/1.8.x/django/core/management/commands/testserver.py
* https://docs.djangoproject.com/en/1.8/howto/custom-management-commands/
* https://docs.djangoproject.com/en/1.8/ref/django-admin/#running-management-commands-from-your-code

License
-------

See `LICENSE <https://github.com/glegoux/django-settings-startup/blob/2.x/LICENSE>`_.
