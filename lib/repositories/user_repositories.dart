import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screens/widgets/consts.dart';

class UserRepository{
  /*Future<Map<String, dynamic>?> getUserProfile(String userId) async {
    try {
      final response = await http.get(Uri.parse('$apiLinkConstant/user/get-user/$userId'));
      if (response.statusCode == 200) {
        return jsonDecode(response.body); // Convert response to Map
      } else {
        print('Failed to fetch user data: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }*/

  // Get the user profile data
  Future<Map<String, String>> getUserProfile() async {
    print("currentUserID 2:$currentUserID");
    final response = await http.get(Uri.parse('$apiLinkConstant/user/get-user/$currentUserID'));
    print('response.body:${response.body}');
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

  // Update the user profile
  Future<void> updateProfile(String username, String fullname, String email) async {
    final response = await http.put(
      Uri.parse('$apiLinkConstant/user/update-user/$currentUserID'),
      body: {
        'username': username,
        'fullname': fullname,
        'email': email,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile');
    }
  }

  // Delete the user profile
  Future<void> deleteProfile() async {
    final response = await http.delete(Uri.parse('$apiLinkConstant/user/delete-user/:id'));

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