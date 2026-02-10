class ClientRepository {
  Future<void> getAllClients(
    String token,
  ) async {

  }

  Future<void> addClient({
    required String token,
    String? name,
    String? phone,
    String? city,
  }) async {

  }

  Future<void> updateClient({
    required String token,
    required int id,
    String? name,
    String? phone,
    String? city,
  }) async {
 
  }

  Future<void> removeClient({
    required String token,
    required List<int> ids,
  }) async {

  }
}
