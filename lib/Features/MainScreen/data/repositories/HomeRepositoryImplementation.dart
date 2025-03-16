import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram2/Features/Register/data/models/UserModel.dart';

import '../../../../Core/Firebase Services/FirebaseStorageService.dart';
import 'HomeRepository.dart';

class HomeRepositoryImplementation implements HomeRepository {
  final FirebaseFirestore firestore;
  final FirebaseStorageService storageService;

  HomeRepositoryImplementation(this.firestore, this.storageService);

  @override
  Future<void> updateUserData(
      String postID, String username, String imageUrl) async {
    try {
      await firestore
          .collection("Posts")
          .doc(postID)
          .update({"username": username, "profileUrl": imageUrl});
    } catch (e) {
      throw Exception("Error to update User ${e.toString()}");
    }
  }
}
