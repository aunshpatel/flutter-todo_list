abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {
  final String userId;
  LoadProfile({required this.userId});
}

class UpdateProfile extends ProfileEvent {
  final String username;
  final String fullname;
  final String email;
  final String password;

  UpdateProfile({
    required this.username,
    required this.fullname,
    required this.email,
    required this.password,
  });
}

class DeleteProfile extends ProfileEvent {
  DeleteProfile();
}

class Logout extends ProfileEvent {}
