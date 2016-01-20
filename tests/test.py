from io import StringIO
import os
import signal
import sys
import time

from django.core.management import call_command
from django.test import TestCase
from django.core.wsgi import get_wsgi_application


os.environ.setdefault("DJANGO_SETTINGS_MODULE", "tests.config")
application = get_wsgi_application()


class TestCommand(TestCase):

    def test_with_config(self):
        """ Test if settings are written on standard output """
        r, w = os.pipe()
        pid = os.fork()
        if pid == 0:
            os.close(r)
            with os.fdopen(w, 'w') as w:
                sys.stdout = w
                call_command('runserver', use_reloader=False, use_config=True)
                sys.exit(0)
        time.sleep(2)
        os.close(w)
        os.kill(pid, signal.SIGTERM)
        found = False
        with os.fdopen(r) as r:
            if sys.version_info >= (3, 0):
                msg = r.read()
            else:
                msg = unicode(r.read())
            with StringIO(msg) as b:
                for line in b.readlines():
                    line = line.rstrip()
                    s = line.split(' = ')
                    if len(s) == 2 and s[0] == 'APPLICATION_STAGE':
                        found = True
                        self.assertEqual(s[1], '\'test\'', 'APPLICATION_STAGE bad value')
                        break
                self.assertEqual(found, True, 'APPLICATION_STAGE does not exist')

    def test_without_config(self):
        """ Test if settings are not written on standard output """
        r, w = os.pipe()
        pid = os.fork()
        if pid == 0:
            os.close(r)
            with os.fdopen(w, 'w') as w:
                sys.stdout = w
                call_command('runserver', use_reloader=False, use_config=False)
                sys.exit(0)
        time.sleep(2)
        os.close(w)
        os.kill(pid, signal.SIGTERM)
        with os.fdopen(r) as r:
            if sys.version_info >= (3, 0):
                msg = r.read()
            else:
                msg = unicode(r.read())
            with StringIO(msg) as b:
                for line in b.readlines():
                    line = line.rstrip()
                    s = line.split(' = ')
                    if len(s) == 1 and s[0] == 'Settings django...':
                        self.fail("Settings django should not be present on standard output")

