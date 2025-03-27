import '../../../Register/data/models/UserModel.dart';

abstract class SearchRepository {
  Future<List<UserModel>> searchUsers(String query);
  Stream<UserModel> getAnotherUserProfile(String uid);
  Future<void> followUser(String currentUserID, String anotherUserID);
}
