import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screens/widgets/consts.dart';

class UserRepository{
  // Get the user profile data
  Future<Map<String, String>> getUserProfile() async {
    final response = await http.get(Uri.parse('$apiLinkConstant/user/get-user/$currentUserID'));
    if (response.statusCode == 200) {
      // Assuming the response is a list, we'll grab the first element
      Map<String, dynamic> userProfile = json.decode(response.body);
      if (userProfile.isNotEmpty) {
        return {
          'username': userProfile['username'],
          'fullname': userProfile['fullname'],
          'email': userProfile['email'],
        };
      } else {
        throw Exception('User not found');
      }
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<void> updateProfile(String username, String fullname, String email, String password) async {
    final response = await http.post(Uri.parse('$apiLinkConstant/user/update/$currentUserID'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({
        "username": username,
        "fullname": fullname,
        "email": email,
        "password": password,
      }),
    );

    if (response.statusCode == 200) {
      print("Profile updated successfully");
    } else {
      final errorMessage = jsonDecode(response.body)['message'] ?? "Failed to update profile";
      throw Exception("Error: $errorMessage");
    }
  }

  // Delete the user profile
  Future<void> deleteProfile() async {
    final response = await http.delete(Uri.parse('$apiLinkConstant/user/delete/$currentUserID'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete profile');
    }
  }

  // Logout the user
  Future<void> logout() async {
    final response = await http.post(Uri.parse('$apiLinkConstant/user/logout'));

    if (response.statusCode != 200) {
      throw Exception('Failed to logout');
    }
  }
}