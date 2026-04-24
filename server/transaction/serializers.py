from rest_framework import serializers
from .models import Transaction, Item, Payment, Client
from client.serializers import ClientModelSerializer

class PaymentModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Payment 
        fields = ['id', 'amount', 'time_of_payment', 'is_deleted']
        extra_kwargs = {'id': {'validators': []}}

# class ItemListModelSerializer(serializers.ListSerializer):
#     def validate(self, attrs):
#         print("validate")
#         return super().validate(attrs)
#     def create(self, validated_data):
#         print("create")
#         return super().create(validated_data)

class ItemModelSerializer(serializers.ModelSerializer):
    class Meta:
        model = Item
        fields = ['id', 'name', 'price', 'quantity', 'is_deleted']
        extra_kwargs = {'id': {'validators': []}}
        # list_serializer_class = ItemListModelSerializer
    
    # def validate(self, attrs):
    #     print('validate')
    #     return super().validate(attrs)
    
    # def create(self, validated_data):
    #     print('creating')
    #     return super().create(validated_data)
    
    # def update(self, instance, validated_data):
    #     print('updating')
    #     return super().update(instance, validated_data)

class TransactionModelSerializer(serializers.ModelSerializer):
    items = ItemModelSerializer(many=True,)
    payments = PaymentModelSerializer(many=True)
    # client = ClientModelSerializer()
    client = serializers.PrimaryKeyRelatedField(queryset=Client.objects.all())
    class Meta:
        model = Transaction
        fields = ['id', 'total_price', 'total_paid', 'remainder', 'time_of_transaction', 'type', 'client', 'items', 'payments', 'is_deleted']
        depth = 1

    def create(self, validated_data):
        try:
            print('create')
            payments_data = validated_data.pop('payments', [])
            items_data = validated_data.pop('items', [])
            transaction = Transaction.objects.create(**validated_data)
            for item_data in items_data:
                Item.objects.create(transaction=transaction ,**item_data)
            for payment_data in payments_data:
                Payment.objects.create(transaction=transaction ,**payment_data)
            return transaction
        except:
            raise serializers.ValidationError({'detail': 'couldnt create transaction'})

    def update(self, instance, validated_data):
        try:
            print('update')
            print(validated_data)
            payments_data = validated_data.pop('payments', [])
            items_data = validated_data.pop('items', [])
            instance.total_price = validated_data.get('total_price', instance.total_price)
            instance.remainder = validated_data.get('remainder', instance.remainder)
            instance.total_paid = validated_data.get('total_paid', instance.total_paid)
            instance.save()
            instance.items.all().delete()
            instance.payments.all().delete()
            for item_data in items_data:
                item = Item.objects.create(transaction=instance, **item_data)
            for payment_data in payments_data:
                Payment.objects.create(transaction=instance ,**payment_data)
            return instance
        except Exception as e:
            print(e)
            raise serializers.ValidationError({'detail': 'couldnt update transaction'})