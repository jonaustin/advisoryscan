from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.utils import simplejson 
from django.http import HttpResponse, Http404, HttpResponseBadRequest
from django.http import HttpResponseRedirect
from django.contrib.auth import login, logout, authenticate
from django.contrib.auth.decorators import login_required
from vulntracker.vulnalert.forms import SignupForm, LoginForm, PreferencesForm, CriteriaFormAdv, CriteriaFormSimple, PasswordChangeForm, PasswordResetForm, ContactForm
from vulntracker.vulnalert.models import UserCriteria, CriteriaType, CriteriaQualifier, User, Source, Message
from vulntracker.settings import SIMPLE_CRITERIA_TYPES, SITE_ROOT, SITE_NAME, ADMINS
from django.views.decorators.cache import cache_page

def index(request, template='index.html'):
    response_dict = {}
    sources = Source.objects.all()
    for source in sources:
        source.anchor = source.name.replace(' ', '-')
    response_dict['sources'] = sources
    
    return render_to_response(template, response_dict, context_instance=RequestContext(request) )

def about(request, template='about.html'):
    response_dict = {}
    sources = Source.objects.all()
    for source in sources:
        source.anchor = source.name.replace(' ', '-')
    response_dict['sources'] = sources
    
    return render_to_response(template, response_dict, context_instance=RequestContext(request) )

def contact(request, template='contact.html'):
    response_dict = {}
    if request.user.is_authenticated():
        response_dict['form_vals'] = {'name':request.user.first_name+' '+request.user.last_name, 'email':request.user.email}
    if request.method == "POST":
        response_dict['form'] = ContactForm( data=request.POST )
        if response_dict['form'].is_valid():
            response_dict['message'] = "Thank you for your comments!"

            email = response_dict['form'].cleaned_data['email']
            name  = response_dict['form'].cleaned_data['name']
            message = response_dict['form'].cleaned_data['message']

            # send email to me
            admin_email = ADMINS[0][1]
            from django.core.mail import send_mail
            message = """From: %s (%s)

%s
            """ % (name, email, message)

            send_mail(SITE_NAME+' Contact Form', message, email, [admin_email], fail_silently=False)

        else:
            # populate fields
            response_dict['form_vals'] = {}
            for input_name in request.POST.keys():
                response_dict['form_vals'][ input_name ] = request.POST[ input_name ]
    
    return render_to_response(template, response_dict, context_instance=RequestContext(request) )

def signup(request, template='signup.html', login_url=''):
    """
    Processes original signup to create a user on the site
    once validated successfully logs the user in and redirects to default user page
    """
    response_dict = {}
    response_dict['error_message'] = ''
    response_dict['debug'] = 'yes'
    if request.method == "POST":
        response_dict['form'] = SignupForm(request.POST)
        if not request.session.test_cookie_worked():
            response_dict['error_message'] = _("Looks like your browser isn't configured to accept cookies. Please enable cookies, reload this page, and try again.")
            request.session.set_test_cookie()
            return render_to_response(template, response_dict)
        elif response_dict['form'].is_valid():
            request.session.delete_test_cookie()
            user = response_dict['form'].save()
            request.session['from_signup'] = 'True'
            return HttpResponseRedirect(login_url)
    else:
        response_dict['form'] = SignupForm()
        request.session.set_test_cookie()
    return render_to_response(template, response_dict, context_instance=RequestContext(request) )

    
def login_form(request, template='login.html', next=''):
    """
    Processes original login to create a user on the site
    once validated successfully logs the user in and redirects to default user page
    """

    response_dict = {}
    (response_dict['message'], response_dict['error_message']) = ('','')
    next = request.REQUEST.get('next', next)
    if request.method == "POST":
        response_dict['form'] = LoginForm(request.POST)
        if not request.session.test_cookie_worked():
            response_dict['error_message'] = _("Looks like your browser isn't configured to accept cookies. Please enable cookies, reload this page, and try again.")
            request.session.set_test_cookie()
            return render_to_response(template, response_dict)
        else:
            is_valid = response_dict['form'].is_valid()
            if is_valid:
                data = request.POST.copy()
                user = authenticate(username=data['username'], password=data['password'])
                if user:
                    # if demo user, clear out all prev values entered
                    '''
                    if user.username == 'demo':
                        user_criteria_objs = UserCriteria.objects.filter( user=user )
                        for user_criteria in user_criteria_objs:
                            user_criteria.delete()
                    '''
                    login( request, user )
                    user_profile = request.user.get_profile()
                    criteria_pref_type = user_profile.criteria_pref_type
                    next = '../prefs_' + criteria_pref_type + '/'
                    return HttpResponseRedirect( next )
            if not is_valid or not user:
                """ Only return a generic error msg here for security -- otherwise they'd know if username or password was correct """
                response_dict['error_message'] = _("Please enter a correct username and password. Note that both fields are case-sensitive.")
            
    else:
        # if demo param then fill in demo info
        if request.GET.has_key('demo'):
            response_dict['username'] = 'demo'
            response_dict['password'] = 'demo'
        response_dict['form'] = LoginForm()
    if request.session.get('from_signup', None):
        del request.session['from_signup']
        response_dict['message'] = "Signup successful! Please login to continue"
    request.session.set_test_cookie()
    return render_to_response(template, response_dict, context_instance=RequestContext(request))

def logout_view(request):
    logout(request)
    return HttpResponseRedirect( SITE_ROOT )

def password_change(request, template):
    response_dict = {}
    if request.method == "POST":
        response_dict['form'] = PasswordChangeForm(data=request.POST, request=request)
        if response_dict['form'].is_valid():
            request.user.set_password( request.POST['password'] )
            request.user.save()
            request.user.message_set.create(message="Password Updated Successfully!")
    return render_to_response(template, response_dict, context_instance=RequestContext(request))

def password_reset(request, template):
    response_dict = {}
    if request.method == "POST":
        response_dict['form'] = PasswordResetForm(data=request.POST)
        if response_dict['form'].is_valid():
            try:
                email = response_dict['form'].cleaned_data['email']
                # set here since for security reasons we don't want to reveal whether they chose an existing email or not
                response_dict['message'] = "Password Reset Successfully for %s!" % email
                # check if this user exists
                user = User.objects.get(email=email)

                # create new random password and set it on user with email=email 
                from vulntracker.vulnalert.util import nicepass
                new_password = nicepass()
                user.set_password( new_password )
                user.save()

                # send to user in email
                from django.core.mail import send_mail
                message = """You (or someone else) has requested a password reset for your account at advisoryscan.net:
Here is your new password: %s

Sincerely,
    advisoryscan.net
                """ % new_password

                send_mail(SITE_NAME+' Password Reset', message, 'noreply@advisoryscan.net', [email], fail_silently=False)

            except User.DoesNotExist:
                pass
    return render_to_response(template, response_dict, context_instance=RequestContext(request))

def search_results(request, template='search_results.html'):
    """ 
    Return results from a message search
    search is contains == 'subject LIKE '%arg%'
    """
    
    response_dict = {}
    if request.method == "POST":
        search_term = request.POST['message_search']
        db_messages = Message.objects.filter(subject__icontains=search_term)
        if len(db_messages) == 1:
            return HttpResponseRedirect( SITE_ROOT + "messages/" + str(db_messages[0].id))
        else:
            response_dict['db_messages'] = db_messages

    return render_to_response(template, response_dict, context_instance=RequestContext(request))


def autocomplete(request):
    def iter_results(results):
        if results:
            for r in results:
                yield '%s\n' % (r.subject)
    
    if not request.GET.get('q'):
        return HttpResponse(mimetype='text/plain')
    
    q = request.GET.get('q')
    limit = request.GET.get('limit', 15)
    try:
        limit = int(limit)
    except ValueError:
        return HttpResponseBadRequest() 
    
    db_messages = Message.objects.filter(subject__contains=q).order_by('-id')[:limit]
    return HttpResponse(iter_results(db_messages), mimetype='text/plain')

autocomplete = cache_page(autocomplete, 60 * 60)



def user_prefs_simple(request, template='prefs_simple.html', adv_url='../prefs_advanced'):
    """ 
    Allow user to modify their preferences, specifically:
        Sources to search
        Alert Delivery Methods
        Criteria to search for (each set of values that make up a criterion is one instance of the criteria form)
    """
    
    # initialize vars
    response_dict = { 'forms':{} }
    response_dict['error_message'] = ''
    criteria_list = []
    criteria_valid_dict = {}
    criteria_valid_list = []

    if request.method == "POST":
        valid = True

        for input_name in request.POST.keys():
            # deal with multiple copies of the criteria form -- prefix allows each set to have a distinct naming scheme
            if input_name.startswith("criteria"):
                prefix = input_name.split('-')[0]
                input_value = request.POST.get(input_name, None)
                criteria = {'value':input_value}
                
                # django bug #3969: very unfortunately django's newforms cannot handle a situation where a post returns both any errors and the values submitted when using name prefixes
                # so we'll have to create a list of forms for display (criteria_list), and a dict for validation
                # addendum -- forms class totally fails if bound to a dict and prefix is set -- apparently loses track of the name<->form_var mapping so going to have to explicitly create
                # errors...
                # update: once newforms.formsets is finalized (i.e. available in trunk instead of just newforms-admin branch) -- this will change to use that much cleaner scheme
                criteria_form_valid = CriteriaFormSimple( criteria )

                # transform things so the errors show up
                criteria_form = CriteriaFormSimple( initial=criteria, prefix=prefix )
                if criteria_form_valid.errors != {}:
                    valid = False
                    for key in criteria_form_valid.errors:
                        criteria_form.errors[key] = criteria_form_valid.errors[key]
                else:
                    # append a tuple of (prefix, form) since we can't get the prefix otherwise
                    criteria_valid_list.append( (prefix, criteria_form_valid) )

                criteria_list.append( criteria_form )

        # update the response (will propogate to render at end of function)
        response_dict['forms']['criteria_list'] = criteria_list
        response_dict['forms']['prefs'] = PreferencesForm(request.POST)

        if valid and response_dict['forms']['prefs'].is_valid():
            # set simple as default if enable exists in post, else disable it
            profile = request.user.get_profile()
            if request.POST.has_key('enable'):
                profile.criteria_pref_type = 'simple'
            else:
                profile.criteria_pref_type = 'advanced'
            profile.save()
            response_dict['forms']['prefs'].save(request.user)
            for (prefix, criteria) in criteria_valid_list:
                type   = prefix.split('_')[1]
                criteria_type = CriteriaType.objects.get(name=type) # name/version
                qualifier     = CriteriaQualifier.objects.get(name='contains')
                if prefix.split('_')[-1] == 'new' and criteria.cleaned_data['value'] != '':
                    # create new criteria
                    user_criteria = UserCriteria( user=request.user, criteria_type=criteria_type, qualifier=qualifier, value=criteria.cleaned_data['value'] )
                    user_criteria.save()
                elif prefix.split('_')[-1] == 'new' and criteria.cleaned_data['value'] == '':
                    continue
                elif criteria.cleaned_data['value'] == '':
                    # user set existing criteria to blank so delete it from db
                    criteria_id = prefix.split('_')[-1]
                    user_criteria = UserCriteria.objects.get( id=criteria_id )
                    user_criteria.delete()
                else:
                    # modify existing criteria
                    criteria_id = prefix.split('_')[-1]
                    user_criteria = UserCriteria.objects.get( id=criteria_id)
                    user_criteria.value = criteria.data['value'] # this makes no sense... everything validates but cleaned_data is not populated, no biggie, just weird
                    user_criteria.save()
            request.user.message_set.create(message="Preferences Update Successfully!")
            # reload the newly entered/changed database values
            return HttpResponseRedirect( "." )
        else:
            response_dict['messages'] = response_dict['forms']['prefs'].errors
            
    else:
        # initial load so grab from user's prefs in db
        user_prefs_dict = {}
        user_profile = request.user.get_profile()
        user_prefs_dict['alert_methods'] = [k['name'] for k in user_profile.alert_methods.values()]
        user_prefs_dict['sources'] = [k['id'] for k in user_profile.sources.values()]
        if user_profile.criteria_pref_type == 'simple':
            user_prefs_dict['enable'] = True

        user_criteria_objs = UserCriteria.objects.filter( user=request.user )
        user_criteria_dict = {}
        for user_criteria in user_criteria_objs:
            criteria_type_name = user_criteria.criteria_type.name
            if criteria_type_name in SIMPLE_CRITERIA_TYPES:
                criteria_list.append(CriteriaFormSimple( initial={'value':user_criteria.value, }, prefix="criteria_"+criteria_type_name+'_'+str(user_criteria.id)) )

        # update the response dict
        response_dict['forms']['criteria_list'] = criteria_list
        response_dict['forms']['prefs'] = PreferencesForm( initial=user_prefs_dict )

    #response_dict['forms']['criteria_list'] = [ CriteriaFormSimple( {'value':'bleh'})  ]
    response_dict['advanced_prefs_url'] = adv_url
    return render_to_response(template, response_dict, context_instance=RequestContext(request))
    


def user_prefs_advanced(request, template='prefs_adv.html', simple_url='../prefs_simple'):
    """ 
    Allow user to modify their preferences, specifically:
        Sources to search
        Alert Delivery Methods
        Criteria to search for
    """

    # initialize vars
    response_dict = { 'forms':{} }
    response_dict['error_message'] = ''
    criteria_list = []
    criteria_valid_list = []

    if request.method == "POST":
        valid = True
        # collect each set that corresponds to a user_criteria id
        criteria_dict = {}
        
        for input_name in request.POST.keys():
            # here we must deal with multiple copies of the criteria form -- prefix allows each set to have a distinct naming scheme
            if input_name.startswith("criteria"):
                prefix = input_name.split('-')[0]
                input_type = input_name.split('-')[1] #i.e. type/qualifier/value
                #change this when we allow js/dom criteria additions
                criteria_id = prefix.split('_')[1]
                # combine all three inputs for each set into one for simpler access
                if not criteria_dict.has_key( criteria_id ):
                    criteria_dict[ criteria_id ] = {}
                criteria_dict[ criteria_id ][ input_type ] = request.POST[ input_name ]
                if not criteria_dict[ criteria_id ].has_key('prefix'):
                    criteria_dict[ criteria_id ]['prefix'] = prefix


        for criteria_id in criteria_dict.keys():
            # django bug #3969: very unfortunately django's newforms cannot handle a situation where a post returns both any errors and the values submitted when using name prefixes
            # so for now we'll have to hack around it a bit by making two separate lists - one for form return and one for validation
            # addendum -- forms class totally fails if bound to a dict and prefix is set -- apparently loses track of the name<->form_var mapping so going to have to explicitly create
            # errors...
            # update: once newforms.formsets is finalized (i.e. available in trunk instead of just newforms-admin branch) -- this will change to use that much clean scheme
            criteria = criteria_dict[criteria_id]
            criteria_form_valid = CriteriaFormAdv( criteria )

            # transform things so the errors show up
            criteria_form = CriteriaFormAdv( initial=criteria, prefix=criteria['prefix'] )
            for key in criteria_form_valid.errors:
                criteria_form.errors[key] = criteria_form_valid.errors[key]
            if criteria_form.errors != {}:
                valid = False
            criteria_list.append( criteria_form )

            criteria_valid_list.append( criteria_form )

        response_dict['forms']['criteria_list'] = criteria_list
        response_dict['forms']['prefs'] = PreferencesForm(request.POST)

        # update database
        if valid and response_dict['forms']['prefs'].is_valid():
            request.user.message_set.create(message="Preferences Update Successfully!")
            response_dict['forms']['prefs'].save(request.user)
            for criteria_id in criteria_dict.keys():
                criteria = criteria_dict[ criteria_id ]
                if criteria_id == 'new' and criteria['value'] != '':
                    # create new criteria set
                    user_criteria = UserCriteria( user=request.user, criteria_type_id=criteria['type'], qualifier_id=criteria['qualifier'], value=criteria['value'] )
                    user_criteria.save()
                elif criteria_id == 'new' and criteria['value'] == '':
                    continue
                elif criteria['value'] == '':
                    # user set existing criteria to blank so delete it from db
                    user_criteria = UserCriteria.objects.get( id=criteria_id )
                    user_criteria.delete()
                else:
                    user_criteria = UserCriteria.objects.get( id=criteria_id )
                    user_criteria.criteria_type_id  = criteria['type']
                    user_criteria.qualifier_id      = criteria['qualifier']
                    user_criteria.value             = criteria['value']
                    user_criteria.save()
            # set advanced as default if enable exists in post, else disable it
            profile = request.user.get_profile()
            if request.POST.has_key('enable'):
                profile.criteria_pref_type = 'advanced'
            else:
                profile.criteria_pref_type = 'simple'
            profile.save()
            # reload the newly entered/changed database values
            return HttpResponseRedirect( "." )

    else:
        # initial load so grab from user's prefs in db
        user_prefs_dict = {}
        user_profile = request.user.get_profile()
        user_prefs_dict['alert_methods'] = [k['name'] for k in user_profile.alert_methods.values()]
        user_prefs_dict['sources'] = [k['id'] for k in user_profile.sources.values()]
        if user_profile.criteria_pref_type == 'advanced':
            user_prefs_dict['enable'] = True

        criteria_list = []

        user_criteria_objs = UserCriteria.objects.filter( user=request.user )
        for user_criteria in user_criteria_objs:
            if user_criteria.criteria_type.name in SIMPLE_CRITERIA_TYPES:
                continue
            user_criteria_dict = {}
            user_criteria_dict['type'] = user_criteria.criteria_type.id
            user_criteria_dict['qualifier'] = user_criteria.qualifier.id
            user_criteria_dict['value'] = user_criteria.value
            criteria_list.append( CriteriaFormAdv( initial=user_criteria_dict, prefix='criteria_'+str(user_criteria.id) ) )

        response_dict['forms']['prefs'] = PreferencesForm( initial=user_prefs_dict )
        response_dict['forms']['criteria_list'] = criteria_list

    response_dict['simple_prefs_url'] = simple_url
    return render_to_response(template, response_dict, context_instance=RequestContext(request))


def user_messages(request, template):
    response_dict = {}
    user_profile = request.user.get_profile()
    messages = user_profile.messages.all().order_by('-id')
    if messages.count() > 0:
        response_dict['user_messages'] = messages
    else:
        response_dict['mess'] = "There are currently no messages that have matched your criteria"
    return render_to_response(template, response_dict, context_instance=RequestContext(request))
