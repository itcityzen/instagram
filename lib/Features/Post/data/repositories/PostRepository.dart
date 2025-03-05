import 'dart:async';
import 'dart:io';

import 'package:instagram2/Features/Post/data/models/PostModel.dart';

abstract class PostRepository {
  Future<String?> uploadUrlImage(File imageFile, String Uid);
  Future<void> createPost(PostModel post);
  Stream<List<PostModel>> getallRandomlyPosts(String Uid);
  Stream<List<PostModel>> getAllHomePosts();
}
