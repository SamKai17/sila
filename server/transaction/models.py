from django.db import models
from client.models import Client

class Transaction(models.Model):
    TRANSACTION_TYPE = {
        'Buy': 'Buy',
        'Sell': 'Sell'
    }
    id = models.UUIDField(primary_key=True)
    total_price = models.DecimalField(max_digits=10, decimal_places=2)
    total_paid = models.DecimalField(max_digits=10, decimal_places=2)
    remainder = models.DecimalField(max_digits=10, decimal_places=2)
    time_of_transaction = models.PositiveBigIntegerField()
    type = models.CharField(max_length=4, choices=TRANSACTION_TYPE)
    client = models.ForeignKey(Client, on_delete=models.CASCADE, related_name='transactions')

class Item(models.Model):
    id = models.UUIDField(primary_key=True)
    name = models.CharField(max_length=200)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    quantity = models.PositiveIntegerField()
    transaction = models.ForeignKey(Transaction, on_delete=models.CASCADE, related_name='items')

class Payment(models.Model):
    id = models.UUIDField(primary_key=True)
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    time_of_payment = models.PositiveBigIntegerField()
    transaction = models.ForeignKey(Transaction, on_delete=models.CASCADE, related_name='payments')