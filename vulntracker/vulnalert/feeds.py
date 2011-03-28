from django.contrib.syndication.feeds import Feed
from models import User, UserProfile

class UserFeeds(Feed):
    def get_object(self, bits):
        # In case of "/rss/Users/0613/foo/bar/baz/", or other such clutter,
        # check that bits has only one member.
        if len(bits) != 1:
            raise ObjectDoesNotExist
        return User.objects.get(username__exact=bits[0])

    def title(self, obj):
        return "%s's criteria matches" % obj.username

    def link(self):
        return "http://advisoryscan.net"

    def item_link(self, obj):
        return "http://advisoryscan.net/messages/"+str(obj.id)

    def description(self, obj):
        return "Messages matching criteria for %s" % obj.username

    def items(self, obj):
        profile = obj.get_profile()
        return profile.messages.all()
