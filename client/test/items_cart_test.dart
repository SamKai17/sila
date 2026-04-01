import 'package:client/domain/models/item/item.dart';
import 'package:client/ui/transaction/create/view_model/transaction_create_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test/test.dart';

int totalPrice() {
  return 10;
}

int totalItems() {
  return 8;
}

int remainder() {
  return 5;
}

void main() {
  group(
    'group test',
    () {
      test('testing provider totalPrice', () {
        final container = ProviderContainer.test();
        final itemsCartNotifier = container.read(itemsCart('xxx').notifier);
        itemsCartNotifier.addItem(name: 'serwal', price: 50.0, quantity: 20);
        final itemsCartList = container.read(itemsCart('xxx'));
        // final total = itemsCartNotifier.totalPrice();
        expect(itemsCartList.length, 1);
      });
    },
  );
}
