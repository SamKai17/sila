from rest_framework import serializers
from .models import Client

class ClientModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Client
        fields = ['id', 'user', 'name', 'phone', 'city']
        extra_kwargs = {'user': {'read_only': True}}