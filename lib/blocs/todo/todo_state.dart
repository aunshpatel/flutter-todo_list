/*
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

class TodoError extends TodoState {
  final String error;

  TodoError({required this.error});
}

// Model for Filters
class TodoFilters {
  final String status;
  final String priority;
  final String startDateOrder;
  final String statusOrder;
  final String priorityOrder;

  const TodoFilters({
    this.status = "",
    this.priority = "",
    this.startDateOrder = "",
    this.statusOrder = "",
    this.priorityOrder = "",
  });

  TodoFilters copyWith({
    String? status,
    String? priority,
    String? startDateOrder,
    String? statusOrder,
    String? priorityOrder,
  }) {
    return TodoFilters(
      status: status ?? this.status,
      priority: priority ?? this.priority,
      startDateOrder: startDateOrder ?? this.startDateOrder,
      statusOrder: statusOrder ?? this.statusOrder,
      priorityOrder: priorityOrder ?? this.priorityOrder,
    );
  }
}
*/

part of 'todo_bloc.dart';

/*@immutable
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

// Model for Filters
class TodoFilters {
  final String status;
  final String priority;
  final String startDateOrder;
  final String statusOrder;
  final String priorityOrder;

  const TodoFilters({
    this.status = "",
    this.priority = "",
    this.startDateOrder = "",
    this.statusOrder = "",
    this.priorityOrder = "",
  });

  TodoFilters copyWith({
    String? status,
    String? priority,
    String? startDateOrder,
    String? statusOrder,
    String? priorityOrder,
  }) {
    return TodoFilters(
      status: status ?? this.status,
      priority: priority ?? this.priority,
      startDateOrder: startDateOrder ?? this.startDateOrder,
      statusOrder: statusOrder ?? this.statusOrder,
      priorityOrder: priorityOrder ?? this.priorityOrder,
    );
  }
}*/

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

// Model for Filters
class TodoFilters {
  final String status;
  final String priority;
  final String startDateOrder;
  final String statusOrder;
  final String priorityOrder;

  const TodoFilters({
    this.status = "",
    this.priority = "",
    this.startDateOrder = "",
    this.statusOrder = "",
    this.priorityOrder = "",
  });

  TodoFilters copyWith({
    String? status,
    String? priority,
    String? startDateOrder,
    String? statusOrder,
    String? priorityOrder,
  }) {
    return TodoFilters(
      status: status ?? this.status,
      priority: priority ?? this.priority,
      startDateOrder: startDateOrder ?? this.startDateOrder,
      statusOrder: statusOrder ?? this.statusOrder,
      priorityOrder: priorityOrder ?? this.priorityOrder,
    );
  }
}
