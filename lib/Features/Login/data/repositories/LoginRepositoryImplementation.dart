import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram2/Features/Login/data/repositories/LoginRepository.dart';

import '../../../../Core/Firebase Services/FirebaseAuthenticationService.dart';

class LoginRepositoryImplementation implements LoginRepository {
  final FirebaseAuthenticationService authService;

  LoginRepositoryImplementation(this.authService);

  @override
  Future<User?> Login(String emailAddress, String password) async {
    try {
      return await authService.Login(emailAddress, password);
    } catch (e) {
      throw Exception("Login Error ${e.toString()}");
    }

    ;
  }
}
