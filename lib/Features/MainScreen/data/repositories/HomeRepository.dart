import '../../../Post/data/models/PostModel.dart';

abstract class HomeRepository {
  Stream<List<PostModel>> getAllHomePosts();
}
