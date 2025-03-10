part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomePostLoading extends HomeState {}

final class HomePostLoadedSuccess extends HomeState {
  final List<PostModel> posts;
  HomePostLoadedSuccess(this.posts);
}

final class HomePostLoadedFailure extends HomeState {
  String ErrorMessage;

  HomePostLoadedFailure(this.ErrorMessage);
}
