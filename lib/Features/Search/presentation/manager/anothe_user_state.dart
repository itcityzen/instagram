part of 'anothe_user_cubit.dart';

@immutable
sealed class AnotherUserState {}

final class AnotherUserInitial extends AnotherUserState {}

final class anotherUserLoading extends AnotherUserState {}

final class anotherUserSuccess extends AnotherUserState {
  UserModel user;
  anotherUserSuccess(this.user);
}

final class anotherUserError extends AnotherUserState {
  String ErrorMessage;
  anotherUserError(this.ErrorMessage);
}
