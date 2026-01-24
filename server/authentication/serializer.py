from rest_framework import serializers
from django.contrib.auth.models import User
from django.contrib.auth import authenticate

class UserModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username']

class RegistrationModelSerializer(serializers.ModelSerializer):
    confirm_password = serializers.CharField()
    class Meta:
        model = User
        fields = ['id', 'username', 'confirm_password', 'password']
        extra_kwargs = {'password': {'write_only': True}}
    
    def create(self, validated_data):
        username = validated_data.get('username')
        password = validated_data.get('password')
        confirm_password = validated_data.get('confirm_password')
        if password != confirm_password:
            raise serializers.ValidationError('Unable to login with passwords not matching')
        user = User.objects.create_user(username=username, password=password)
        return user


class LoginSerializer(serializers.Serializer):
    username = serializers.CharField()
    password = serializers.CharField(write_only=True)

    def validate(self, data):
        username = data.get('username')
        password = data.get('password')
        user = authenticate(username=username, password=password)
        if not user:
            raise serializers.ValidationError('Unable to login with provided credentials')
        data['user'] = user
        return data