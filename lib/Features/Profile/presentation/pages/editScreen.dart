import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram2/Features/Profile/presentation/manager/profile_cubit.dart';
import 'package:instagram2/Features/Profile/presentation/widgets/chooseUpdatedImage.dart';

import '../../../../Core/Widgets/CustomFormTextField.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();

    return Scaffold(
        body: Form(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChooseUpdatedImage(),
        SizedBox(
          height: 20.h,
        ),
        CustomFormTextField(
            prefixIcon: Icon(
              Icons.person,
              color: Colors.blue,
            ),
            hintText: 'username',
            labelText: 'Username',
            controller: profileCubit.usernameController),
        SizedBox(
          height: 20.h,
        ),
        CustomFormTextField(
            prefixIcon: Icon(Icons.alternate_email, color: Colors.blue),
            hintText: 'Website',
            labelText: 'Website',
            controller: profileCubit.websiteController),
        SizedBox(
          height: 20.h,
        ),
        CustomFormTextField(
            prefixIcon: Icon(Icons.message, color: Colors.blue),
            hintText: 'Bio',
            labelText: 'Bio',
            controller: profileCubit.bioController),
        SizedBox(
          height: 20.h,
        ),
        CustomFormTextField(
            prefixIcon: Icon(Icons.phone, color: Colors.blue),
            hintText: 'phone',
            labelText: 'Phone',
            controller: profileCubit.phoneController),
        SizedBox(
          height: 20.h,
        ),
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(120.w, 45.h),
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
            ),
            onPressed: () {
              profileCubit.updateUserData();
              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ))
      ],
    )));
  }
}
