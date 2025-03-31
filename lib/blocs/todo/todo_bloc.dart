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


/*import 'package:bloc/bloc.dart';
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
}*/

/*
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/repositories/todo_repositories.dart';
import 'package:intl/intl.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  List<Todo> _allTodos = []; // Store unfiltered todos
  TodoFilters _currentFilters = TodoFilters(); // Store current filters

  TodoBloc({required this.todoRepository}) : super(TodoInitial()) {
    // Load Todos Event
    on<GetTodosEvent>((event, emit) async {
      try {
        emit(TodoLoading());
        _allTodos = await todoRepository.getTodos(); // Fetch todos from API
        _applyFilters(emit);
      } catch (e) {
        emit(TodoError(error: e.toString()));
      }
    });

    // Create Todo Event
    on<CreateTodoEvent>((event, emit) async {
      try {
        emit(TodoLoading());
        final todo = await todoRepository.createTodo(event.todo);
        _allTodos.add(todo); // Add new todo to the list
        _applyFilters(emit);
      } catch (e) {
        emit(TodoError(error: e.toString()));
      }
    });

    // Update Filters Event
    on<UpdateFiltersEvent>((event, emit) {
      _currentFilters = event.filters;
      _applyFilters(emit);
    });
  }

  void _applyFilters(Emitter<TodoState> emit) {
    List<Todo> filteredTodos = _allTodos.where((todo) {
      bool statusMatch = _currentFilters.status.isEmpty ||
          todo.status.toLowerCase() == _currentFilters.status.toLowerCase();

      bool priorityMatch = _currentFilters.priority.isEmpty ||
          todo.priority.toLowerCase() == _currentFilters.priority.toLowerCase();

      return statusMatch && priorityMatch;
    }).toList();

    // 🔹 Corrected Start Date Sorting
    if (_currentFilters.startDateOrder.isNotEmpty) {
      filteredTodos.sort((a, b) {
        DateTime? dateA = _safeParseDate(a.startDate);
        DateTime? dateB = _safeParseDate(b.startDate);

        if (dateA == null || dateB == null) return 0; // Skip if date is invalid

        return _currentFilters.startDateOrder == "ascending"
            ? dateA.compareTo(dateB)
            : dateB.compareTo(dateA);
      });
    }

    // 🔹 Apply Status Order Sorting
    if (_currentFilters.statusOrder.isNotEmpty) {
      filteredTodos.sort((a, b) {
        const statusOrder = ['Pending', 'In-Progress', 'Completed'];
        if (_currentFilters.statusOrder == 'ascending') {
          return statusOrder.indexOf(a.status) - statusOrder.indexOf(b.status);
        } else {
          return statusOrder.indexOf(b.status) - statusOrder.indexOf(a.status);
        }
      });
    }

    // 🔹 Apply Priority Order Sorting
    if (_currentFilters.priorityOrder.isNotEmpty) {
      filteredTodos.sort((a, b) {
        const priorityOrder = ['Low', 'Medium', 'High'];
        if (_currentFilters.priorityOrder == 'ascending') {
          return priorityOrder.indexOf(a.priority) - priorityOrder.indexOf(b.priority);
        } else {
          return priorityOrder.indexOf(b.priority) - priorityOrder.indexOf(a.priority);
        }
      });
    }

    emit(TodoLoaded(todos: filteredTodos, filters: _currentFilters));
  }

  // 🔹 New Date Parsing Function (Handles Various Formats)
  DateTime? _safeParseDate(String date) {
    try {
      return DateFormat("d MMMM, yyyy").parse(date);
    } catch (e) {
      print("⚠️ Date Parsing Error: '$date' is invalid.");
      return null;
    }
  }

  // Getter to retrieve filtered todos from the state
  List<Todo> get filteredTodos => state is TodoLoaded ? (state as TodoLoaded).todos : [];
}*/


import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_list/models/todo_model.dart';
import 'package:todo_list/repositories/todo_repositories.dart';
import 'package:intl/intl.dart';
part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;
  List<Todo> _allTodos = []; // Store unfiltered todos
  TodoFilters _currentFilters = TodoFilters(); // Store current filters

  TodoBloc({required this.todoRepository}) : super(TodoInitial()) {
    // Load Todos Event
    on<GetTodosEvent>((event, emit) async {
      try {
        emit(TodoLoading());
        _allTodos = await todoRepository.getTodos(); // Fetch todos from API
        _applyFilters(emit);
      } catch (e) {
        emit(TodoError(error: e.toString()));
      }
    });

    // Create Todo Event
    on<CreateTodoEvent>((event, emit) async {
      try {
        emit(TodoLoading());
        final todo = await todoRepository.createTodo(event.todo);
        if (todo != null) {
          _allTodos.add(todo); // Add new todo to the list
          emit(TodoCreatedSuccess(todo: todo)); // ✅ Successful todo creation
          _applyFilters(emit);
        } else {
          emit(TodoCreationFailure(error: "Failed to create Todo"));
        }
      } catch (e) {
        emit(TodoCreationFailure(error: e.toString())); // ❌ Failure state
      }
    });

    // Update Filters Event
    on<UpdateFiltersEvent>((event, emit) {
      _currentFilters = event.filters;
      _applyFilters(emit);
    });
  }

  void _applyFilters(Emitter<TodoState> emit) {
    List<Todo> filteredTodos = _allTodos.where((todo) {
      bool statusMatch = _currentFilters.status.isEmpty ||
          todo.status.toLowerCase() == _currentFilters.status.toLowerCase();

      bool priorityMatch = _currentFilters.priority.isEmpty ||
          todo.priority.toLowerCase() == _currentFilters.priority.toLowerCase();

      return statusMatch && priorityMatch;
    }).toList();

    // 🔹 Corrected Start Date Sorting
    if (_currentFilters.startDateOrder.isNotEmpty) {
      filteredTodos.sort((a, b) {
        DateTime? dateA = _safeParseDate(a.startDate);
        DateTime? dateB = _safeParseDate(b.startDate);

        if (dateA == null || dateB == null) return 0; // Skip if date is invalid

        return _currentFilters.startDateOrder == "ascending"
            ? dateA.compareTo(dateB)
            : dateB.compareTo(dateA);
      });
    }

    // 🔹 Apply Status Order Sorting
    if (_currentFilters.statusOrder.isNotEmpty) {
      filteredTodos.sort((a, b) {
        const statusOrder = ['Pending', 'In-Progress', 'Completed'];
        if (_currentFilters.statusOrder == 'ascending') {
          return statusOrder.indexOf(a.status) - statusOrder.indexOf(b.status);
        } else {
          return statusOrder.indexOf(b.status) - statusOrder.indexOf(a.status);
        }
      });
    }

    // 🔹 Apply Priority Order Sorting
    if (_currentFilters.priorityOrder.isNotEmpty) {
      filteredTodos.sort((a, b) {
        const priorityOrder = ['Low', 'Medium', 'High'];
        if (_currentFilters.priorityOrder == 'ascending') {
          return priorityOrder.indexOf(a.priority) - priorityOrder.indexOf(b.priority);
        } else {
          return priorityOrder.indexOf(b.priority) - priorityOrder.indexOf(a.priority);
        }
      });
    }

    emit(TodoLoaded(todos: filteredTodos, filters: _currentFilters));
  }

  // 🔹 New Date Parsing Function (Handles Various Formats)
  DateTime? _safeParseDate(String date) {
    try {
      return DateFormat("d MMMM, yyyy").parse(date);
    } catch (e) {
      print("⚠️ Date Parsing Error: '$date' is invalid.");
      return null;
    }
  }

  // Getter to retrieve filtered todos from the state
  List<Todo> get filteredTodos => state is TodoLoaded ? (state as TodoLoaded).todos : [];
}
