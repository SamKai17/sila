from rest_framework import serializers
from .models import Client

class ClientModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Client
        fields = ['id', 'name', 'phone', 'city', 'user', 'is_deleted']
        extra_kwargs = {'user': {'read_only': True}}