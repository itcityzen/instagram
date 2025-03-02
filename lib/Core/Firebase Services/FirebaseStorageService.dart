import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  final FirebaseStorage firebaseStorage;

  FirebaseStorageService(this.firebaseStorage);

  Future<String?> uploadFile(
      {required File file,
      required String userID,
      required String folder}) async {
    try {
      String extensionImage =
          file.path.contains('.') ? file.path.split('.').last : "jpg";

      final String ImagePath = '$folder/$userID/$extensionImage';

      final reference = firebaseStorage.ref().child(ImagePath);

      UploadTask uploadTask = reference.putFile(file);

      TaskSnapshot snapshot = await uploadTask;

      if (snapshot.state == TaskState.success) {
        return await reference.getDownloadURL();
      } else {
        throw Exception("Failed to upload , Try again");
      }
    } catch (e) {
      throw Exception("Failed to upload : $e");
    }
  }
}
