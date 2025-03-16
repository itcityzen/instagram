import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

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

      final String ImagePath = '$folder/${Uuid().v1()}/$extensionImage';

      final reference = firebaseStorage.ref().child(ImagePath);

      UploadTask uploadTask = reference.putFile(file);

      var snapshot = await uploadTask;

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
