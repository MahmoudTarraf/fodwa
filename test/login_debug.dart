import 'package:dio/dio.dart';

void main() async {
  final dio = Dio();
  dio.options.headers['Content-Type'] = 'application/json';
  dio.options.headers['Accept'] = 'application/json';

  final url = 'https://fodwa-backend-blbwk.ondigitalocean.app/api/users/login/';

  print('Target URL: $url');

  // Payload 1: As per current code
  print('\n--- Test 1: email, password, remember_me ---');
  try {
    final response = await dio.post(
      url,
      data: {
        'email': 'test@example.com',
        'password': 'password',
        'remember_me': false,
      },
    );
    print('Status: ${response.statusCode}');
    print('Response: ${response.data}');
  } on DioException catch (e) {
    print('Error Status: ${e.response?.statusCode}');
    print('Error Data: ${e.response?.data}');
  }

  // Payload 2: Without remember_me
  print('\n--- Test 2: email, password (no remember_me) ---');
  try {
    final response = await dio.post(
      url,
      data: {'email': 'test@example.com', 'password': 'password'},
    );
    print('Status: ${response.statusCode}');
    print('Response: ${response.data}');
  } on DioException catch (e) {
    print('Error Status: ${e.response?.statusCode}');
    print('Error Data: ${e.response?.data}');
  }

  // Payload 3: Username instead of email
  print('\n--- Test 3: username, password ---');
  try {
    final response = await dio.post(
      url,
      data: {'username': 'test@example.com', 'password': 'password'},
    );
    print('Status: ${response.statusCode}');
    print('Response: ${response.data}');
  } on DioException catch (e) {
    print('Error Status: ${e.response?.statusCode}');
    print('Error Data: ${e.response?.data}');
  }
}
