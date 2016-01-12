#!/usr/bin/env python3.4

import os
from setuptools import setup

with open(os.path.join(os.path.dirname(__file__), 'README.rst')) as readme:
    README = readme.read()

# allow setup.py to be run from any path
os.chdir(os.path.normpath(os.path.join(os.path.abspath(__file__), os.pardir)))

def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()

setup(
    name='django-settings-startup',
    version=read('VERSION'),
    packages=['settings-startup'],
    include_package_data=True,
    license='MIT License',
    description='A simple Django app to see settings on startup.',
    long_description=read('README.rst'),
    url='https://github.com/glegoux/django-settings-startup/',
    author='Gilles LEGOUX',
    author_email='gilles.legoux@gmail.com',
    tests_require=['Django>=1.8.5'],
    test_suite='tests.test',
    classifiers=[
        'Environment :: Web Environment',
        'Framework :: Django',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: MIT License',
        'Operating System :: OS Independent',
        'Programming Language :: Python',
        'Programming Language :: Python :: 3',
        'Programming Language :: Python :: 3.2',
        'Programming Language :: Python :: 3.3',
        'Programming Language :: Python :: 3.4',
        'Topic :: Internet :: WWW/HTTP',
        'Topic :: Internet :: WWW/HTTP :: Dynamic Content',
    ],
)
