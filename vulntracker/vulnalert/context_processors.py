"""
A set of request processors that return dictionaries to be merged into a
template context. Each function takes the request object as its only parameter
and returns a dictionary to add to the context.

These are referenced from the setting TEMPLATE_CONTEXT_PROCESSORS and used by
RequestContext.
"""

from vulntracker import settings

def globals ( request ):
    """
    Return context variables that are needed by this app
    """

    #get criteria_pref_type for cur user
    if ( request.user.is_authenticated() ):
        user_profile = request.user.get_profile()
        criteria_pref_type = user_profile.criteria_pref_type
    else:
        criteria_pref_type = None

    return {
            'criteria_pref_type':criteria_pref_type,
            'site_root':settings.SITE_ROOT,
            'site_name':settings.SITE_NAME,
    }


