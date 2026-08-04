import 'package:dio/dio.dart';
import 'package:fin_pilot/core/error/exceptions.dart';
import 'package:fin_pilot/features/profile/data/models/user_profile_model.dart';

class ProfileRemoteDataSource {
  ProfileRemoteDataSource(this._dio);

  final Dio _dio;

  Future<UserProfileModel> getProfile() async {
    try {
      final response = await _dio.get('/users/profile');
      return UserProfileModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw const NetworkException('Could not reach the server.');
      }
      if (e.response?.statusCode == 401) {
        throw const UnauthorizedException('Session expired.');
      }
      final message =
          e.response?.data is Map &&
              (e.response?.data as Map)['message'] != null
          ? (e.response!.data as Map)['message'].toString()
          : 'Something went wrong.';
      throw ServerException(message);
    }
  }
}
