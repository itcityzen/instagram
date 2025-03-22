import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram2/Features/Post/data/repositories/PostRepository.dart';
import 'package:instagram2/Features/Register/data/models/UserModel.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

import '../../data/models/CommentModel.dart';

part 'comment_state.dart';

class CommentCubit extends Cubit<CommentState> {
  PostRepository postRepository;
  CommentCubit(this.postRepository) : super(CommentInitial());

  TextEditingController commentController = TextEditingController();
  StreamSubscription<List<CommentModel>>? commentSubscription;

  Future<void> createComment(String postId, UserModel currentUser) async {
    emit(CreateCommentLoading());
    try {
      if (commentController.text.isEmpty) {
        emit(
            CreateCommentFailure("Please fill all required fields correctly."));
        return;
      }
      CommentModel comment = CommentModel(
        commentId: Uuid().v4(),
        postId: postId,
        userId: currentUser.uid,
        comment: commentController.text,
        username: currentUser.username,
        userProfileUrl: currentUser.profileUrl,
        createdAt: Timestamp.now(),
      );
      await postRepository.createComment(comment);
      getComments(postId);
      emit(CreateCommentSuccess());
      print("Comment Created");
    } catch (e) {
      emit(CreateCommentFailure(e.toString()));
    }
  }

  void getComments(String postId) {
    emit(CommentLoading());
    commentSubscription =
        postRepository.getComments(postId).listen((ListComments) {
      emit(CommentLoadedSuccess(ListComments));
      print("List of comments ${ListComments.length}");
    }, onError: (error) {
      emit(CommentLoadedError(error.toString()));
    });
  }
}
