part of 'todo_bloc.dart';

abstract class TodoEvent {}

class GetTodosEvent extends TodoEvent {}

class CreateTodoEvent extends TodoEvent {
  final Todo todo;
  CreateTodoEvent({required this.todo});
}

class UpdateFiltersEvent extends TodoEvent {
  final TodoFilters filters;
  UpdateFiltersEvent(this.filters);
}

class DeleteTodoEvent extends TodoEvent {
  final String todoID;
  DeleteTodoEvent({required this.todoID});
}