/*
abstract class TodoEvent {}

class LoadProfile extends TodoEvent {
  final String userId;
  LoadProfile({required this.userId});
}

class UpdateProfile extends TodoEvent {

}

class DeleteTodo extends TodoEvent {
  DeleteTodo();
}
*/

part of 'todo_bloc.dart';

@immutable
abstract class TodoEvent {}

class GetTodosEvent extends TodoEvent {
}

class CreateTodoEvent extends TodoEvent {
  final Todo todo;

  CreateTodoEvent({required this.todo});
}
