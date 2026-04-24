from django.db import models
from authentication.models import User

# Create your models here.
class Client(models.Model):
    id = models.UUIDField(primary_key=True)
    user = models.ForeignKey(User, on_delete=models.CASCADE, related_name='clients')
    name = models.CharField(max_length=200)
    phone = models.CharField(max_length=200)
    city = models.CharField(max_length=200)
    is_deleted = models.BooleanField(default=False)

    def __str__(self):
        return f"{self.name}: {self.phone}: {'deleted' if self.is_deleted == True else ''}"