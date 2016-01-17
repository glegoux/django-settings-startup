import os
import time
import signal

import django
from django.core.management import call_command
from django.test import TestCase
from django.core.wsgi import get_wsgi_application

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "tests.config")
application = get_wsgi_application()

class TestCommand(TestCase):

    def test_command_config(self):
        django.setup()
        pid = os.fork()
        if pid == 0:
          call_command('runserver', use_config=True)
        time.sleep(2)
        os.kill(pid, signal.SIGTERM)
