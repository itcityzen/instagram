import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram2/Features/Post/data/models/PostModel.dart';

import '../../../../Core/Firebase Services/FirebaseStorageService.dart';
import 'HomeRepository.dart';

class HomeRepositoryImplementation implements HomeRepository {
  final FirebaseFirestore firestore;

  HomeRepositoryImplementation(this.firestore);

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
