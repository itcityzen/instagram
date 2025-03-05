part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoadedSuccess extends ProfileState {
  final UserModel user;
  final List<PostModel> posts ;
  ProfileLoadedSuccess(this.user, this.posts);
}

final class ProfileLoadedFailure extends ProfileState {
  String ErrorMessage;

  ProfileLoadedFailure(this.ErrorMessage);
}

final class ProfileUpdated extends ProfileState {}

final class ProfileImageUpdate extends ProfileState {
  final File imageFile;

  ProfileImageUpdate(this.imageFile);
}
