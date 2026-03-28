from django.shortcuts import render
from rest_framework.response import Response
from rest_framework import status
from rest_framework.decorators import api_view, permission_classes
from rest_framework.permissions import IsAuthenticated
from .models import Transaction
from .serializer import TransactionModelSerializer
from django.db import transaction

@api_view(['GET'])
@permission_classes([IsAuthenticated])
def transaction_list(request):
    transactions = Transaction.objects.all()
    serializer = TransactionModelSerializer(transactions, many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)

@api_view(['POST'])
@permission_classes([IsAuthenticated])
def transaction_create(request):
    serializer = TransactionModelSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response({"message": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)

@api_view(['PUT'])
@permission_classes([IsAuthenticated])
def transaction_update(request, pk):
    transaction = Transaction.objects.get(pk=pk)
    serializer = TransactionModelSerializer(transaction, data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_200_OK)
    return Response({"message": serializer.errors}, status=status.HTTP_400_BAD_REQUEST)


@api_view(['POST'])
@permission_classes([IsAuthenticated])
def transaction_delete(request):
    ids = request.data.get('ids', [])
    with transaction.atomic():
        qs = Transaction.objects.filter(id__in=ids)
        deleted_ids = list(qs.values_list('id', flat=True))
        qs.delete()
    return Response({'deleted_transactions': deleted_ids}, status=status.HTTP_200_OK)
