import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:instagram2/Features/Login/data/repositories/LoginRepository.dart';
import 'package:meta/meta.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginRepository loginRepository;

  LoginCubit(this.loginRepository) : super(LoginInitial());

  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Future<void> Login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(LoginLoading());
    try {
      var user = await loginRepository.Login(
          EmailController.text, PasswordController.text);
      if (user == null) {
        emit(LoginError('User Not Found'));
        return;
      }

      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginError(e.toString()));
    }
  }
}
