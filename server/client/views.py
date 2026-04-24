from django.shortcuts import render, get_object_or_404
from rest_framework.decorators import api_view, permission_classes, authentication_classes
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from .models import Client, User
from .serializers import ClientModelSerializer
from rest_framework import status
from django.db import transaction
from authentication.authentication import FirebaseAuthentication

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def client_list(request):
    # fetch by user
    clients = Client.objects.filter(user=request.user, is_deleted=False)
    serializer = ClientModelSerializer(clients, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['GET'])
@permission_classes([IsAuthenticated])
# @authentication_classes([FirebaseAuthentication])
def all_client_list(request):
    # fetch by user
    clients = Client.objects.all()
    serializer = ClientModelSerializer(clients, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['POST'])
@permission_classes([IsAuthenticated])
# @authentication_classes([FirebaseAuthentication])
def client_create_or_update(request):
    client_id = request.data.get('id')
    try:
        client = Client.objects.get(id=client_id)
        serializer = ClientModelSerializer(client, data=request.data)
    except:
        serializer = ClientModelSerializer(data=request.data)
    if serializer.is_valid():
        client = serializer.save(user=request.user)
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response({"message": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['PUT'])
@permission_classes([IsAuthenticated])
# @authentication_classes([FirebaseAuthentication])
def client_update(request, pk):
    client = get_object_or_404(Client, pk=pk, user=request.user)
    serializer = ClientModelSerializer(client, data=request.data, partial=True)
    if serializer.is_valid():
        client = serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)
    return Response({"message": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
@permission_classes([IsAuthenticated])
# @authentication_classes([FirebaseAuthentication])
def clients_delete(request):
    ids_to_delete = request.data.get('ids', [])
    with transaction.atomic():
        qs = Client.objects.filter(id__in=ids_to_delete, user=request.user)
        deleted_ids = list(qs.values_list('id', flat=True))
        qs.delete()
    # print(deleted_ids)
    return Response({"ids": deleted_ids}, status=status.HTTP_200_OK)

@api_view(['DELETE'])
@permission_classes([IsAuthenticated])
# @authentication_classes([FirebaseAuthentication])
def client_delete(request, pk):
    try:
        client = Client.objects.get(id=pk)
        # print('client found')
        serializer = ClientModelSerializer(client, data={'is_deleted': True}, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response({"details": "client deleted successfuly"}, status=status.HTTP_200_OK)
        # print('not valid')
        return Response({"details": "couldn't delete client"}, status=status.HTTP_400_BAD_REQUEST)
    except:
        # print('except here')
        return Response({"details": "couldn't delete client"}, status=status.HTTP_400_BAD_REQUEST)