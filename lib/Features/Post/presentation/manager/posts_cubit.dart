import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram2/Features/Post/data/models/PostModel.dart';
import 'package:instagram2/Features/Post/data/repositories/PostRepository.dart';
import 'package:instagram2/Features/Profile/presentation/manager/profile_cubit.dart';
import 'package:instagram2/Features/Register/data/models/UserModel.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  PostRepository postRepository;
  PostsCubit(
    this.postRepository,
  ) : super(PostsInitial());

  TextEditingController descriptionController = TextEditingController();
  File? profileImage;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> createPost(UserModel currentUser) async {
    emit(CreatePostLoading());
    try {
      // image to storage
      String? imageURL;
      if (profileImage != null) {
        imageURL = await postRepository.uploadUrlImage(
            profileImage!, currentUser.uid!);
      }
      // post to Firestore
      PostModel postModel = PostModel(
          username: currentUser.username,
          userID: currentUser.uid,
          postID: Uuid().v1(),
          description: descriptionController.text,
          profileUrl: currentUser.profileUrl,
          createdAt: Timestamp.now(),
          imageURL: imageURL,
          likes: [],
          comments: [],
          sendShare: [],
          totalLikes: 0,
          totalComments: 0,
          totalPosts: 0);

      await postRepository.createPost(postModel);
      emit(CreatePostSuccess());
    } catch (e) {
      emit(CreatePostFailed(e.toString()));
    }
  }

  void setImage(File imageFile) {
    profileImage = imageFile;
    emit(UploadImageforPost(imageFile));
  }


  StreamSubscription<List<PostModel>>? postSubscription;

  void startListeningtoPosts(String uuserID) {
    try {
      emit(ProfilePostLoading());
      postSubscription =
          postRepository.getOnlyMyPosts(uuserID).listen((posts) {
            emit(ProfilePostLoadedSuccess(posts));
          }, onError: (error) {
            emit(ProfilePostLoadedFailure(error.toString()));
          });
    } catch (e) {
      emit(ProfilePostLoadedFailure("Error to get Post ${e.toString()}"));
    }
  }


}
