from django.shortcuts import render
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from .models import Client
from .serializer import ClientModelSerializer
from rest_framework import status

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def client_list(request):
    clients = Client.objects.all()
    serializer = ClientModelSerializer(clients, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def client_detail(request):
    serializer = ClientModelSerializer(data=request.data)
    if serializer.is_valid():
        client = serializer.save()
        return Response({"client": serializer.data}, status=status.HTTP_200_OK)
    return Response({"message": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)