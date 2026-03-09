class SocialLoginModel {
  final String provider; // "google" or "apple"
  final String? idToken; // Google ID token
  final String? identityToken; // Apple
  final String? authorizationCode; // Apple

  SocialLoginModel({
    required this.provider,
    this.idToken,
    this.identityToken,
    this.authorizationCode,
  });

  Map<String, dynamic> toJson() {
    if (provider == "google") {
      return {'id_token': idToken};
    } else {
      return {
        'identity_token': identityToken,
        'authorization_code': authorizationCode,
      };
    }
  }
}
