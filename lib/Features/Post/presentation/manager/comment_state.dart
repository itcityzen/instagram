part of 'comment_cubit.dart';

@immutable
sealed class CommentState {}

final class CommentInitial extends CommentState {}

final class CreateCommentLoading extends CommentState {}

final class CreateCommentSuccess extends CommentState {}

final class CreateCommentFailure extends CommentState {
  final String errorMessage;
  CreateCommentFailure(this.errorMessage);
}

final class CommentLoading extends CommentState {}

final class CommentLoadedSuccess extends CommentState {
  final List<CommentModel> comments;
  CommentLoadedSuccess(this.comments);
}

final class CommentLoadedError extends CommentState {
  final String errorMessage;
  CommentLoadedError(this.errorMessage);
}
