part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;
  final TodoFilters filters;

  TodoLoaded({required this.todos, required this.filters});
}

class TodoCreatedSuccess extends TodoState {
  final Todo todo;

  TodoCreatedSuccess({required this.todo});
}

class TodoCreationFailure extends TodoState {
  final String error;

  TodoCreationFailure({required this.error});
}

class TodoDeletedSuccess extends TodoState {
  final String todoID;

  TodoDeletedSuccess({required this.todoID});
}

class TodoError extends TodoState {
  final String error;

  TodoError({required this.error});
}
