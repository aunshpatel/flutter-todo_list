part of 'registration_bloc.dart';

abstract class RegistrationState {}

class RegistrationInitial extends RegistrationState {}

class RegistrationLoading extends RegistrationState {}  // Define this state

class RegistrationSuccess extends RegistrationState {}

class RegistrationFailure extends RegistrationState {
  final String error;

  RegistrationFailure({required this.error});
}
