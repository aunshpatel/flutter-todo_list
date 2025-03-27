part of 'registration_bloc.dart';

abstract class RegistrationEvent {}

class RegisterUserEvent extends RegistrationEvent {
  final String username;
  final String fullName;
  final String email;
  final String password;

  RegisterUserEvent({
    required this.username,
    required this.fullName,
    required this.email,
    required this.password,
  });
}
