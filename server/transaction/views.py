from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from .models import Transaction
from .serializers import TransactionModelSerializer
from django.db import transaction

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def transaction_list(request):
    transactions = Transaction.objects.all()
    serializer = TransactionModelSerializer(transactions, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def transaction_create_or_update(request):
    transaction_id = request.data.get('id')
    try:
        transaction = Transaction.objects.get(id=transaction_id)
        serializer = TransactionModelSerializer(transaction, data=request.data, partial=True)
    except:
        serializer = TransactionModelSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    print(serializer.errors)
    # print(serializer.error_messages)
    return Response({"message": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def transaction_update(request, pk):
    transaction = Transaction.objects.get(pk=pk)
    serializer = TransactionModelSerializer(transaction, data=request.data, partial=True)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)
    return Response({"message": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def transactions_delete(request):
    ids = request.data.get('ids', [])
    with transaction.atomic():
        qs = Transaction.objects.filter(id__in=ids)
        deleted_ids = list(qs.values_list('id', flat=True))
        qs.delete()
    return Response({'deleted_transactions': deleted_ids}, status=status.HTTP_200_OK)

@api_view(['DELETE'])
@permission_classes([IsAuthenticated])
def transaction_delete(request, pk):
    try:
        transaction = Transaction.objects.get(id=pk)
        serializer = TransactionModelSerializer(transaction, data={'is_deleted': True}, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response(status=status.HTTP_204_NO_CONTENT)
        return Response({"details": "couldn't delete client"}, status=status.HTTP_400_BAD_REQUEST)
    except:
        return Response({"details": "couldn't delete client"}, status=status.HTTP_400_BAD_REQUEST)