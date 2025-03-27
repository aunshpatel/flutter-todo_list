/*
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String username;
  final String fullname;
  final String email;

  ProfileLoaded({
    required this.username,
    required this.fullname,
    required this.email,
  });
}

class ProfileUpdateSuccess extends ProfileState {}

class ProfileUpdateFailure extends ProfileState {
  final String error;

  ProfileUpdateFailure({required this.error});
}

class ProfileFailure extends ProfileState {
  final String error;

  ProfileFailure({required this.error});
}

class ProfileDeleted extends ProfileState {}

class LogoutSuccess extends ProfileState {}
*/

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String username;
  final String fullname;
  final String email;

  ProfileLoaded({
    required this.username,
    required this.fullname,
    required this.email,
  });
}

class ProfileUpdateSuccess extends ProfileState {}

class ProfileUpdateFailure extends ProfileState {
  final String error;
  ProfileUpdateFailure({required this.error});
}

class ProfileFailure extends ProfileState {
  final String error;
  ProfileFailure({required this.error});
}

class ProfileDeleted extends ProfileState {}

class LogoutSuccess extends ProfileState {}
