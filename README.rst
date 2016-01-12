Django Settings On Startup
==========================

See your chosen settings in stdout when django is starting with ``python manage.py runserver``.
For Django 1.8.5 and python 3.4.


Install
-------

1. Download package::

    pip install django-print-settings

2. Add "settings-startup" to your INSTALLED_APPS setting like this::

  INSTALLED_APPS = [
    ...
    'settings-startup',
  ]

Lastest Version
---------------

0.1

PyPI
----

https://pypi.python.org/pypi/django-settings-startup
