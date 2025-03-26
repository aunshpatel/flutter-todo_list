abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UpdateProfile extends ProfileEvent {
  final String username;
  final String fullname;
  final String email;

  UpdateProfile({
    required this.username,
    required this.fullname,
    required this.email,
  });
}

class DeleteProfile extends ProfileEvent {}

class Logout extends ProfileEvent {}
