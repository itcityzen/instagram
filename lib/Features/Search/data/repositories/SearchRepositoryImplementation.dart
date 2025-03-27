import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram2/Features/Register/data/models/UserModel.dart';
import 'package:instagram2/Features/Search/data/repositories/SearchRepository.dart';

class SearchRepositoryImplementation implements SearchRepository {
  FirebaseFirestore firestore;
  SearchRepositoryImplementation(this.firestore);

  @override
  Future<List<UserModel>> searchUsers(String query) async {
    try {
      // Adjust query range for case-insensitive search in firestore/ uf8ff= capital letters and small
      final querySnapshotUsername = await firestore
          .collection('Users')
          .where('username', isGreaterThanOrEqualTo: query)
          .where('username', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      // Same adjustment for email
      final querySnapshotEmail = await firestore
          .collection('Users')
          .where('email', isGreaterThanOrEqualTo: query)
          .where('email', isLessThanOrEqualTo: query + '\uf8ff')
          .get();

      final List<UserModel> users = [];

      // Map the username results
      querySnapshotUsername.docs.forEach((doc) {
        users.add(UserModel.fromFirestore(doc.data() as Map<String, dynamic>));
      });

      // Map the email results
      querySnapshotEmail.docs.forEach((doc) {
        users.add(UserModel.fromFirestore(doc.data() as Map<String, dynamic>));
      });

      // Remove duplicates (if any user appears in both username and email results)
      final uniqueUsers = users.toSet().toList();

      if (uniqueUsers.isEmpty) {
        throw Exception("No users found");
      }

      return uniqueUsers;
    } catch (e) {
      throw Exception("Error fetching users: $e");
    }
  }

  @override
  // input useriD to firestore Users Collection then get data and convert into usermodel
  Stream<UserModel> getAnotherUserProfile(String uid) {
    return firestore.collection("Users").doc(uid).snapshots().map((snapshot) {
      if (snapshot.exists && snapshot.data() != null) {
        return UserModel.fromFirestore(snapshot.data() as Map<String, dynamic>);
      } else {
        throw Exception("User not found");
      }
    });
  }

  @override
  Future<void> followUser(String currentUserID, String anotherUserID) async {
    try {
      //getting documentation of current user < then get the list of it's following
      DocumentSnapshot currentUserDoc =
          await firestore.collection("Users").doc(currentUserID).get();
      List<dynamic> following =
          (currentUserDoc.data() as Map<String, dynamic>)["following"] ?? [];
      // if the following list don't contain the anotherUserID add < if it's contain remove when pressed
      if (!following.contains(anotherUserID)) {
        await firestore.collection("Users").doc(currentUserID).update({
          "following": FieldValue.arrayUnion([anotherUserID]),
          "totalFollowing": FieldValue.increment(1),
        });
        await firestore.collection("Users").doc(anotherUserID).update({
          "followers": FieldValue.arrayUnion([currentUserID]),
          "totalFollowers": FieldValue.increment(1),
        });
      } else {
        await firestore.collection("Users").doc(currentUserID).update({
          "following": FieldValue.arrayRemove([anotherUserID]),
          "totalFollowing": FieldValue.increment(-1),
        });
        await firestore.collection("Users").doc(anotherUserID).update({
          "followers": FieldValue.arrayRemove([currentUserID]),
          "totalFollowers": FieldValue.increment(-1),
        });
      }
    } catch (e) {
      throw Exception("Error to follow the User ${e.toString()}");
    }
  }
}
