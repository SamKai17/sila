from django.urls import path
from . import views 

urlpatterns = [
    path('clients/', views.client_list, name='client-list'),
    path('client/', views.client_detail, name='client-detail'),
]
