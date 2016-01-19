Django Settings On Startup
==========================

.. image:: https://travis-ci.org/glegoux/django-settings-startup.svg
  :alt: Travis CI build status
  :align: right  

See your chosen settings on standard output when django is starting with ``runserver`` command with   
an additional CLI option.


For Django 1.8.5 and Python 3.4.

Usage
-----

Once installed, using this command::

    python manage.py runserver --config


Additional CLI Options
~~~~~~~~~~~~~~~~~~~~~~

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

Latest Version
---------------

1.0

Documentation
-------------

* http://django-settings-startup.readthedocs.org/en/latest/

Source Code
-----------

* https://github.com/glegoux/django-settings-startup/

PyPI : open source Python packages
----------------------------------

* home page: https://pypi.python.org/pypi/django-settings-startup
* ranking: http://pypi-ranking.info/module/django-settings-startup

Travis CI : continous integration
---------------------------------

* https://travis-ci.org/glegoux/django-settings-startup

Useful links
------------

* https://github.com/django/django/blob/stable/1.8.x/django/core/management/commands/runserver.py
* https://github.com/django/django/blob/stable/1.8.x/django/core/management/base.py
* https://github.com/django/django/blob/stable/1.8.x/django/core/management/commands/testserver.py
* https://docs.djangoproject.com/en/1.8/howto/custom-management-commands/
* https://docs.djangoproject.com/en/1.8/ref/django-admin/#running-management-commands-from-your-code
