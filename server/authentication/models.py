from django.db import models
from django.contrib.auth.models import AbstractUser

# Create your models here.
class User(AbstractUser):
    firebase_uid = models.CharField(max_length=128, unique=True)
    phone_number = models.CharField(max_length=20, unique=True)
    def __str__(self):
        return f"{self.firebase_uid or self.username}: {self.phone_number}"