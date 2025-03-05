import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram2/Features/Post/data/models/PostModel.dart';
import 'package:instagram2/Features/Register/data/models/UserModel.dart';

import '../../../../Core/Firebase Services/FirebaseStorageService.dart';
import 'ProfileRepository.dart';

class ProfileRepositoryImplementation implements ProfileRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorageService storageService;

  ProfileRepositoryImplementation(this.firestore, this.storageService);

  @override
  Future<UserModel> getUserData(String uid) async {
    try {
      DocumentSnapshot documentSnapshot =
          await firestore.collection("Users").doc(uid).get();
      if (documentSnapshot.exists && documentSnapshot.data() != null) {
        return UserModel.fromFirestore(
            documentSnapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("User not found");
      }
    } catch (e) {
      throw Exception("Error to get User ${e.toString()}");
    }
  }

  @override
  Future<void> updateUserData(UserModel user) async {
    try {
      await firestore
          .collection("Users")
          .doc(user.uid)
          .update(user.toFirestore());
    } catch (e) {
      throw Exception("Error to update User ${e.toString()}");
    }
  }

  @override
  Future<String?> uploadUrlImage(File? imageFile, String Uid) async {
    try {
      if (imageFile == null)
        return null;
      else {
        return await storageService.uploadFile(
            file: imageFile, userID: Uid, folder: "ProfileImages");
      }
    } catch (e) {
      throw Exception("Failed to upload ${e.toString()}");
    }
  }

  //Profile Posts
  @override
  Stream<List<PostModel>> getOnlyMyPosts(String Uid) {
    try {
      return firestore
          .collection('Posts')
          .where("userID", isEqualTo: Uid)
          .orderBy('createdAT', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((post) => PostModel.fromFirestore(post.data()))
              .toList());
    } catch (e) {
      throw Exception("Error to get Post ${e.toString()}");
    }
  }
}
