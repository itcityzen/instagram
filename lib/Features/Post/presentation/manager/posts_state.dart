part of 'posts_cubit.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

final class PostsLoading extends PostsState {}

final class PostsLoadedSuccess extends PostsState {
  List<PostModel> postModel;
  PostsLoadedSuccess({required this.postModel});
}

final class PostsErrorLoaded extends PostsState {
  String? ErrorMessage;

  PostsErrorLoaded(this.ErrorMessage);
}

final class UploadImageforPost extends PostsState {
  final File imageFile;

  UploadImageforPost(this.imageFile);
}

final class CreatePost extends PostsState {}
