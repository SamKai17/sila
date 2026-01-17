from django.urls import path
from .views import protected_view

urlpatterns = [
    path('test/', protected_view, name='test_view'),
]
