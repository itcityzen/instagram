import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import '../../data/models/UserModel.dart';
import '../../data/repositories/RegisterRepository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterRepository registerRepository;

  RegisterCubit(this.registerRepository) : super(RegisterInitial());

  final TextEditingController UsernameController = TextEditingController();
  final TextEditingController EmailController = TextEditingController();
  final TextEditingController PasswordController = TextEditingController();
  final TextEditingController PhoneController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? selectedGender;
  File? profileImage;

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) {
      emit(RegisterFailure('Please Fill all Required field First'));
    }
    emit(RegisterLoading());
    try {
      final User = await registerRepository.SignUp(
          EmailController.text, PasswordController.text);
      if (User == null) {
        emit(RegisterFailure('Fail to Register'));
        return;
      }

      String? imageURL;
      if (profileImage != null) {
        imageURL =
            await registerRepository.uploadUrlImage(profileImage!, User.uid);
      }

      final newUser = UserModel(
        uid: User.uid,
        username: UsernameController.text.trim(),
        email: EmailController.text.trim(),
        profileUrl: imageURL ?? "",
        bio: "",
        phone: PhoneController.text.trim(),
        gender: selectedGender,
        followers: [],
        following: [],
        totalFollowers: 0,
        totalFollowing: 0,
        totalPosts: 0,
        isOnline: true,
        token: "",
      );

      await registerRepository.saveUserToFirebase(newUser);

      emit(RegisterSuccess(User, ''));
    } catch (e) {
      emit(RegisterFailure("Failed Process ${e.toString()}"));
    }
  }

  void setGender(String? Gender) {
    selectedGender = Gender ?? "Male";
    emit(GenederSelected(selectedGender!));
  }

  void setImage(File imageFile) {
    profileImage = imageFile;
    emit(ProfileImageSelected(imageFile));
  }

  @override
  Future<void> close() {
    UsernameController.dispose();
    EmailController.dispose();
    PasswordController.dispose();
    PhoneController.dispose();
    return super.close();
  }
}
