from django.contrib import admin
from .models import Transaction, Item, Payment

# Register your models here.

admin.site.register(Transaction)
admin.site.register(Item)
admin.site.register(Payment)