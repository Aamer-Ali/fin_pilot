import 'package:dio/dio.dart';
import 'package:fin_pilot/core/error/exceptions.dart';
import 'package:fin_pilot/features/auth/data/models/auth_tokens_model.dart';

class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<AuthTokensModel> login({
    required String email,
    required String password,
  }) {
    return _post('/auth/login', {'email': email, 'password': password});
  }

  Future<AuthTokensModel> signup({
    required String email,
    required String password,
    String? firstName,
    String? lastName,
  }) {
    return _post('/auth/signup', {
      'email': email,
      'password': password,
      'firstName': ?firstName,
      'lastName': ?lastName,
    });
  }

  Future<AuthTokensModel> loginWithGoogle({
    required String idToken,
    String? firstName,
    String? lastName,
  }) {
    return _post('/auth/google', {
      'idToken': idToken,
      'firstName': ?firstName,
      'lastName': ?lastName,
    });
  }

  Future<AuthTokensModel> loginWithApple({
    required String idToken,
    String? firstName,
    String? lastName,
  }) {
    return _post('/auth/apple', {
      'idToken': idToken,
      'firstName': ?firstName,
      'lastName': ?lastName,
    });
  }

  Future<AuthTokensModel> refresh({required String refreshToken}) {
    return _post('/auth/refresh', {'refreshToken': refreshToken});
  }

  Future<AuthTokensModel> _post(String path, Map<String, dynamic> body) async {
    try {
      final response = await _dio.post(path, data: body);
      return AuthTokensModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout) {
        throw const NetworkException('Could not reach the server.');
      }
      if (e.response?.statusCode == 401) {
        throw const UnauthorizedException('Invalid credentials.');
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
