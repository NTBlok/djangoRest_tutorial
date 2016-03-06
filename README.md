### Django Rest Framework Tutorial - Create a simple API to allow admin users to view and edit the users and groups in the system

This is my walkthrough of the django rest framework tutorial at url: http://www.django-rest-framework.org/tutorial/quickstart/

Create project directory

    mkdir tutorial
    cd tutorial

Create a virtualenv and activate it and add the new path

    virtualenv env 
    source env/bin/activate
    export VIRTUAL_ENV="$(pwd)"/env
    export PATH="$VIRTUAL_ENV/bin:$PATH"

Verify the path is now pointing to the virtual env

    which python

Initial setup once virtualenv is active

    ../setup.sh

Define some serializers by editing tutorial/quickstart/serializers.py

    from django.contrib.auth.models import User, Group
    from rest_framework import serializers

    class UserSerializer(serializers.HyperlinkedModelSerializer):
        class Meta:                
            model = User           
            fields = ('url', 'username', 'email', 'groups')
                            
    class GroupSerializer(serializers.HyperlinkedModelSerializer):
        class Meta:                
            model = Group          
            fields = ('url', 'name')

Write some views by editing tutorial/quickstart/views.py

    from django.contrib.auth.models import User, Group
    from rest_framework imort viewsets
    from tutorial.quickstart.serializers import UserSerializer, GroupSerializer
    
    class UserViewSet(viewsets.ModelViewSet):
        """API endpoint that allows users to be viewed or edited."""
        queryset = User.objects.all(0.order_by('-date_joined')
        serializer_class = UserSerializer
    
    class GroupViewSet(viewsets.ModelViewSet):
        """API endpoint that allows groups to be viewed or edited."""
        queryset = Group.objects.all()
        serializer_class = GroupSerializer

Wire up the API URLs by editing tutorial/urls.py

    from django.conf.urls import url, include
    from rest_framework import routers
    from tutorial.quickstart import views
        
    # Register the viewsets with a router class to automatically generate the URL conf for our API
    # The alternative is to use regular clas based views and write the URL conf explicitly for more control over the API URLs
    
    router = routers.DefaultRouter()
    router.register(r'users', views.UserViewSet)
    router.register(r'groups', views.GroupViewSet)

    urlpatterns = [
        url(r'^', include(router.urls)),
        url(r'^api-auth/', include('rest_framework.urls', namespace='rest_framework'))
    ]

Edit tutorial/settings.py to turn on pagination and set permissions for admin users

    INSTALLED_APPS = [
    'rest_framework',
    ]

    REST_FRAMEWORK = {
    'DEFAULT_PERMISSION_CLASSES': ('rest_framework.permissions.IsAdminUser',),
    'PAGE_SIZE': 10
    }

Now try out the api

    python manage.py runserver 0.0.0.0:8000

Point browser to address-of-server/users/ and login
