import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:instagram2/Features/Post/presentation/manager/posts_cubit.dart';
import 'package:instagram2/Features/Profile/data/repositories/ProfileRepository.dart';
import 'package:instagram2/Features/Register/data/models/UserModel.dart';
import 'package:meta/meta.dart';

import '../../../Post/data/models/PostModel.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileRepository profileRepository;
  ProfileCubit(this.profileRepository) : super(ProfileInitial());

  final TextEditingController bioController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  File? profileImage;

  UserModel? currentUser;

  Future<void> getUserData() async {
    /*if (currentUser != null) {
      emit(ProfileLoadedSuccess(currentUser!));
      return;
    }*/
    emit(ProfileLoading());
    try {
      String? UID = FirebaseAuth.instance.currentUser?.uid;
      if (UID != null) {
        final user = await profileRepository.getUserData(UID);
        currentUser = user;
        bioController.text = user.bio ?? '';
        usernameController.text = user.username ?? '';
        phoneController.text = user.phone ?? '';
        websiteController.text = user.website ?? '';
        emit(ProfileLoadedSuccess(user));
      } else {
        emit(ProfileLoadedFailure('Error to get User'));
      }
    } catch (e) {
      throw Exception("Error to get User ${e.toString()}");
    }
  }

  Future<void> updateUserData() async {
    if (currentUser == null) return;
    emit(ProfileLoading());

    try {
      // image to storage
      String? imageURL;
      if (profileImage != null) {
        imageURL = await profileRepository.uploadUrlImage(
            profileImage!, currentUser!.uid!);
      }
      // User to Firestore
      UserModel updatedUser = UserModel(
        uid: currentUser!.uid,
        username: usernameController.text.trim(),
        bio: bioController.text.trim(),
        phone: phoneController.text.trim(),
        website: websiteController.text.trim(),
        email: currentUser!.email,
        profileUrl: imageURL ?? currentUser!.profileUrl,
        totalPosts: currentUser!.totalPosts,
        followers: currentUser!.followers,
        following: currentUser!.following,
      );
      await profileRepository.updateUserData(updatedUser);
      currentUser = updatedUser;
      emit(ProfileLoadedSuccess(updatedUser));
      emit(
        ProfileUpdated(),
      );
    } catch (e) {
      emit(ProfileLoadedFailure('Error Updating User ${e.toString()}'));
    }
  }

  void setImage(File imageFile) {
    profileImage = imageFile;
    emit(ProfileImageUpdate(imageFile));
  }

}
