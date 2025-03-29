/*
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../screens/widgets/consts.dart';

class TodoRepositories{
  Future<Map<String, String>> getAllTodos() async {
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
}*/

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/screens/widgets/consts.dart';

class TodoRepository {

  Future<List<Todo>> getTodos() async {
    print('currentUserID:$currentUserID');
    final response = await http.get(Uri.parse('$apiLinkConstant/todos/get-all-todos/$currentUserID'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((todo) => Todo.fromJson(todo)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<Todo> createTodo(Todo todo) async {
    final response = await http.post(
      Uri.parse('$apiLinkConstant/todos/create'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(todo.toJson()),
    );

    if (response.statusCode == 201) {
      return Todo.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create todo');
    }
  }
}

