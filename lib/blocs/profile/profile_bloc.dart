import 'package:bloc/bloc.dart';
import '../../repositories/user_repositories.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc({required this.userRepository}) : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfile) {
      yield* _mapLoadProfileToState();
    } else if (event is UpdateProfile) {
      yield* _mapUpdateProfileToState(event);
    } else if (event is DeleteProfile) {
      yield* _mapDeleteProfileToState();
    } else if (event is Logout) {
      yield* _mapLogoutToState();
    }
  }

  // Load profile from the repository
  Stream<ProfileState> _mapLoadProfileToState() async* {
    yield ProfileLoading();
    try {
      final profile = await userRepository.getUserProfile();
      yield ProfileLoaded(
        username: profile['username'] ?? '',
        fullname: profile['fullname'] ?? '',
        email: profile['email'] ?? '',
      );
    } catch (e) {
      yield ProfileFailure(error: e.toString());
    }
  }

  // Update profile
  Stream<ProfileState> _mapUpdateProfileToState(UpdateProfile event) async* {
    yield ProfileLoading();
    try {
      await userRepository.updateProfile(
        event.username,
        event.fullname,
        event.email,
      );
      yield ProfileUpdateSuccess();
    } catch (e) {
      yield ProfileUpdateFailure(error: e.toString());
    }
  }

  // Delete profile
  Stream<ProfileState> _mapDeleteProfileToState() async* {
    yield ProfileLoading();
    try {
      await userRepository.deleteProfile();
      yield ProfileDeleted();
    } catch (e) {
      yield ProfileFailure(error: e.toString());
    }
  }

  // Handle logout
  Stream<ProfileState> _mapLogoutToState() async* {
    yield ProfileLoading();
    try {
      await userRepository.logout();
      yield LogoutSuccess();
    } catch (e) {
      yield ProfileFailure(error: e.toString());
    }
  }
}
