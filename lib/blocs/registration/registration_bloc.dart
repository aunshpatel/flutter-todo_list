import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import '../../repositories/auth_repository.dart';
part 'registration_event.dart';  // Ensure this file exists
part 'registration_state.dart';   // Ensure this file exists

/*class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository authRepository;

  RegistrationBloc({required this.authRepository}) : super(RegistrationInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      try {
        emit(RegistrationInProgress());

        // Call the registration function from the repository
        await authRepository.registerUser(
          username: event.username,
          fullName: event.fullName,
          email: event.email,
          password: event.password,
        );

        emit(RegistrationSuccess());
      } catch (e) {
        emit(RegistrationFailure(error: e.toString()));
      }
    });
  }
}*/

/*class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository authRepository;

  RegistrationBloc({required this.authRepository}) : super(RegistrationInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      try {
        emit(RegistrationInProgress());

        // Call the registerUser method from the repository
        await authRepository.registerUser(
          username: event.username,
          fullName: event.fullName,
          email: event.email,
          password: event.password,
        );

        emit(RegistrationSuccess());
      } catch (e) {
        emit(RegistrationFailure(error: e.toString()));
      }
    });
  }
}*/

class RegistrationBloc extends Bloc<RegistrationEvent, RegistrationState> {
  final AuthRepository authRepository;

  RegistrationBloc({required this.authRepository}) : super(RegistrationInitial()) {
    on<RegisterUserEvent>((event, emit) async {
      try {
        emit(RegistrationLoading());  // Emit the loading state

        await authRepository.registerUser(
          username: event.username,
          fullName: event.fullName,
          email: event.email,
          password: event.password,
        );

        emit(RegistrationSuccess());
      } catch (e) {
        emit(RegistrationFailure(error: e.toString()));
      }
    });
  }
}
