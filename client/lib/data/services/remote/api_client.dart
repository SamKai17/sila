import 'package:client/data/services/local/models/item/item_local_model.dart';
import 'package:client/data/services/local/models/payment/payment_local_model.dart';
import 'package:client/data/services/local/secure_storage_service.dart';
import 'package:client/domain/models/item/item.dart';
import 'package:client/domain/models/payment/payment.dart';
import 'package:client/utils/constants.dart';
import 'package:client/utils/result.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RevokeTokenException extends DioException {
  RevokeTokenException({required super.requestOptions});
}

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor({
    required SecureStorageService this.secureStorageService,
    required Dio this.dio,
  }) {
    refreshClient = Dio();
    retryClient = Dio();
    refreshClient.options = BaseOptions(baseUrl: dio.options.baseUrl);
    retryClient.options = BaseOptions(baseUrl: dio.options.baseUrl);
  }
  final SecureStorageService secureStorageService;
  final Dio dio;
  late Dio refreshClient;
  late Dio retryClient;

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
      final response = await refreshClient.post(
        '/api/token/refresh/',
        data: {
          'refresh': refreshToken,
        },
      );
      final String accessToken = response.data['access'];
      return (accessToken: accessToken, refreshToken: refreshToken);
      //need to send refresh token
    } catch (_) {
      // maybe here rethrow the exception
      // maybe there was an error other than refresh token has expired
      return null;
    }
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    // print('on request');
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
      // print('valid access token');
      options.headers
          .addAll({'Authorization': 'Bearer ${tokenPair.accessToken}'});
      return handler.next(options);
    }
    // if access not valid => refresh access
    final TokenPair? newTokenPair =
        await _refresh(refreshToken: tokenPair.refreshToken);
    if (newTokenPair == null) {
      // print('invalid refresh token');
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
    // print('success refreshing token');
    return handler.next(options);
  }

  Future<Map<String, dynamic>> _authorizationHeader() async {
    final tokenPair = await secureStorageService.getTokens();
    return {'Authorization': 'Bearer ${tokenPair!.accessToken}'};
  }

  Future<Response<T>> _retry<T>(RequestOptions requestOptions) async {
    // retryClient.fetch(requestOptions)
    // return retryClient.fetch(requestOptions);
    // print('retry');
    return retryClient.request(
      requestOptions.path,
      cancelToken: requestOptions.cancelToken,
      data: requestOptions.data is FormData
          ? (requestOptions.data as FormData).clone()
          : requestOptions.data,
      onReceiveProgress: requestOptions.onReceiveProgress,
      onSendProgress: requestOptions.onSendProgress,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        sendTimeout: requestOptions.sendTimeout,
        receiveTimeout: requestOptions.receiveTimeout,
        extra: requestOptions.extra,
        headers: {
          ...requestOptions.headers,
          ...await _authorizationHeader(),
        },
        responseType: requestOptions.responseType,
        contentType: requestOptions.contentType,
        validateStatus: requestOptions.validateStatus,
        receiveDataWhenStatusError: requestOptions.receiveDataWhenStatusError,
        followRedirects: requestOptions.followRedirects,
        maxRedirects: requestOptions.maxRedirects,
        requestEncoder: requestOptions.requestEncoder,
        responseDecoder: requestOptions.responseDecoder,
        listFormat: requestOptions.listFormat,
        connectTimeout: requestOptions.connectTimeout,
        persistentConnection: requestOptions.persistentConnection,
        preserveHeaderCase: requestOptions.preserveHeaderCase,
      ),
    );
  }

  @override
  void onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    // print('on error');
    if (err is RevokeTokenException || err.response == null) {
      // print('rejected onError');
      return handler.reject(err);
    }
    if (err.response!.statusCode == 401) {
      final TokenPair? tokenPair = await secureStorageService.getTokens();
      if (tokenPair == null) {
        return handler
            .reject(RevokeTokenException(requestOptions: err.requestOptions));
      }
      final TokenPair? newTokenPair =
          await _refresh(refreshToken: tokenPair.refreshToken);
      if (newTokenPair == null) {
        // print('invalid refresh token');
        // if refresh is not valid => logout user
        return handler.reject(
          RevokeTokenException(requestOptions: err.requestOptions),
        );
      }
      final response = await _retry(err.requestOptions);
      return handler.resolve(response);
      // retry
    }
    return handler.next(err);
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
  ApiClient(this._dio);

  final Dio _dio;

  Future<Result<void>> addClient({
    // required String accessToken,
    required String id,
    required String name,
    required String phone,
    required String city,
  }) async {
    try {
      final _ = await _dio.post(
        '/api/client/',
        data: {
          'id': id,
          'name': name,
          'phone': phone,
          'city': city,
        },
      );
      return Result.ok(null);
    } on RevokeTokenException catch (e) {
      print('refresh token is out');
      return Result.error(e);
    } on DioException catch (e) {
      if (e.response != null) {
        // server error
        print('exception: ${e.response!.statusCode}');
      } else {
        print('my error');
        // your error
      }
      return Result.error(e);
    }
  }

  Future<Result<void>> updateClient({
    required String id,
    required String name,
    required String phone,
    required String city,
  }) async {
    try {
      final _ = await _dio.put(
        '/api/client/${id}/',
        data: {
          'name': name,
          'phone': phone,
          'city': city,
        },
      );
      return Result.ok(null);
    } on DioException catch (e) {
      if (e.response != null) {
        // server error
        print('exception: ${e.response!.statusCode}');
        print('exception: ${e.message}');
      } else {
        print('my error');
        // your error
      }
      return Result.error(e);
    }
  }

  Future<Result<void>> deleteClients({
    required List<String> ids,
  }) async {
    try {
      final _ = await _dio.post(
        '/api/clients/delete/',
        data: {
          'ids': ids,
        },
      );
      return Result.ok(null);
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return Result.error(e);
    }
  }

  Future<Result<void>> deleteClient({
    required String id,
  }) async {
    try {
      final _ = await _dio.delete(
        '/api/client/delete/${id}/',
      );
      return Result.ok(null);
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return Result.error(e);
    }
  }

  Future<Result<void>> deleteTransaction({
    required String id,
  }) async {
    try {
      final _ = await _dio.delete(
        '/transaction/delete/${id}/',
      );
      return Result.ok(null);
    } on DioException catch (e) {
      if (e.response != null) {
      } else {}
      return Result.error(e);
    }
  }

  Future<Result<void>> addTransaction({
    required String id,
    required double totalPrice,
    required double totalPaid,
    required double remainder,
    required int timeOfTransaction,
    required String type,
    required String clientId,
    required List<ItemLocalModel> items,
    required List<PaymentLocalModel> payments,
  }) async {
    try {
      final itemsMapList = items
          .map(
            (e) => {
              'id': e.id,
              'name': e.name,
              'price': e.price,
              'quantity': e.quantity,
              'is_deleted': e.isDeleted,
            },
          )
          .toList();
      final paymentsMapList = payments
          .map(
            (e) => {
              'id': e.id,
              'amount': e.amount,
              'time_of_payment': e.timeOfPayment,
              'is_deleted': e.isDeleted,
            },
          )
          .toList();
      final response = await _dio.post(
        '/transaction/create/',
        data: {
          'id': id,
          'total_price': totalPrice,
          'total_paid': totalPaid,
          'remainder': remainder,
          'time_of_transaction': timeOfTransaction,
          'type': 'Buy', // need to fix the type
          'client': clientId,
          'items': itemsMapList,
          'payments': paymentsMapList,
        },
      );
      // print(response.data);
      return Result.ok(null);
    } on DioException catch (e) {
      // print(e.message);
      // print(e.error);
      return Result.error(e);
    }
  }

  // Future<void> updateTransaction() async {
  //   await _dio.post('/transaction/create/', data: {});
  // }

  Future<Result<void>> deleteTransactions({
    required List<String> transactionsIds,
  }) async {
    try {
      final response = await _dio.post(
        '/transaction/delete/',
        data: {
          'ids': transactionsIds,
        },
      );
      // print(response.data);
      return Result.ok(null);
    } on DioException catch (e) {
      return Result.error(e);
    }
  }
}
