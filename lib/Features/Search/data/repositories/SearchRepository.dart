import '../../../Register/data/models/UserModel.dart';

abstract class SearchRepository {
  Future<List<UserModel>> searchUsers(String query);
}
