import 'package:client/data/services/remote/api_client.dart';
import 'package:client/utils/result.dart';
import 'package:dio/dio.dart';
// import 'package:flutter_test/flutter_test.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';
import 'package:test/test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
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
  group(
    'add client api',
    () {
      const route = '/api/client/';
      test(
        'adding client successfuly',
        () async {
          final container = ProviderContainer.test();
          final api = container.read(apiClient(dio));
          dioAdapter.onPost(
            route,
            (server) => server.reply(
              201,
              {
                'id': 'id',
                'name': 'oussama',
                'phone': '123',
                'city': 'casa',
              },
            ),
            data: {
              'id': 'id',
              'name': 'oussama',
              'phone': '123',
              'city': 'casa',
            },
          );
          final response = await api.addClient(
            id: 'id',
            name: 'oussama',
            phone: '123',
            city: 'casa',
          );
          switch (response) {
            case Ok():
              print('success');
            case Error():
              print('error');
          }
          // expect(response.statusCode, 201);
        },
      );
      test(
        'error adding client',
        () async {
          final container = ProviderContainer.test();
          final api = container.read(apiClient(dio));
          dioAdapter.onPost(
            route,
            (server) => server.reply(
              400,
              {
                'message': 'bad request my friend',
              },
            ),
            data: {
              'id': 'id',
              'name': 'oussama',
              'phone': '123',
              'city': 'casa',
            },
          );
          final response = await api.addClient(
            id: 'id',
            name: 'oussama',
            phone: '123',
            city: 'casa',
          );
          switch (response) {
            case Ok():
              print('success');
            case Error():
              expect(response.error, isA<DioException>());
              print('error');
          }
        },
      );
    },
  );
}
