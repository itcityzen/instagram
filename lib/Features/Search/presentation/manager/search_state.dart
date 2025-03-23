part of 'search_cubit.dart';

@immutable
sealed class SearchState {}

final class SearchInitial extends SearchState {}


final class ExploreLoading extends SearchState {}

final class ExploreSuccess extends SearchState {
  List<PostModel> posts;
  ExploreSuccess(this.posts);
}

final class ExploreError extends SearchState {
  String ErrorMessage;
  ExploreError(this.ErrorMessage);
}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  List<UserModel> users;
  SearchSuccess(this.users);
}

final class SearchError extends SearchState {
  String ErrorMessage;
  SearchError(this.ErrorMessage);
}
