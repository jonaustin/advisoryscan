import datetime
import sys
from cStringIO import StringIO
from urlparse import urlparse
from django.conf import settings
from django.contrib.auth import authenticate, login
from django.contrib.sessions.models import Session
from django.contrib.sessions.middleware import SessionWrapper
from django.core.handlers.base import BaseHandler
from django.core.handlers.wsgi import WSGIRequest
from django.core.signals import got_request_exception
from django.dispatch import dispatcher
from django.http import urlencode, SimpleCookie, HttpRequest
from django.test import signals
from django.utils.functional import curry

BOUNDARY = 'BoUnDaRyStRiNg'
MULTIPART_CONTENT = 'multipart/form-data; boundary=%s' % BOUNDARY

class ClientHandler(BaseHandler):
    """
    A HTTP Handler that can be used for testing purposes.
    Uses the WSGI interface to compose requests, but returns
    the raw HttpResponse object
    """
    def __call__(self, environ):
        from django.conf import settings
        from django.core import signals

        # Set up middleware if needed. We couldn't do this earlier, because
        # settings weren't available.
        if self._request_middleware is None:
            self.load_middleware()

        dispatcher.send(signal=signals.request_started)
        try:
            request = WSGIRequest(environ)
            response = self.get_response(request)

            # Apply response middleware
            for middleware_method in self._response_middleware:
                response = middleware_method(request, response)

        finally:
            dispatcher.send(signal=signals.request_finished)

        return response

def store_rendered_templates(store, signal, sender, template, context):
    "A utility function for storing templates and contexts that are rendered"
    store.setdefault('template',[]).append(template)
    store.setdefault('context',[]).append(context)

def encode_multipart(boundary, data):
    """
    A simple method for encoding multipart POST data from a dictionary of
    form values.

    The key will be used as the form data name; the value will be transmitted
    as content. If the value is a file, the contents of the file will be sent
    as an application/octet-stream; otherwise, str(value) will be sent.
    """
    lines = []
    for (key, value) in data.items():
        if isinstance(value, file):
            lines.extend([
                '--' + boundary,
                'Content-Disposition: form-data; name="%s"' % key,
                '',
                '--' + boundary,
                'Content-Disposition: form-data; name="%s_file"; filename="%s"' % (key, value.name),
                'Content-Type: application/octet-stream',
                '',
                value.read()
            ])
        elif hasattr(value, '__iter__'): 
            for item in value:
                lines.extend([ 
                    '--' + boundary, 
                    'Content-Disposition: form-data; name="%s"' % key, 
                    '', 
                    str(item) 
                ])
        else:
            lines.extend([
                '--' + boundary,
                'Content-Disposition: form-data; name="%s"' % key,
                '',
                str(value)
            ])

    lines.extend([
        '--' + boundary + '--',
        '',
    ])
    return '\r\n'.join(lines)

class Client:
    """
    A class that can act as a client for testing purposes.

    It allows the user to compose GET and POST requests, and
    obtain the response that the server gave to those requests.
    The server Response objects are annotated with the details
    of the contexts and templates that were rendered during the
    process of serving the request.

    Client objects are stateful - they will retain cookie (and
    thus session) details for the lifetime of the Client instance.

    This is not intended as a replacement for Twill/Selenium or
    the like - it is here to allow testing against the
    contexts and templates produced by a view, rather than the
    HTML rendered to the end-user.
    """
    def __init__(self, **defaults):
        self.handler = ClientHandler()
        self.defaults = defaults
        self.cookies = SimpleCookie()
        self.exc_info = None
        
    def store_exc_info(self, *args, **kwargs):
        """
        Utility method that can be used to store exceptions when they are
        generated by a view.
        """
        self.exc_info = sys.exc_info()

    def _session(self):
        "Obtain the current session variables"
        if 'django.contrib.sessions' in settings.INSTALLED_APPS:
            cookie = self.cookies.get(settings.SESSION_COOKIE_NAME, None)
            if cookie:
                return SessionWrapper(cookie.value)
        return {}
    session = property(_session)
    
    def request(self, **request):
        """
        The master request method. Composes the environment dictionary
        and passes to the handler, returning the result of the handler.
        Assumes defaults for the query environment, which can be overridden
        using the arguments to the request.
        """

        environ = {
            'HTTP_COOKIE':      self.cookies,
            'PATH_INFO':         '/',
            'QUERY_STRING':      '',
            'REQUEST_METHOD':    'GET',
            'SCRIPT_NAME':       None,
            'SERVER_NAME':       'testserver',
            'SERVER_PORT':       80,
            'SERVER_PROTOCOL':   'HTTP/1.1',
        }
        environ.update(self.defaults)
        environ.update(request)

        # Curry a data dictionary into an instance of
        # the template renderer callback function
        data = {}
        on_template_render = curry(store_rendered_templates, data)
        dispatcher.connect(on_template_render, signal=signals.template_rendered)

        # Capture exceptions created by the handler
        dispatcher.connect(self.store_exc_info, signal=got_request_exception)

        response = self.handler(environ)

        # Add any rendered template detail to the response
        # If there was only one template rendered (the most likely case),
        # flatten the list to a single element
        for detail in ('template', 'context'):
            if data.get(detail):
                if len(data[detail]) == 1:
                    setattr(response, detail, data[detail][0]);
                else:
                    setattr(response, detail, data[detail])
            else:
                setattr(response, detail, None)

        # Look for a signalled exception and reraise it
        if self.exc_info:
            raise self.exc_info[1], None, self.exc_info[2]
        
        # Update persistent cookie data
        if response.cookies:
            self.cookies.update(response.cookies)

        return response

    def get(self, path, data={}, **extra):
        "Request a response from the server using GET."
        r = {
            'CONTENT_LENGTH':  None,
            'CONTENT_TYPE':    'text/html; charset=utf-8',
            'PATH_INFO':       path,
            'QUERY_STRING':    urlencode(data),
            'REQUEST_METHOD': 'GET',
        }
        r.update(extra)

        return self.request(**r)

    def post(self, path, data={}, content_type=MULTIPART_CONTENT, **extra):
        "Request a response from the server using POST."

        if content_type is MULTIPART_CONTENT:
            post_data = encode_multipart(BOUNDARY, data)
        else:
            post_data = data

        r = {
            'CONTENT_LENGTH': len(post_data),
            'CONTENT_TYPE':   content_type,
            'PATH_INFO':      path,
            'REQUEST_METHOD': 'POST',
            'wsgi.input':     StringIO(post_data),
        }
        r.update(extra)

        return self.request(**r)

    def login(self, **credentials):
        """Set the Client to appear as if it has sucessfully logged into a site.

        Returns True if login is possible; False if the provided credentials
        are incorrect, or if the Sessions framework is not available.
        """
        user = authenticate(**credentials)
        if user and 'django.contrib.sessions' in settings.INSTALLED_APPS:
            obj = Session.objects.get_new_session_object()

            # Create a fake request to store login details
            request = HttpRequest()
            request.session = SessionWrapper(obj.session_key)
            login(request, user)

            # Set the cookie to represent the session
            self.cookies[settings.SESSION_COOKIE_NAME] = obj.session_key
            self.cookies[settings.SESSION_COOKIE_NAME]['max-age'] = None
            self.cookies[settings.SESSION_COOKIE_NAME]['path'] = '/'
            self.cookies[settings.SESSION_COOKIE_NAME]['domain'] = settings.SESSION_COOKIE_DOMAIN
            self.cookies[settings.SESSION_COOKIE_NAME]['secure'] = settings.SESSION_COOKIE_SECURE or None
            self.cookies[settings.SESSION_COOKIE_NAME]['expires'] = None

            # Set the session values
            Session.objects.save(obj.session_key, request.session._session,
                datetime.datetime.now() + datetime.timedelta(seconds=settings.SESSION_COOKIE_AGE))        

            return True
        else:
            return False
            