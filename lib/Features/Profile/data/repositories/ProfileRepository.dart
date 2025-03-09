import 'dart:io';

import 'package:instagram2/Features/Register/data/models/UserModel.dart';

import '../../../Post/data/models/PostModel.dart';

abstract class ProfileRepository {
  Future<UserModel> getUserData(String uid);
  Future<void> updateUserData(UserModel user);
  Future<String?> uploadUrlImage(File imageFile, String Uid);

}
