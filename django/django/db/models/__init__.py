from django.conf import settings
from django.core.exceptions import ObjectDoesNotExist, ImproperlyConfigured
from django.core import validators
from django.db import backend, connection
from django.db.models.loading import get_apps, get_app, get_models, get_model, register_models
from django.db.models.query import Q
from django.db.models.manager import Manager
from django.db.models.base import Model, AdminOptions
from django.db.models.fields import *
from django.db.models.fields.related import ForeignKey, OneToOneField, ManyToManyField, ManyToOneRel, ManyToManyRel, OneToOneRel, TABULAR, STACKED
from django.db.models import signals
from django.utils.functional import curry
from django.utils.text import capfirst

# Admin stages.
ADD, CHANGE, BOTH = 1, 2, 3

# Decorator. Takes a function that returns a tuple in this format:
#     (viewname, viewargs, viewkwargs)
# Returns a function that calls urlresolvers.reverse() on that data, to return
# the URL for those parameters.
def permalink(func):
    from django.core.urlresolvers import reverse
    def inner(*args, **kwargs):
        bits = func(*args, **kwargs)
        viewname = bits[0]
        return reverse(bits[0], None, *bits[1:3])
    return inner
