from django.urls import path
from . import views 

urlpatterns = [
    path('clients/', views.client_list, name='client-list'),
    path('client/all/', views.all_client_list, name='all-client-list'),
    path('client/', views.client_create, name='client-create'),
    path('client/<int:pk>/', views.client_update, name='client-update'),
    path('clients/delete/', views.client_delete, name='client-delete'),
]
