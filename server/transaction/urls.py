from django.urls import path
from . import views 

urlpatterns = [
    path('', view=views.transaction_list, name='transaction-list'),
    path('create/', view=views.transaction_create, name='transaction-create'),
    path('update/<int:pk>/', view=views.transaction_update, name='transaction-update'),
    path('delete/', view=views.transaction_delete, name='transaction-delete'),
]
