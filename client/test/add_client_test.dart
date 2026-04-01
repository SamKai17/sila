import 'package:client/data/services/remote/api_client.dart';
import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  // TestWidgetsFlutterBinding.ensureInitialized();
  final baseUrl = 'http://localhost:8000';
  late Dio dio;
  late DioAdapter dioAdapter;

  setUp(
    () {
      dio = Dio(BaseOptions(baseUrl: baseUrl));
      dioAdapter = DioAdapter(
        dio: dio,
        matcher: const FullHttpRequestMatcher(),
      );
    },
  );
  test(
    'add client remotely',
    () async {
      const route = '/client/';
      dioAdapter.onPost(
        route,
        (server) => server.reply(
          201,
          {
            'id': '1234',
          },
        ),
        data: {
          'id': '1234',
        },
      );
      final container = ProviderContainer.test();
      final api = container.read(apiClient);
      final response = await api.addClient(id: 'id', name: '', phone: '', city: '');
      // expect(response.statusCode, 201);
    },
  );
}
