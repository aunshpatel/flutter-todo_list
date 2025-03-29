/*
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/user_repositories.dart';
import 'todo_event.dart';
import 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final UserRepository userRepository;

  TodoBloc({required this.userRepository}) : super(TodoInitial()) {
    on<LoadProfile>(_mapLoadProfileToState);
    on<UpdateProfile>(_mapUpdateProfileToState);
    on<DeleteProfile>(_mapDeleteProfileToState);
    on<Logout>(_mapLogoutToState);
  }


}
*/

/*import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../models/todo_model.dart';
import '../../repositories/todo_repositories.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc({required this.todoRepository}) : super(TodoInitial()) {
    on<GetTodosEvent>((event, emit) async {
      try {
        emit(TodoLoading());
        final todos = await todoRepository.getTodos(event.userId);
        emit(TodoLoaded(todos: todos));
      } catch (e) {
        emit(TodoError(error: e.toString()));
      }
    });

    on<CreateTodoEvent>((event, emit) async {
      try {
        emit(TodoLoading());
        final todo = await todoRepository.createTodo(event.todo);
        emit(TodoCreated(todo: todo));
      } catch (e) {
        emit(TodoError(error: e.toString()));
      }
    });
  }
}*/


import 'package:bloc/bloc.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:meta/meta.dart';

import '../../repositories/todo_repositories.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc({required this.todoRepository}) : super(TodoInitial()) {
    on<GetTodosEvent>((event, emit) async {
      try {
        emit(TodoLoading());
        final todos = await todoRepository.getTodos();
        emit(TodoLoaded(todos: todos));
      } catch (e) {
        emit(TodoError(error: e.toString()));
      }
    });

    on<CreateTodoEvent>((event, emit) async {
      try {
        emit(TodoLoading());
        final todo = await todoRepository.createTodo(event.todo);
        emit(TodoCreated(todo: todo));
      } catch (e) {
        emit(TodoError(error: e.toString()));
      }
    });
  }
}
