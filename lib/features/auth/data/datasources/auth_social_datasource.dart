import 'package:fin_pilot/core/error/exceptions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

/// What the remote datasource needs to exchange a social sign-in for our
/// own backend's token pair.
class SocialIdentity {
  const SocialIdentity({required this.idToken, this.firstName, this.lastName});

  final String idToken;
  final String? firstName;
  final String? lastName;
}

class AuthSocialDataSource {
  bool _googleInitialized = false;

  Future<SocialIdentity> signInWithGoogle() async {
    if (!_googleInitialized) {
      await GoogleSignIn.instance.initialize();
      _googleInitialized = true;
    }

    final account = await GoogleSignIn.instance.authenticate();
    final idToken = account.authentication.idToken;
    if (idToken == null) {
      throw const UnauthorizedException(
        'Google sign-in did not return a token.',
      );
    }

    final nameParts = account.displayName?.split(' ') ?? const [];
    return SocialIdentity(
      idToken: idToken,
      firstName: nameParts.isNotEmpty ? nameParts.first : null,
      lastName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : null,
    );
  }

  Future<SocialIdentity> signInWithApple() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final idToken = credential.identityToken;
    if (idToken == null) {
      throw const UnauthorizedException(
        'Apple sign-in did not return a token.',
      );
    }

    return SocialIdentity(
      idToken: idToken,
      firstName: credential.givenName,
      lastName: credential.familyName,
    );
  }
}
