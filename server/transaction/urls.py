from django.urls import path
from . import views 

urlpatterns = [
    path('', view=views.transaction_list, name='transaction-list'),
    path('create/', view=views.transaction_create_or_update, name='transaction-create'),
    path('update/<uuid:pk>/', view=views.transaction_update, name='transaction-update'),
    path('delete/', view=views.transactions_delete, name='transactions-delete'),
    path('delete/<uuid:pk>/', view=views.transaction_delete, name='transaction-delete'),
]
