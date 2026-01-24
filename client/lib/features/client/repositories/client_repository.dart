import 'package:client/core/constants/server_constant.dart';
import 'package:client/core/failure/failure.dart';
import 'package:client/features/client/model/client_model.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';

final clientRepositoryProvider = Provider<ClientRepository>((ref) {
  return ClientRepository();
});

class ClientRepository {
  Future<Either<AppFailure, List<ClientModel>>> getAllClients(
    String token,
  ) async {
    try {
      final response = await http.get(
        Uri.parse('${ServerConstant.serverURL}/clients/'),
        headers: {'Authorization': 'Bearer $token'},
      );
      print(response.body);
      print(response.statusCode);
      if (response.statusCode != 200) {
        return Right([]);
      }
      return Left(AppFailure());
    } catch (e) {
      return Left(AppFailure());
    }
  }
}
