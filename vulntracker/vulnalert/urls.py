from django.conf.urls.defaults import *
from vulntracker.vulnalert.models import Message

info_dict = { 'queryset' : Message.objects.all().order_by('id') }

urlpatterns = patterns('',
    (r'^$', 'vulntracker.vulnalert.views.index', {'template':'index.html'}),
    
    (r'^about/$', 'vulntracker.vulnalert.views.about', {'template':'about.html'}),
    (r'^contact/$', 'vulntracker.vulnalert.views.contact', {'template':'contact.html'}),
    
    (r'^accounts/signup/$', 'vulntracker.vulnalert.views.signup', {'template':'signup.html', 'login_url':'/accounts/login'}),
    (r'^accounts/login/$', 'vulntracker.vulnalert.views.login_form', {'template':'login.html', 'next':'/accounts/prefs_simple'}),
    (r'^accounts/logout/$', 'vulntracker.vulnalert.views.logout_view'),
    (r'^accounts/password_change/$', 'vulntracker.vulnalert.views.password_change', {'template':'password_change.html'}),
    (r'^accounts/password_reset/$', 'vulntracker.vulnalert.views.password_reset', {'template':'password_reset.html'}),

    (r'^accounts/prefs_simple/$', 'vulntracker.vulnalert.views.user_prefs_simple', {'template':'prefs_simple.html'}),
    (r'^accounts/prefs_advanced/$', 'vulntracker.vulnalert.views.user_prefs_advanced', {'template':'prefs_advanced.html'}),
    (r'^accounts/messages/$', 'vulntracker.vulnalert.views.user_messages', {'template':'user_messages.html'}),
    
    (r'^messages/(?P<object_id>\d+)/$', 'django.views.generic.list_detail.object_detail', dict( info_dict, template_name='message_detail.html' )),
    (r'^messages/results/$', 'vulntracker.vulnalert.views.search_results', {'template':'search_results.html'} ),
    (r'^messages/autocomplete/$', 'vulntracker.vulnalert.views.autocomplete' ),
)
