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
  Future<UserModel> getAnotherUserProfile(String uid) async {
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
}
