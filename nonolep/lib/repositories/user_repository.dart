import 'package:dio/dio.dart';
import 'package:nonolep/models/user_model.dart';
import 'package:nonolep/services/network/api_response.dart';
import 'package:nonolep/services/network/interceptors/loggin_interceptor.dart';
import 'package:nonolep/services/network/interceptors/token_interceptor.dart';
import 'package:nonolep/services/network/network_client.dart';
import 'package:nonolep/services/network/network_url.dart';
import 'package:nonolep/utils/constants/api_constant.dart';
import 'package:nonolep/utils/constants/local_constant.dart';

class UserRepository{
  final NetworkClient _networkClient = NetworkClient(
    dioClient: Dio(BaseOptions(baseUrl: NetworkUrl.baseURL)),
    interceptors: [
      LoggingInterceptor(),
      TokenInterceptor()
    ]
  );

  Future<ApiResponse<String>> register(String email, String password)async{
    try{
      FormData data = FormData.fromMap({
        ApiConstant.email : email,
        ApiConstant.password : password,
      });

      final response = await _networkClient.post(
        endpoint: NetworkUrl.user(UserEndpoint.register),
        data: data
      );

      ApiResponse<String> apiResponse = ApiResponse(
        code: response.statusCode!,
        data: response.data[ApiConstant.data][LocalConstant.token],
        message: response.data[ApiConstant.message],
        error: false
      );

      return apiResponse;
    }on DioException catch(e){
      return _networkClient.errorParser(e);
    }
  }

  Future<ApiResponse<String>> login(String email, String password)async{
    try{
      FormData data = FormData.fromMap({
        ApiConstant.email : email,
        ApiConstant.password : password,
      });

      final response = await _networkClient.post(
          endpoint: NetworkUrl.user(UserEndpoint.login),
          data: data
      );

      ApiResponse<String> apiResponse = ApiResponse(
          code: response.statusCode!,
          data: response.data[ApiConstant.data][LocalConstant.token],
          message: response.data[ApiConstant.message],
          error: false
      );

      return apiResponse;
    }on DioException catch(e){
      return _networkClient.errorParser(e);
    }
  }

  Future<ApiResponse<UserModel>> getUser()async{
    try{
      final response = await _networkClient.get(
        endpoint: NetworkUrl.user(UserEndpoint.getUser)
      );

      ApiResponse<UserModel> apiResponse = ApiResponse(
        code: response.statusCode!,
        data: UserModel.fromJson(response.data[ApiConstant.data]),
        message: response.data[ApiConstant.message],
        error: false
      );

      return apiResponse;
    }on DioException catch(e){
      return _networkClient.errorParser(e);
    }
  }

  Future<ApiResponse<void>> updateUser({required UserModel user})async{
    try{
      FormData formData = FormData();

      Map<String, dynamic> map = {
        ApiConstant.gender : user.gender,
        ApiConstant.age : user.age,
        ApiConstant.weight : user.weight,
        ApiConstant.height : user.height,
        ApiConstant.level : user.level,
        ApiConstant.name : user.name,
        ApiConstant.phone : user.phone,
      };

      if(user.picture != ""){
        map[ApiConstant.picture] = await MultipartFile.fromFile(user.picture!, filename: user.picture!.split('/').last);
      }

      formData = FormData.fromMap(map);

      for(var goal in user.goals!){
        formData.fields.addAll([
          MapEntry(ApiConstant.goals, goal)
        ]);
      }

      final response = await _networkClient.put(
        endpoint: NetworkUrl.user(UserEndpoint.updateUser),
        data: formData
      );

      ApiResponse<void> apiResponse = ApiResponse(
          code: response.statusCode!,
          message: response.data[ApiConstant.message],
          error: false
      );

      return apiResponse;
    }on DioException catch(e){
      return _networkClient.errorParser(e);
    }
  }
}