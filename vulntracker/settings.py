# Django settings for vulntracker project.

DEBUG = False
TEMPLATE_DEBUG = DEBUG

ADMINS = (
    ('jon', 'jon.i.austin@gmail.com'),
    # ('Your Name', 'your_email@domain.com'),
)

MANAGERS = ADMINS

DATABASE_ENGINE = 'mysql_old'           # 'postgresql_psycopg2', 'postgresql', 'mysql', 'sqlite3' or 'ado_mssql'.
DATABASE_NAME = 'advisoryscan'             # Or path to database file if using sqlite3.
DATABASE_USER = 'advisoryscan'             # Not used with sqlite3.
DATABASE_PASSWORD = 'go1984'         # Not used with sqlite3.
DATABASE_HOST = 'mysql.advisoryscan.net'             # Set to empty string for localhost. Not used with sqlite3.
DATABASE_PORT = '3306'             # Set to empty string for default. Not used with sqlite3.

# Local time zone for this installation. Choices can be found here:
# http://www.postgresql.org/docs/8.1/static/datetime-keywords.html#DATETIME-TIMEZONE-SET-TABLE
# although not all variations may be possible on all operating systems.
# If running in a Windows environment this must be set to the same as your
# system time zone.
TIME_ZONE = 'America/Los_Angeles'

# Language code for this installation. All choices can be found here:
# http://www.w3.org/TR/REC-html40/struct/dirlang.html#langcodes
# http://blogs.law.harvard.edu/tech/stories/storyReader$15
LANGUAGE_CODE = 'en-us'

SITE_ID = 1

# If you set this to False, Django will make some optimizations so as not
# to load the internationalization machinery.
USE_I18N = False

# Absolute path to the directory that holds media.
# Example: "/home/media/media.lawrence.com/"
MEDIA_ROOT = '/home/jonaustin/advisoryscan.net/vulntracker/media/'

# URL that handles the media served from MEDIA_ROOT.
# Example: "http://media.lawrence.com"
MEDIA_URL = 'http://advisoryscan.net/media'

# URL prefix for admin media -- CSS, JavaScript and images. Make sure to use a
# trailing slash.
# Examples: "http://foo.com/media/", "/media/".
ADMIN_MEDIA_PREFIX = '/admin_media/'



# Make this unique, and don't share it with anybody.
SECRET_KEY = 'adlkfj#%#$&KJ%L@#K$JL#K$J3452l345jl3$%@#%$Lj='

# List of callables that know how to import templates from various sources.
TEMPLATE_LOADERS = (
    'django.template.loaders.filesystem.load_template_source',
    'django.template.loaders.app_directories.load_template_source',
#     'django.template.loaders.eggs.load_template_source',
)

MIDDLEWARE_CLASSES = (
    'django.middleware.common.CommonMiddleware',
    'django.contrib.sessions.middleware.SessionMiddleware',
    'django.contrib.auth.middleware.AuthenticationMiddleware',
    'django.middleware.doc.XViewMiddleware',
)

ROOT_URLCONF = 'vulntracker.urls'

TEMPLATE_DIRS = (
    # Put strings here, like "/home/html/django_templates" or "C:/www/django/templates".
    # Always use forward slashes, even on Windows.
    # Don't forget to use absolute paths, not relative paths.
    '/home/jonaustin/django/django_projects/vulntracker/templates'
)

INSTALLED_APPS = (
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.sites',
    'django.contrib.admin',
    'vulntracker.vulnalert',
)

AUTH_PROFILE_MODULE = "vulnalert.UserProfile"

AUTHENTICATION_BACKENDS = ( 'vulntracker.auth.auth_email.EmailBackend', )

INTERNAL_IPS = ('0.0.0.0',)

# override globals
TEMPLATE_CONTEXT_PROCESSORS = (
    'django.core.context_processors.auth',
    'django.core.context_processors.debug',
    'django.core.context_processors.i18n',
    'vulntracker.vulnalert.context_processors.globals',
#    'django.core.context_processors.request',
)

SESSION_EXPIRE_AT_BROWSER_CLOSE = True   # Whether sessions expire when a user closes his browser.

CACHE_BACKEND = 'locmem:///'

# my settings
SIMPLE_CRITERIA_TYPES = ('name', 'version')

SITE_ROOT = "/"

SITE_NAME = "advisoryscan.net"

