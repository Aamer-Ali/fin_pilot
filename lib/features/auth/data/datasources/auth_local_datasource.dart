import 'package:fin_pilot/features/auth/data/models/auth_tokens_model.dart';
import 'package:hive_ce/hive.dart';

/// Backed by a plain Hive box (on-device app-sandbox storage) rather than
/// Keychain/EncryptedSharedPreferences. Keychain entries on iOS survive an
/// app being deleted and reinstalled, which let a stale refresh token skip
/// straight past the login screen on a "fresh" install — a Hive box lives
/// in the app's sandboxed storage, so it's wiped like everything else when
/// the app is uninstalled.
class AuthLocalDataSource {
  AuthLocalDataSource(this._box);

  final Box<String> _box;

  static const _accessTokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';

  Future<void> saveTokens(AuthTokensModel tokens) async {
    await _box.put(_accessTokenKey, tokens.accessToken);
    await _box.put(_refreshTokenKey, tokens.refreshToken);
  }

  Future<String?> getAccessToken() async => _box.get(_accessTokenKey);

  Future<String?> getRefreshToken() async => _box.get(_refreshTokenKey);

  Future<void> clearTokens() async {
    await _box.delete(_accessTokenKey);
    await _box.delete(_refreshTokenKey);
  }
}
