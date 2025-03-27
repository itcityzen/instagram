part of 'follow_cubit.dart';

@immutable
sealed class FollowState {}

final class FollowInitial extends FollowState {}

final class FollowLoading extends FollowState {}

final class FollowSuccess extends FollowState {
  List<UserModel> users;
  FollowSuccess(this.users);
}

final class FollowError extends FollowState {
  String ErrorMessage;
  FollowError(this.ErrorMessage);
}
