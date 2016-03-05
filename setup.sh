# Install Django and Django REST framework
pip install Django==1.9.2
pip install djangorestframework

# Set up a new project with a single application
django-admin.py startproject tutorial .
cd tutorial
django-admin.py startapp quickstart
cd ..

# Sync db for the first time to create initial tables
python manage.py migrate

# Create initial user named 'admin' with password 'password123'
python manage.py createsuperuser

# Create new Serializers module
touch tutorial/quickstart/serializers.py
