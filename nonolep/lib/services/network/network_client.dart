import 'package:dio/dio.dart';
import 'package:nonolep/services/network/api_response.dart';
import 'package:nonolep/utils/constants/api_constant.dart';

class NetworkClient{
  final Dio _dio;
  final CancelToken _cancelToken;

  NetworkClient({
    required Dio dioClient,
    Iterable<Interceptor>? interceptors
  }) : _dio = dioClient,
       _cancelToken = CancelToken() {
    if(interceptors != null) _dio.interceptors.addAll(interceptors);
  }

  void cancelRequests({CancelToken? cancelToken}){
    if(cancelToken == null){
      _cancelToken.cancel("Cancelled");
    }else{
      cancelToken.cancel();
    }
  }

  Future<Response> get({
    required String endpoint,
    Map<String,dynamic>? queryParams,
    Options? options,
    CancelToken? cancelToken
  }) async{
    final response = await _dio.get(endpoint,
      queryParameters: queryParams,
      options: options,
      cancelToken: cancelToken
    );
    return response;
  }

  Future<Response> post({
    required String endpoint,
    Map<String,dynamic>? queryParams,
    Object? data,
    Options? options,
    CancelToken? cancelToken
  }) async {
    final response = await _dio.post(endpoint,
      queryParameters: queryParams,
      data: data,
      options: options,
      cancelToken: cancelToken
    );
    return response;
  }

  Future<Response> put({
    required String endpoint,
    Map<String,dynamic>? queryParams,
    Object? data,
    Options? options,
    CancelToken? cancelToken
  }) async {
    final response = await _dio.put(endpoint,
      queryParameters: queryParams,
      data: data,
      options: options,
      cancelToken: cancelToken
    );
    return response;
  }

  Future<Response> delete({
    required String endpoint,
    Map<String,dynamic>? queryParams,
    Object? data,
    Options? options,
    CancelToken? cancelToken
  }) async {
    final response = await _dio.delete(endpoint,
      queryParameters: queryParams,
      data: data,
      options: options,
      cancelToken: cancelToken
    );
    return response;
  }

  Future<ApiResponse<T>> errorParser<T>(DioException e) {
    ApiResponse<T> response = ApiResponse<T>(
      code: e.response!.statusCode!,
      message: '',
      error: true
    );
    
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        response = response.copyWith(message: 'Can not connect to server');
        break;
      case DioExceptionType.sendTimeout:
        response = response.copyWith(message: 'Can not connect to server');
        break;
      case DioExceptionType.receiveTimeout:
        response = response.copyWith(message: 'Can not connect to server');
        break;
      case DioExceptionType.badCertificate:
        response = response.copyWith(message: 'Bad certificate');
        break;
      case DioExceptionType.badResponse:
        response = response.copyWith(message: e.response!.data[ApiConstant.message]);
        break;
      case DioExceptionType.cancel:
        response = response.copyWith(message: 'Request cancelled');
        break;
      case DioExceptionType.connectionError:
        response = response.copyWith(message: 'No Internet connection');
        break;
      case DioExceptionType.unknown:
        response = response.copyWith(message: 'Can not connect to server');
        break;
    }

    return Future(() => response);
  }
}