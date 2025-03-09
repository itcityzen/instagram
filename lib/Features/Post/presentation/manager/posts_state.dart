part of 'posts_cubit.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

final class PostLoading extends PostsState {}

final class CreatePostSuccess extends PostsState {}

final class CreatePostFailed extends PostsState {
  String? ErrorMessage;
  CreatePostFailed(this.ErrorMessage);
}

final class UploadImageforPost extends PostsState {
  final File imageFile;
  UploadImageforPost(this.imageFile);
}

final class PostsLoadedSuccess extends PostsState {
  List<PostModel> postModel;
  PostsLoadedSuccess({required this.postModel});
}

final class PostLoadedSuccess extends PostsState {
  final List<PostModel> posts;
  PostLoadedSuccess(this.posts);
}

final class PostLoadedFailure extends PostsState {
  String ErrorMessage;

  PostLoadedFailure(this.ErrorMessage);
}
