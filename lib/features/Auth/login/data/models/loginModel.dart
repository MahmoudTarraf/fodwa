class LoginModel {
  final String? email;
  final String? phone;
  final String password;
  final bool rememberMe;

  LoginModel({
    this.email,
    this.phone,
    required this.password,
    this.rememberMe = false,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
      email: json['email'],
      phone: json['phone_number'],
      password: json['password'] ?? '',
      rememberMe: json['remember_me'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      if (email != null && email!.isNotEmpty) 'email': email,
      if (phone != null && phone!.isNotEmpty) 'phone_number': phone,
      'password': password,
      'remember_me': rememberMe,
    };
  }
}
