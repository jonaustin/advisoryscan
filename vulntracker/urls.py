from django.conf.urls.defaults import *
from vulnalert.feeds import UserFeeds

feeds_dict = {'users':UserFeeds}

urlpatterns = patterns('',
     (r'^', include('vulntracker.vulnalert.urls')),

     (r'^admin/', include('django.contrib.admin.urls')),
     (r'^feeds/(?P<url>.*)/$', 'django.contrib.syndication.views.feed', {'feed_dict':feeds_dict} ),
)
