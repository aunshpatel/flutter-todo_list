abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {
  final String userId;
  LoadProfile({required this.userId});
}

class UpdateProfile extends ProfileEvent {
  final String userId;
  final String username;
  final String fullname;
  final String email;

  UpdateProfile({
    required this.userId,
    required this.username,
    required this.fullname,
    required this.email,
  });
}

class DeleteProfile extends ProfileEvent {
  DeleteProfile();
}

class Logout extends ProfileEvent {}
