import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram2/Features/Post/data/models/PostModel.dart';
import 'package:instagram2/Features/Post/data/repositories/PostRepository.dart';
import 'package:instagram2/Features/Profile/presentation/manager/profile_cubit.dart';
import 'package:meta/meta.dart';
import 'package:uuid/uuid.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  ProfileCubit profileCubit;
  PostRepository postRepository;
  PostsCubit(this.postRepository, this.profileCubit) : super(PostsInitial());

  TextEditingController descriptionController = TextEditingController();
  File? profileImage;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> createPost() async {
    try {
      final UserCubit = profileCubit.currentUser!;

      // image to storage
      String? imageURL;
      if (profileImage != null) {
        imageURL = await postRepository.uploadUrlImage(
            profileImage!, profileCubit.currentUser!.uid!);
      }
      // post to Firestore
      PostModel postModel = PostModel(
          username: UserCubit.username,
          userID: UserCubit.uid,
          postID: Uuid().v1(),
          description: descriptionController.text,
          profileUrl: UserCubit.profileUrl,
          createdAt: DateTime.now().toString(),
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
}
