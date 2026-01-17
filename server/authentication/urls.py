from django.urls import path
from . import views

urlpatterns = [
    path('register/', views.registration, name='registration'),
    path('login/', views.login, name='login'),
    path('', views.user_detail, name='user-detail'),
]