import 'package:dio/dio.dart';

/// Builds the app's single [Dio] instance. [getAccessToken] is optional so
/// this stays decoupled from the auth feature — the DI setup wires in
/// `AuthLocalDataSource.getAccessToken` when registering this.
Dio buildDio({
  required String baseUrl,
  Future<String?> Function()? getAccessToken,
}) {
  final dio = Dio(BaseOptions(baseUrl: baseUrl));

  if (getAccessToken != null) {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await getAccessToken();
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
      ),
    );
  }

  return dio;
}
