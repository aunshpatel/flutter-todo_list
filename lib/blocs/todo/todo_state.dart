/*
import 'dart:ffi';

abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final String title;
  final String description;
  final String startDate;
  final String startTime;
  final String endDate;
  final String endTime;
  final Bool allDay;
  final String priority;
  final String status;
  final String userRef;

  TodoLoaded({
    required this.title,
    required this.description,
    required this.startDate,
    required this.startTime,
    required this.endDate,
    required this.endTime,
    required this.allDay,
    required this.priority,
    required this.status,
    required this.userRef,
  });
}

class TodoUpdateSuccess extends TodoState {}

class TodoUpdateFailure extends TodoState {
  final String error;
  TodoUpdateFailure({required this.error});
}

class TodoFailure extends TodoState {
  final String error;
  TodoFailure({required this.error});
}

class TodoDeleted extends TodoState {}
*//*


*/
/*
part of 'todo_bloc.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<Todo> todos;

  TodoLoaded({required this.todos});
}

class TodoCreated extends TodoState {
  final Todo todo;

  TodoCreated({required this.todo});
}

class TodoError extends TodoState {
  final String error;

  TodoError({required this.error});
}
*//*


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

class TodoCreated extends TodoState {
  final Todo todo;

  TodoCreated({required this.todo});
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
