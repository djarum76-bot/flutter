import 'dart:io';

import 'package:dio/dio.dart';
import 'package:nonolep/services/local/local_storage.dart';
import 'package:nonolep/services/network/network_url.dart';
import 'package:nonolep/utils/constants/api_constant.dart';

class TokenInterceptor extends QueuedInterceptor{
  final LocalStorage _storage = LocalStorage.instance;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler)async{
    RequestOptions customOptions = options;

    if(!NetworkUrl.excludedPath.contains(options.path)){
      customOptions.headers = {
        HttpHeaders.contentTypeHeader : ApiConstant.appJson,
        HttpHeaders.authorizationHeader : "${ApiConstant.bearer} ${await _storage.token}"
      };
    }else{
      customOptions.headers = { HttpHeaders.contentTypeHeader : ApiConstant.appJson };
    }

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // TODO: implement onResponse
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // TODO: implement onError
    super.onError(err, handler);
  }
}