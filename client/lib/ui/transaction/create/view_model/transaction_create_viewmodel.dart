import 'package:client/domain/models/item/item.dart';
import 'package:riverpod/riverpod.dart';
import 'package:uuid/uuid.dart';

final itemsCart =
    NotifierProvider.family<ItemsCart, List<Item>, String>(
  (clientId) {
    return ItemsCart(<Item>[]);
  },
);

class ItemsCart extends Notifier<List<Item>> {
  ItemsCart(this.items);
  final items;

  @override
  List<Item> build() {
    return items;
  }

  void clear() {
    state = [];
  }

  double totalPrice() {
    double total = 0.0;
    for (var item in state) {
      total += item.price * item.quantity;
    }
    return total;
  }

  void addItem({
    required String name,
    required double price,
    required int quantity,
  }) {
    final String id = Uuid().v4();
    final newItem = Item(id: id, name: name, price: price, quantity: quantity);
    state = [...state, newItem];
  }

  void updateItem({
    required String id,
    required String name,
    required double price,
    required int quantity,
  }) {
    final oldItem = state.firstWhere((item) => item.id == id);
    final newItem =
        oldItem.copyWith(name: name, price: price, quantity: quantity);
    final newList = state.map(
      (item) {
        if (item.id == id) {
          return newItem;
        }
        return item;
      },
    ).toList();
    state = newList;
  }

  void deleteItems() {
    final toRemoveItems = ref.read(selectedItems);
    state = state.where((item) => !toRemoveItems.contains(item)).toList();
  }
}

final isItemSelected = Provider.family(
  (ref, Item item) {
    final _selectedClients = ref.watch(selectedItems);
    return _selectedClients.contains(item);
  },
);

final itemSelectedMode = Provider(
  (ref) {
    final _selectedClients = ref.watch(selectedItems);
    return _selectedClients.isNotEmpty;
  },
);

final selectedItems =
    NotifierProvider<SelectedItems, List<Item>>(SelectedItems.new);

class SelectedItems extends Notifier<List<Item>> {
  @override
  List<Item> build() {
    return [];
  }

  void addSelectedItem(Item item) {
    state = [...state, item];
  }

  void removeSelectedItem(Item item) {
    final newList = [...state];
    newList.remove(item);
    state = newList;
  }

  void clearSelectedItems() {
    state = [];
  }
}
