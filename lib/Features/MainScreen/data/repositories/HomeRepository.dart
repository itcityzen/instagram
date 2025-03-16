import '../../../Register/data/models/UserModel.dart';

abstract class HomeRepository {
  Future<void> updateUserData(String postID, String username, String imageUrl);
}
