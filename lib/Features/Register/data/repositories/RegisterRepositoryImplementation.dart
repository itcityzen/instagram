import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../../../../Core/Firebase Services/FirebaseAuthenticationService.dart';
import '../../../../Core/Firebase Services/FirebaseStorageService.dart';
import '../models/UserModel.dart';
import 'RegisterRepository.dart';

class RegisterREPImplementation implements RegisterRepository {
  final FirebaseAuthenticationService authService;
  final FirebaseFirestore firestore;
  final FirebaseStorageService storageService;

  RegisterREPImplementation(
      this.authService, this.firestore, this.storageService);

  @override
  Future<User?> SignUp(String Email, String Password) async {
    try {
      return await authService.Registeration(Email, Password);
    } catch (e) {
      throw Exception("SignUp Error ${e.toString()}");
    }
  }

  @override
  Future<void> saveUserToFirebase(UserModel user) async {
    try {
      return await firestore
          .collection("Users")
          .doc(user.uid)
          .set(user.toFirestore());
    } catch (e) {
      throw Exception("Error to save User ${e.toString()}");
    }
  }

  @override
  Future<String?> uploadUrlImage(File imageFile, String Uid) async {
    try {
      return await storageService.uploadFile(
          file: imageFile, userID: Uid, folder: "ProfileImages");
    } catch (e) {
      throw Exception("Failed to upload ${e.toString()}");
    }
  }
}
