from django.shortcuts import render, get_object_or_404
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from .models import Client, User
from .serializer import ClientModelSerializer
from rest_framework import status
from django.db import transaction

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def client_list(request):
    print(request.user)
    # fetch by user
    clients = Client.objects.filter(user=request.user)
    serializer = ClientModelSerializer(clients, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def all_client_list(request):
    # fetch by user
    clients = Client.objects.all()
    serializer = ClientModelSerializer(clients, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def client_create(request):
    serializer = ClientModelSerializer(data=request.data)
    if serializer.is_valid():
        client = serializer.save(user=request.user)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response({"message": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def client_update(request, pk):
    client = get_object_or_404(Client, pk=pk, user=request.user)
    serializer = ClientModelSerializer(client, data=request.data, partial=True)
    if serializer.is_valid():
        client = serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)
    return Response({"message": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def client_delete(request):
    ids_to_delete = request.data.get('ids', [])
    with transaction.atomic():
        qs = Client.objects.filter(id__in=ids_to_delete, user=request.user).select_for_update()
        deleted_ids = list(qs.values_list('id', flat=True))
        qs.delete()
    print(deleted_ids)
    return Response({"ids": deleted_ids}, status=status.HTTP_200_OK)