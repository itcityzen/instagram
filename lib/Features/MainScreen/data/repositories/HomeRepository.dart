import '../../../Register/data/models/UserModel.dart';

abstract class HomeRepository {
  Future<void> updateUserPost(String UserID, String username, String imageUrl);
}
