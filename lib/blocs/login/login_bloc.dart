import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;

  LoginBloc({required this.authRepository}) : super(LoginInitial()) {
    on<LoginSubmitted>((event, emit) async {
      emit(LoginLoading());

      final bool success = await authRepository.login(event.email, event.password);

      if (success) {
        emit(LoginSuccess());  // This references LoginSuccess from login_state.dart
      } else {
        emit(LoginFailure(error: "Invalid credentials"));
      }
    });
  }
}