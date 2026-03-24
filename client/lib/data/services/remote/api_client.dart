import 'dart:convert';
import 'package:client/data/services/local/secure_storage_service.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/result.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class RevokeTokenException extends DioException {
  RevokeTokenException({required super.requestOptions});
}

typedef TokenPair = ({String accessToken, String refreshToken});

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required SecureStorageService this.secureStorageService,
    required Dio this.dio,
  }) {
    refreshClient = Dio();
    refreshClient.options = BaseOptions(baseUrl: dio.options.baseUrl);
  }
  final SecureStorageService secureStorageService;
  final Dio dio;
  late Dio refreshClient;

  Future<bool> get _isAccessTokenValid async {
    final tokenPair = await secureStorageService.getTokens();
    if (tokenPair == null) {
      return false;
    }
    final decodedJwt = JWT.decode(tokenPair.accessToken);
    final expirationTimeEpoch = decodedJwt.payload['exp'];
    final expirationDateTime =
        DateTime.fromMillisecondsSinceEpoch(expirationTimeEpoch * 1000);
    final marginOfErrorInMilliseconds = 1000;
    final addedMarginTime = Duration(milliseconds: marginOfErrorInMilliseconds);
    return DateTime.now().add(addedMarginTime).isBefore(expirationDateTime);
  }

  Future<TokenPair?> _refresh({required String refreshToken}) async {
    try {
      final response = await refreshClient.post('/api/token/refresh/', data: {
        'refresh': refreshToken,
      });
      final String accessToken = response.data['access'];
      return (accessToken: accessToken, refreshToken: refreshToken);
      //need to send refresh token
    } catch (_) {
      // maybe here rethrow the exception
      return null;
    }
  }

  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // return handler.reject(RevokeTokenException(requestOptions: options));
    print('on request');
    // get access token
    final TokenPair? tokenPair = await secureStorageService.getTokens();
    if (tokenPair == null) {
      print('tokens not saved');
      // no tokens available => logout user
      return handler.reject(RevokeTokenException(requestOptions: options));
    }
    // check if access token is valid
    final isAccessTokenValid = await _isAccessTokenValid;
    if (isAccessTokenValid) {
      print('valid access token');
      options.headers
          .addAll({'Authorization': 'Bearer ${tokenPair.accessToken}'});
      return handler.next(options);
    }
    // if access not valid => refresh access
    final TokenPair? newTokenPair =
        await _refresh(refreshToken: tokenPair.refreshToken);
    if (newTokenPair == null) {
      print('invalid refresh token');
      // if refresh is not valid => logout user
      return handler.reject(
        RevokeTokenException(requestOptions: options),
        true,
      );
    }
    await secureStorageService.setTokens(newTokenPair);
    //set new tokens
    options.headers
        .addAll({'Authorization': 'Bearer ${newTokenPair.accessToken}'});
    print('success refreshing token');
    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('on error');
    if (err is RevokeTokenException) {
      print('rejected onError');
      return handler.reject(err);
    }
    return handler.next(err);
    // return handler.resolve(response);
    // final TokenPair tokens = (accessToken: '', refreshToken: '');
    // super.onError(err, handler);
  }
}

final apiClient = Provider(
  (ref) {
    final options = BaseOptions(baseUrl: Constants.uri);
    final _secureStorageService = ref.read(secureStorageService);
    final dio = Dio(options);
    dio.interceptors.add(
        AuthInterceptor(secureStorageService: _secureStorageService, dio: dio));
    // dio.interceptors.add(QueuedInterceptor());
    return ApiClient(dio);
  },
);

class ApiClient {
  final Dio _dio;
  ApiClient(this._dio);
  Future<Result<void>> addClient({
    required String accessToken,
    required String id,
    required String name,
    required String phone,
    required String city,
  }) async {
    try {
      final Response response = await _dio.post(
        '${Constants.uri}/api/client/',
        data: jsonEncode(
          {
            'id': id,
            'name': name,
            'phone': phone,
            'city': city,
          },
        ),
      );
      print(response.data);
      print('here: ${response.statusCode}');
      return Result.ok(null);
    } on DioException catch (e) {
      if (e.response != null) {
        // server error
        print('exception: ${e.response!.statusCode}');
      } else {
        // your error
      }
      return Result.error(e);
    }
  }

  Future<Result<void>> updateClient({
    required String accessToken,
    required String id,
    required String name,
    required String phone,
    required String city,
  }) async {
    try {
      print('${Constants.uri}/api/client/${id}/');
      final response = await http.put(
        Uri.parse('${Constants.uri}/api/client/${id}/'),
        headers: {
          Constants.contentType: 'application/json',
          Constants.authorization: 'Bearer ${accessToken}'
        },
        body: jsonEncode(
          {
            'name': name,
            'phone': phone,
            'city': city,
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('error updating client');
      }
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }

  Future<Result<void>> deleteClients({
    required String accessToken,
    required List<String> ids,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('${Constants.uri}/api/clients/delete/'),
        headers: {
          Constants.contentType: 'application/json',
          Constants.authorization: 'Bearer ${accessToken}'
        },
        body: jsonEncode(
          {
            'ids': ids,
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('error creating client');
      }
      return Result.ok(null);
    } on Exception catch (e) {
      return Result.error(e);
    }
  }
}
