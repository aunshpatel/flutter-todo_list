import 'package:http/http.dart' as http;
import 'dart:convert';
import '../screens/widgets/consts.dart';

class AuthRepository {

  // Define the registerUser method
  Future<void> registerUser({
    required String username,
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$apiLinkConstant/auth/register'), // Adjust this endpoint based on your API
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'username': username,
          'fullname': fullName,
          'email': email,
          'password': password,
        }),
      );

      if (response.statusCode == 201) {
        // Successful registration
        print('Registration successful');
      } else {
        // Handle error
        throw Exception('Failed to register user');
      }
    } catch (e) {
      rethrow; // Rethrow the error to handle it in the BLoC
    }
  }
}