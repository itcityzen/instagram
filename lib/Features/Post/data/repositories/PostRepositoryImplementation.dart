import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:instagram2/Features/Post/data/models/CommentModel.dart';
import 'package:instagram2/Features/Post/data/models/PostModel.dart';

import '../../../../Core/Firebase Services/FirebaseStorageService.dart';
import 'PostRepository.dart';

class PostRepositoryImplementation implements PostRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorageService storageService;
  PostRepositoryImplementation(this.storageService, this.firestore);

  //create new post
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

  //Profile Posts
  @override
  Stream<List<PostModel>> getOnlyMyPosts(String UserID) {
    final postCollection =
        firestore.collection("Posts").orderBy("createdAT", descending: true);
    return postCollection.snapshots().map((snapshot) => snapshot.docs
        .map((post) => PostModel.fromFirestore(post.data()))
        .where((post) => post.userID == UserID)
        .toList());
  }

//Home Posts
  @override
  Stream<List<PostModel>> getAllHomePosts() {
    final postCollection =
        firestore.collection("Posts").orderBy("createdAT", descending: true);
    return postCollection.snapshots().map((snapshot) => snapshot.docs
        .map((post) => PostModel.fromFirestore(post.data()))
        .toList());
  }

  @override
  Future likePost(String postID, String userID, bool isliked) async {
    try {
      // id post
      DocumentReference documentReference =
          firestore.collection("Posts").doc(postID);

      if (isliked) {
        await documentReference.update({
          "Likes": FieldValue.arrayUnion([userID]),
          "totalLikes": FieldValue.increment(1),
        });
      } else {
        await documentReference.update({
          "Likes": FieldValue.arrayRemove([userID]),
          "totalLikes": FieldValue.increment(-1),
        });
      }
    } catch (e) {
      throw Exception("Error to like Post ${e.toString()}");
    }
  }

  @override
  Future createComment(CommentModel comment) async {
    await firestore
        .collection("Posts")
        .doc(comment.postId)
        .collection("comments")
        .doc(comment.commentId)
        .set(comment.toFirestore());
    DocumentReference documentReference =
        firestore.collection("Posts").doc(comment.postId);
    await documentReference.update({
      "totalComments": FieldValue.increment(1),
      "Comments": FieldValue.arrayUnion([comment.commentId])
    });
  }

  Stream<List<CommentModel>> getComments(String postId) {
    final commentCollection = firestore
        .collection("Posts")
        .doc(postId)
        .collection("comments")
        .orderBy("createdAt", descending: true);
    return commentCollection.snapshots().map((querySnapshot) => querySnapshot
        .docs
        .map((comment) => CommentModel.fromFirestore(comment.data()))
        .toList());
  }

  @override
  Future<void> deletePost(PostModel post) async {
    try {
      await firestore.collection("Posts").doc(post.postID).delete();
      DocumentReference documentReference =
          await firestore.collection("Users").doc(post.userID);
      await documentReference.update({
        "totalPosts": FieldValue.increment(-1),
      });
    } catch (e) {
      throw Exception("Error to delete Post ${e.toString()}");
    }
  }
}
