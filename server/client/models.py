from django.db import models

# Create your models here.
class Client(models.Model):
    name = models.CharField(max_length=200)
    phone = models.CharField(max_length=200)
    city = models.CharField(max_length=200)