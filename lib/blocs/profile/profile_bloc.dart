/*
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/user_repositories.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc({required this.userRepository}) : super(ProfileInitial()) {
    on<LoadProfile>(_mapLoadProfileToState);
    on<UpdateProfile>(_mapUpdateProfileToState);
    on<DeleteProfile>(_mapDeleteProfileToState);
    on<Logout>(_mapLogoutToState);
  }

  // Load profile from the repository
  Future<void> _mapLoadProfileToState(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await userRepository.getUserProfile();
      emit(ProfileLoaded(
        username: profile['username'] ?? '',
        fullname: profile['fullname'] ?? '',
        email: profile['email'] ?? '',
      ));
    } catch (e) {
      emit(ProfileFailure(error: 'Failed to load profile: ${e.toString()}'));
    }
  }

  // Update profile
  Future<void> _mapUpdateProfileToState(UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await userRepository.updateProfile(
        event.username,
        event.fullname,
        event.email,
        event.password,
      );
      emit(ProfileUpdateSuccess());
    } catch (e) {
      emit(ProfileUpdateFailure(error: 'Update failed: ${e.toString()}'));
    }
  }

  // Delete profile
  Future<void> _mapDeleteProfileToState(
      DeleteProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await userRepository.deleteProfile();
      emit(ProfileDeleted());
    } catch (e) {
      emit(ProfileFailure(error: 'Deletion failed: ${e.toString()}'));
    }
  }

  // Handle logout
  Future<void> _mapLogoutToState(
      Logout event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await userRepository.logout();
      emit(LogoutSuccess());
    } catch (e) {
      emit(ProfileFailure(error: 'Logout failed: ${e.toString()}'));
    }
  }
}
*/

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/user_repositories.dart';
import 'profile_event.dart';
import 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final UserRepository userRepository;

  ProfileBloc({required this.userRepository}) : super(ProfileInitial()) {
    on<LoadProfile>(_mapLoadProfileToState);
    on<UpdateProfile>(_mapUpdateProfileToState);
    on<DeleteProfile>(_mapDeleteProfileToState);
    on<Logout>(_mapLogoutToState);
  }

  // Load profile from the repository
  Future<void> _mapLoadProfileToState(LoadProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await userRepository.getUserProfile();
      emit(ProfileLoaded(
        username: profile['username'] ?? '',
        fullname: profile['fullname'] ?? '',
        email: profile['email'] ?? '',
      ));
    } catch (e) {
      emit(ProfileFailure(error: 'Failed to load profile: ${e.toString()}'));
    }
  }

  // Update profile
  Future<void> _mapUpdateProfileToState(UpdateProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await userRepository.updateProfile(
        event.username,
        event.fullname,
        event.email,
        event.password,
      );
      emit(ProfileUpdateSuccess());
    } catch (e) {
      emit(ProfileUpdateFailure(error: 'Update failed: ${e.toString()}'));
    }
  }

  // Delete profile
  Future<void> _mapDeleteProfileToState(DeleteProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await userRepository.deleteProfile();
      emit(ProfileDeleted());
    } catch (e) {
      emit(ProfileFailure(error: 'Deletion failed: ${e.toString()}'));
    }
  }

  // Handle logout
  Future<void> _mapLogoutToState(Logout event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      await userRepository.logout();
      emit(LogoutSuccess());
    } catch (e) {
      emit(ProfileFailure(error: 'Logout failed: ${e.toString()}'));
    }
  }
}
