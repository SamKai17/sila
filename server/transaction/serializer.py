from rest_framework import serializers
from .models import Transaction, Item, Payment, Client


class PaymentModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payment 
        fields = ['id', 'amount', 'time_of_payment']

class ItemModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Item
        fields = ['id', 'name', 'price', 'quantity']

class TransactionModelSerializer(serializers.ModelSerializer):
    items = ItemModelSerializer(many=True)
    payments = PaymentModelSerializer(many=True)
    client = serializers.PrimaryKeyRelatedField(queryset=Client.objects.all())
    class Meta:
        model = Transaction
        fields = ['id', 'total_price', 'total_paid', 'remainder', 'time_of_transaction', 'type', 'client', 'items', 'payments']
        depth = 1

    def create(self, validated_data):
        # print(validated_data)
        try:
            # print(self.initial_data)
            # print(self.instance)
            payments_data = validated_data.pop('payments', [])
            items_data = validated_data.pop('items', [])
            # print('creating transaction')
            # print(validated_data)
            transaction = Transaction.objects.create(**validated_data)
            # print('after creating transaction')
            for item_data in items_data:
                Item.objects.create(transaction=transaction ,**item_data)
            # print('creating payments')
            for payment_data in payments_data:
                Payment.objects.create(transaction=transaction ,**payment_data)
            # print('after creating payments')
            return transaction
        except:
            # print('exception raised')
            raise serializers.ValidationError({'detail': 'couldnt create transaction'})

