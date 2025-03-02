import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthenticationService {
  final FirebaseAuth firebaseauth;

  FirebaseAuthenticationService(this.firebaseauth);

  Future<User?> Registeration(String emailAddress, String password) async {
    try {
      final credential = await firebaseauth.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw Exception('Weak Password');
      } else if (e.code == 'email-already-in-use') {
        throw Exception('The account already exists for that email.');
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<User?> Login(String emailAddress, String password) async {
    try {
      final credential = await firebaseauth.signInWithEmailAndPassword(
          email: emailAddress, password: password);
      return credential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw Exception('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        throw Exception('Wrong password provided for that user.');
      }
    }
  }

  Future<void> Logout() async {
    try {
      await firebaseauth.signOut();
    } catch (e) {
      throw Exception('Error in Logout');
    }
  }
}
