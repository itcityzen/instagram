part of 'posts_cubit.dart';

@immutable
sealed class PostsState {}

final class PostsInitial extends PostsState {}

final class PostLoading extends PostsState {}

final class CreatePostLoading extends PostsState {}

final class CreatePostSuccess extends PostsState {}

final class CreatePostFailed extends PostsState {
  String? ErrorMessage;
  CreatePostFailed(this.ErrorMessage);
}

final class UploadImageforPost extends PostsState {
  final File imageFile;
  UploadImageforPost(this.imageFile);
}

final class ProfilePostLoading extends PostsState {}

final class ProfilePostLoadedSuccess extends PostsState {
  List<PostModel> posts;
  ProfilePostLoadedSuccess(this.posts);
}

final class ProfilePostLoadedFailure extends PostsState {
  String ErrorMessage;
  ProfilePostLoadedFailure(this.ErrorMessage);
}


final class DeletePostLoading extends PostsState {}

final class DeletePostSuccess extends PostsState {}

final class DeletePostFailed extends PostsState {
  String? ErrorMessage;
  DeletePostFailed(this.ErrorMessage);
}


