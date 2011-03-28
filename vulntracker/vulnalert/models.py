""" 
    Database models for ORM
"""

from django.db import models
from django.contrib.auth.models import User


class MessageType(models.Model):
    name = models.CharField("name of message type", maxlength=25, unique=True)
    desc = models.TextField()

    class Meta:
        db_table = 'message_type'

    def __str__(self):
        return "%s" % (self.name)

    class Admin:
        pass

class Source(models.Model):
    name            = models.CharField(maxlength=50)
    email           = models.EmailField(maxlength=50)
    email_password  = models.CharField(maxlength=50)
    email_server    = models.CharField(maxlength=50)
    url             = models.URLField(blank=True, maxlength=100)
    desc            = models.CharField(blank=True, maxlength=150)
    desc_long       = models.TextField(blank=True)
    message_type    = models.ForeignKey(MessageType)

    def __str__(self):
        return "%s" % (self.name) 

    class Meta:
        db_table        = 'source'
        unique_together = ( ('name', 'message_type'), )
        ordering        = ['name']

    class Admin:
        pass

class Message(models.Model):
    text            = models.TextField()
    subject         = models.CharField(maxlength=250, db_index=True)
    body            = models.TextField()
    message_type    = models.ForeignKey(MessageType)
    source          = models.ForeignKey(Source)
    is_processed    = models.BooleanField()
    is_mailed       = models.BooleanField()

    def __str__(self):
        return "%s" % (self.subject) 

    class Meta:
        unique_together = ( ('subject', 'source'), ) 
        db_table = 'message'

    class Admin:
        pass

class CriteriaType(models.Model):
    INPUT_TYPE_CHOICES = (
            ('text', 'text'),
            ('checkbox', 'checkbox'),
            ('radio', 'radio buttons'),
            ('select', 'select dropdown'),
    )

    CRITERIA_PREF_TYPE_CHOICES = (
            ('simple', 'simple'),
            ('advanced','advanced'),
    )

    name         = models.CharField(maxlength=50, unique=True)
    search_field = models.CharField(maxlength=50)
    desc         = models.TextField(blank=True)
    input_type   = models.CharField(maxlength=50, choices=INPUT_TYPE_CHOICES, radio_admin=True)
    criteria_pref_type = models.CharField(maxlength=50, choices=CRITERIA_PREF_TYPE_CHOICES, radio_admin=True)

    def __str__(self):
        return "%s" % (self.name) 

    class Meta:
        db_table = 'criteria_type'

    class Admin:
        pass

class CriteriaQualifier(models.Model):

    name        = models.CharField(maxlength=50)
    desc        = models.CharField(maxlength=150, blank=True)
    sql         = models.CharField(maxlength=150)
    rose        = models.CharField(maxlength=50)
    rose_sql    = models.CharField(maxlength=50)

    def __str__(self):
        return "%s" % (self.name)

    class Meta:
        db_table = 'qualifier'

    class Admin:
        pass

#--------------------------------------------------
# Note: I think this model should work, except not sure what to do with 'item' -- maybe split it into 3 different columns,
#           user_criteria_id, qualifier_id, connector_id, and only one of them should ever have a value ?
#
# class CriteriaChain(models.Model):
#     item        # can be one of user criteria (i.e. one set of "subject contains bleh") or qualifier (contains,is,...) or connector -- '( ) and or' 
#     order       # i.e. this is item #7 in the chain
# 
# class Connector(models.Model):
#     value       # i.e. "( ) and or ..."
#-------------------------------------------------- 

class UserCriteria(models.Model):
    user            = models.ForeignKey(User, edit_inline=models.TABULAR)
    criteria_type   = models.ForeignKey(CriteriaType)
    qualifier       = models.ForeignKey(CriteriaQualifier)
    value           = models.CharField(maxlength=50, core=True)

    def __str__(self):
        return "%s" % (self.value) 

    class Meta:
        db_table = 'user_criteria'

class AlertMethod(models.Model):
    name        = models.CharField(maxlength=50, unique=True)
    desc        = models.CharField(maxlength=100)
    desc_long   = models.TextField(blank=True)

    def __str__(self):
        return "%s" % (self.name) 

    class Meta:
        db_table = 'alert_method'

    class Admin:
        pass

class UserProfile(models.Model):
    TYPE_CHOICES = (
            ('simple', 'simple'),
            ('advanced', 'advanced'),
    )

    user          = models.ForeignKey(User, unique=True, edit_inline=models.TABULAR,
                    num_in_admin=1,min_num_in_admin=1, max_num_in_admin=1,num_extra_on_change=0)
    where_heard   = models.CharField(maxlength=250, core=True)
    criteria_pref_type = models.CharField(maxlength=50, choices=TYPE_CHOICES, radio_admin=True, core=True)
    sources       = models.ManyToManyField(Source, db_table='user_sources', blank=True)
    alert_methods = models.ManyToManyField(AlertMethod, db_table='user_alert_methods', blank=True)
    messages      = models.ManyToManyField(Message, db_table='user_messages', blank=True)

    def __str__(self):
        return "%s" % (self.user.username)

    class Meta:
        db_table = 'user_profile'



#--------------------------------------------------
# NOTE: Currently unused
# class App(models.Model):
#     name = models.CharField(maxlength=150, unique=True)
# 
#     def __str__(self):
#         return "%s" % (self.name) 
# 
#     class Meta:
#         db_table = 'app'
# 
# class AppVersion(models.Model):
#     app         = models.ForeignKey(App)
#     version     = models.CharField(maxlength=50)
# 
#     def __str__(self):
#         return "%s, %s" % (self.app, self.version) 
# 
#     class Meta:
#         db_table = 'app_version'
# 
# class Advisory(models.Model):
#     message     = models.ForeignKey(Message)
#     app         = models.ForeignKey(App)
#     version     = models.CharField(blank=True, maxlength=25)
#     text        = models.TextField()
# 
#     def __str__(self):
#         return "%s, %s" % (self.app, self.version) 
# 
#     class Meta:
#         db_table = 'advisory'
#-------------------------------------------------- 

