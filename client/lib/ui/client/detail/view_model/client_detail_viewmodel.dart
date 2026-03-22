import 'package:client/data/repositories/client/client_repository.dart';
import 'package:client/domain/models/client/client.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final clientProvider = Provider.autoDispose.family<AsyncValue<Client>, String>((ref, id) {
  final clients = ref.watch(clientsProvider);
  return clients.whenData((value) {
    return value.firstWhere((client) => client.id == id);
  },);
},);