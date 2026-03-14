// import 'package:client/data/services/local/database_service.dart';
// import 'package:client/domain/models/item/item.dart';
// import 'package:client/domain/models/transaction_draft/transaction_draft.dart';
// import 'package:client/utils/result.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final transactionDraftRepository = Provider(
//   (ref) {
//     return TransactionDraftRepository(
//       databaseService: ref.read(databaseService),
//     );
//   },
// );

// class TransactionDraftRepository {
//   TransactionDraftRepository({required DatabaseService databaseService})
//       : _databaseService = databaseService;

//   final DatabaseService _databaseService;

//   List<TransactionDraft> _transactionDraftList = [];

//   int getTotalItems({required String clientId}) {
//     final index = _transactionDraftList.indexWhere(
//       (e) => e.clientId == clientId,
//     );
//     if (index != -1) {
//       List<Item> items = _transactionDraftList[index].items;
//       int total = 0;
//       for (var item in items) {
//         total += item.quantity;
//       }
//       return total;
//     }
//     return 0;
//   }

//   void clear() {
//     _transactionDraftList.clear();
//   }

//   double getTotalPrice({required String clientId}) {
//     final index = _transactionDraftList.indexWhere(
//       (e) => e.clientId == clientId,
//     );
//     if (index != -1) {
//       List<Item> items = _transactionDraftList[index].items;
//       double total = 0;
//       for (var item in items) {
//         total += item.price * item.quantity;
//       }
//       return total;
//     }
//     return 0.0;
//   }

//   double _remainder(double totalPaid, double totalPrice) {
//     return totalPrice - totalPaid;
//   }

//   void setTransactionDraftPayment(
//       {required String clientId, required double value}) {
//     final index = _transactionDraftList.indexWhere(
//       (e) => e.clientId == clientId,
//     );
//     if (index != -1) {
//       _transactionDraftList[index] =
//           _transactionDraftList[index].copyWith(paid: value);
//     }
//   }

//   Result<TransactionDraft> getTransactionDraft(String clientId) {
//     final index = _transactionDraftList.indexWhere(
//       (e) => e.clientId == clientId,
//     );
//     if (index != -1) {
//       return Result.ok(_transactionDraftList[index]);
//     }
//     return Result.error(Exception('no transaction found'));
//   }

//   Future<Result<String>> addTransaction(
//       {required String clientId, required String type}) async {
//     if (!_databaseService.isOpen) {
//       await _databaseService.open();
//     }
//     final transactionDraft = _transactionDraftList
//         .firstWhere((element) => element.clientId == clientId);
//     final double totalPrice = getTotalPrice(clientId: clientId);
//     return _databaseService.addTransaction(
//       clientId: clientId, // needs this +
//       paid: transactionDraft.paid, // needs this +
//       remainder: _remainder(
//         transactionDraft.paid,
//         totalPrice,
//       ),
//       type: type, // needs this +
//       timeOfTransaction: DateTime.now().millisecondsSinceEpoch,
//       totalPaid: transactionDraft.paid, // dont needs this X
//       totalPrice: totalPrice, // depends -
//       items: transactionDraft.items, //needs this +
//     );
//   }

//   void addItem({required String clientId, required Item item}) {
//     final index = _transactionDraftList.indexWhere(
//       (e) => e.clientId == clientId,
//     );
//     if (index != -1) {
//       print('add to existing draft');
//       final currentItems = _transactionDraftList[index].items;
//       _transactionDraftList[index] =
//           _transactionDraftList[index].copyWith(items: [...currentItems, item]);
//     } else {
//       print('create new transaction draft');
//       final transaction = TransactionDraft(
//         clientId: clientId,
//         paid: 0,
//         items: [item],
//       );
//       _transactionDraftList.add(transaction);
//     }
//   }

//   void updateItem(
//       {required String clientId,
//       required String itemId,
//       required Item newItem}) {
//     final index = _transactionDraftList.indexWhere(
//       (e) => e.clientId == clientId,
//     );
//     if (index != -1) {
//       print('add to existing draft');
//       final newItems = _transactionDraftList[index].items.map(
//         (item) {
//           if (item.id == itemId) {
//             return newItem;
//           }
//           return item;
//         },
//       ).toList();
//       _transactionDraftList[index] =
//           _transactionDraftList[index].copyWith(items: newItems);
//     }
//   }

//   void deleteItems({required List<Item> items, required String clientId}) {
//     final index = _transactionDraftList.indexWhere(
//       (e) => e.clientId == clientId,
//     );
//     if (index != -1) {
//       final currentItems = _transactionDraftList[index].items;
//       final newItems =
//           currentItems.where((item) => !items.contains(item)).toList();
//       if (newItems.isEmpty) {
//         print('remove transaction draft');
//         _transactionDraftList.removeAt(index);
//       } else {
//         print('update transaction draft list');
//         _transactionDraftList[index] =
//             _transactionDraftList[index].copyWith(items: newItems);
//       }
//     }
//   }

//   List<Item> getItems(String clientId) {
//     final index = _transactionDraftList.indexWhere(
//       (e) => e.clientId == clientId,
//     );
//     if (index != -1) {
//       return _transactionDraftList[index].items;
//     }
//     return [];
//   }
// }
