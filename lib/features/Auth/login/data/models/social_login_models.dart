class SocialLoginModel {
  final String provider; // "google" or "apple"
  final String? accessToken; // Google ID token
  final String? identityToken; // Apple
  final String? authorizationCode; // Apple

  SocialLoginModel({
    required this.provider,
    this.accessToken,
    this.identityToken,
    this.authorizationCode,
  });

  Map<String, dynamic> toJson() {
    if (provider == "google") {
      return {'access_token': accessToken};
    } else {
      return {
        'identity_token': identityToken,
        'authorization_code': authorizationCode,
      };
    }
  }
}
