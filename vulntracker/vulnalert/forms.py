from django.contrib.auth.models import User, Group
from vulntracker.vulnalert.models import UserProfile, Source, UserCriteria, AlertMethod, CriteriaType, CriteriaQualifier
from django import newforms as forms
from django.newforms.widgets import TextInput, PasswordInput, HiddenInput, MultipleHiddenInput, CheckboxInput, Select, NullBooleanSelect, SelectMultiple, CheckboxSelectMultiple, Textarea
from vulntracker.settings import SIMPLE_CRITERIA_TYPES

class ContactForm(forms.Form):
    """
    Contact form
    """

    # form inputs
    name  = forms.CharField()
    email = forms.EmailField()
    message = forms.CharField(widget=Textarea)

class LoginForm(forms.Form):
    """
    Creates LoginForm instance for general login
    """
    # form inputs
    username    = forms.CharField(max_length=30)
    password    = forms.CharField(widget=PasswordInput)


class SignupForm(LoginForm):
    """
    Creates signup form instance with custom validation
    """
    
    # form inputs
    email       = forms.EmailField()

    password2   = forms.CharField(widget=PasswordInput)

    first_name  = forms.CharField(max_length=30)
    last_name   = forms.CharField(max_length=30)
    where_heard = forms.CharField(max_length=100, required=False)


    def clean_password2(self):
        """
        Validates that the two password inputs match.
        """

        if self.cleaned_data.get('password', None) and self.cleaned_data.get('password2', None) and \
           self.cleaned_data['password'] == self.cleaned_data['password2']:
            return self.cleaned_data['password2']
        else:
            raise forms.ValidationError(u'The passwords did not match') 

    def clean_username(self):
        """
        Validates that username is not in use
        """
        username = self.cleaned_data.get('username', None)
        if username:
            try:
                User.objects.get(username=username)
                raise forms.ValidationError(u'username already exists, please choose another')
            except User.DoesNotExist:
                return username

    def save(self):
        """
        Overrides save method to commit user to database and set their profile and group information
        """
        user = User.objects.create_user( username=self.cleaned_data['username'], email=self.cleaned_data['email'], \
                                        password=self.cleaned_data['password'])
        user.first_name=self.cleaned_data['first_name']
        user.last_name=self.cleaned_data['last_name']
        # add user to 'users' group so we can easily deal with permissions
        group_user = Group.objects.get(name="users")
        user.groups.add(group_user)
        user.save()

        # add profile info
        user_profile = UserProfile(where_heard=self.cleaned_data['where_heard'], criteria_pref_type="simple", user=user)
        user_profile.save()
        return user

class PasswordChangeForm(forms.Form):
    """
    Change Password Form
    """

    def __init__(self, request=None, *args, **kwargs):
        super(forms.Form, self).__init__(*args, **kwargs)
        if request != None:
            self.request = request

    
    # form inputs
    password_cur   = forms.CharField(widget=PasswordInput)
    password       = forms.CharField(widget=PasswordInput)
    password2      = forms.CharField(widget=PasswordInput)


    def clean_password2(self):
        """
        Validates that the two password inputs match.
        """

        if self.cleaned_data.get('password', None) and self.cleaned_data.get('password2', None) and \
           self.cleaned_data['password'] == self.cleaned_data['password2']:
            return self.cleaned_data['password2']
        else:
            raise forms.ValidationError(u'The passwords did not match') 

    def clean_password_cur(self):
        """
        Validates that username is not in use
        """
        password_cur = self.cleaned_data.get('password_cur', None)
        if password_cur:
            if not self.request.user.check_password(password_cur):
                raise forms.ValidationError(u'password is incorrect')

    def save(self):
        """
        Overrides save method to change current user's password
        """
        password = self.cleaned_data['password']
        self.request.user.set_password(password)
        user.save()

        return user

class PasswordResetForm(forms.Form):
    """
    Checks for valid username or email address
    """

    # form inputs
    email       = forms.EmailField()


class PreferencesForm(forms.Form):
    """
    Returns basic preferences form containing:
        source(s) to search
        alert method(s)
        criteria
    """

    sources_choices = []
    for source in Source.objects.all():
        sources_choices.append( (source.id, source.name) )
    
    sources = forms.MultipleChoiceField(widget=CheckboxSelectMultiple(), choices = sources_choices, required=False)

    alert_methods_choices = ( ('mail', 'E-Mail'), ('rss', 'RSS'), )
    alert_methods = forms.MultipleChoiceField(widget=CheckboxSelectMultiple(), choices=alert_methods_choices, required=False)

    enable = forms.BooleanField( required=False )

    def save(self, user):
        """
        Overrides save method to add form values to the correct place in the db for this user
        """
        user_profile = user.get_profile()

        # set sources
        if self.cleaned_data.has_key('sources'):
            user_profile.sources.clear()
            for source_id in self.cleaned_data.get('sources', []):
                user_profile.sources.add(source_id)

        # set alert methods
        if self.cleaned_data.has_key('alert_methods'):
            user_profile.alert_methods.clear()
            for alert_method in self.cleaned_data.get('alert_methods', []):
                alert_method_obj = AlertMethod.objects.get(name=alert_method)
                user_profile.alert_methods.add(alert_method_obj)

            

class CriteriaFormAdv(forms.Form):

    attrs_dict = {}

    '''
    def __init__(self, **kwargs):
        super(forms.Form, self).__init__(**kwargs)
        if kwargs.has_key('attrs_dict'):
            self.attrs_dict = kwargs['attrs_dict']
    '''

    type_choices = []
    for type in CriteriaType.objects.all():
        if not type.name in SIMPLE_CRITERIA_TYPES:
            type_choices.append( (type.id, type.name) )
    type_choices.sort()

    type = forms.ChoiceField(widget=Select(attrs=attrs_dict), choices = type_choices)

    qualifier_choices = []
    for qualifier in CriteriaQualifier.objects.all():
        qualifier_choices.append( (qualifier.id, qualifier.desc) )
    qualifier_choices.sort()


    qualifier = forms.ChoiceField(widget=Select(attrs=attrs_dict), choices = qualifier_choices)

    value = forms.CharField(max_length=50, required=False )


    def clean_type(self):
        
        type_choice_ids = []
        for type in CriteriaType.objects.all():
            if not type.name in SIMPLE_CRITERIA_TYPES:
                type_choice_ids.append( type.id )

        type = int(self.data.get('type', None))
        if type == None or type not in type_choice_ids:
            raise forms.ValidationError(u"Criteria type is invalid, please try again --" + type + " -- " + str(type_choice_ids))
        else:
            return type

    def clean_qualifier(self):
        
        qualifier_choice_ids = []
        for qualifier in CriteriaQualifier.objects.all():
            qualifier_choice_ids.append( qualifier.id )

        qualifier = int(self.data.get('qualifier', None))
        if qualifier == None or qualifier not in qualifier_choice_ids:
            raise forms.ValidationError(u"Criteria qualifier is invalid, please try again")
        else:
            return qualifier

    def clean_value(self):
        # try a dummy sql call just to make sure the value will not raise an error
        value = self.data.get('value', None)
        return value


class CriteriaFormSimple(forms.Form):
    value = forms.CharField(max_length=50, required=False)

    '''
    def clean_value(self):
        value = self.data.get('value', None)
        return value
        # may want to validate version searches from simple form to be sure its in the form (#.)+ -- on the other hand may be better to be more flexible..?
        #for input_name in self.data.keys():
    '''
