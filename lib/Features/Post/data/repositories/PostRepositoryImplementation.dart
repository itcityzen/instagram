import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram2/Features/Post/data/models/PostModel.dart';

import '../../../../Core/Firebase Services/FirebaseStorageService.dart';
import 'PostRepository.dart';

class PostRepositoryImplementation implements PostRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorageService storageService;

  PostRepositoryImplementation(this.storageService, this.firestore);

  @override
  Future<void> createPost(PostModel post) async {
    try {
      await firestore
          .collection('Posts')
          .doc(post.postID)
          .set(post.toFirestore());

      DocumentReference documentReference =
          await firestore.collection("Users").doc(post.userID);
      await documentReference.update({
        "totalPosts": FieldValue.increment(1),
      });
    } catch (e) {
      throw Exception("Error to create Post ${e.toString()}");
    }
  }

  //Search
  @override
  Stream<List<PostModel>> getallRandomlyPosts(String Uid) {
    try {
      return firestore.collection("Posts").snapshots().map((snapshot) =>
          snapshot.docs
              .map((post) => PostModel.fromFirestore(post.data()))
              .where((post) => post.userID != Uid)
              .toList());
    } catch (e) {
      throw Exception("Error to get Post ${e.toString()}");
    }
  }

//create new post folder in firebase
  @override
  Future<String?> uploadUrlImage(File imageFile, String Uid) async {
    try {
      return await storageService.uploadFile(
          file: imageFile, userID: Uid, folder: "Posts");
    } catch (e) {
      throw Exception("Failed to upload ${e.toString()}");
    }
  }

//Home Posts
  @override
  Stream<List<PostModel>> getAllHomePosts() {
    return firestore
        .collection("Posts")
        .orderBy('createdAT', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((post) => PostModel.fromFirestore(post.data()))
            .toList());
  }
}
