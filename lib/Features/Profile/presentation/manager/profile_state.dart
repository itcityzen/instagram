part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoadedSuccess extends ProfileState {
  final UserModel user;
  ProfileLoadedSuccess(this.user);
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
final class PostLoading extends ProfileState {}


final class PostLoadedSuccess extends ProfileState {
  final List<PostModel> posts;
  PostLoadedSuccess(this.posts);
}

final class PostLoadedFailure extends ProfileState {
  String ErrorMessage;

  PostLoadedFailure(this.ErrorMessage);
}


