import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../screens/widgets/consts.dart';

class AuthRepository {
  Future<void> registerUser({
    required String username,
    required String fullName,
    required String email,
    required String password,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$apiLinkConstant/auth/register'),
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
        print('Registration successful');
      } else {
        throw Exception('Failed to register user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$apiLinkConstant/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );


      if (response.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        print("responseData['_id']:${responseData['_id']}");
        prefs.setString('currentUserID', responseData['_id']);
        currentUserID = responseData['_id'];
        prefs.setString('name', responseData['fullname']);
        prefs.setString('username', responseData['username']);
        prefs.setString('email', responseData['email']);
        prefs.setString('password', password);
        prefs.setBool('isLoggedIn', true);
        return true;
      } else {
        prefs.setBool('isLoggedIn', false);
        return false;
      }
    } catch (e) {
      print('Login error: $e');
      return false;
    }
  }
}

