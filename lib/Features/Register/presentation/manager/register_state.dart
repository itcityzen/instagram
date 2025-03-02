part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterSuccess extends RegisterState {
  final User user;
  final String profileImageURL;
  RegisterSuccess(this.user, this.profileImageURL);
}

final class RegisterFailure extends RegisterState {
  final String ErrorMessage;

  RegisterFailure(this.ErrorMessage);
}

final class ProfileImageSelected extends RegisterState {
  final File imageFile;

  ProfileImageSelected(this.imageFile);
}

final class GenederSelected extends RegisterState {
  final String Gender;

  GenederSelected(this.Gender);
}
