import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';

import '../models/UserModel.dart';

abstract class RegisterRepository {
  Future<User?> SignUp(String Email, String Password);

  Future<String?> uploadUrlImage(File imageFile, String Uid);

  Future<void> saveUserToFirebase(UserModel user);
}
