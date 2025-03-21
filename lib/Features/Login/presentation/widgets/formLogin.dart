import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram2/Features/Login/presentation/manager/login_cubit.dart';

import '../../../../Core/Widgets/CustomFormTextField.dart';

class FormLogin extends StatelessWidget {
  const FormLogin({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LoginCubit>();
    return Form(
        key: cubit.formKey,
        child: Column(
          children: [
            CustomFormTextField(
                prefixIcon: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                hintText: 'email',
                labelText: 'Email',
                controller: cubit.EmailController),
            SizedBox(
              height: 30.h,
            ),
            CustomFormTextField(
                prefixIcon: Icon(Icons.lock, color: Colors.blue),
                hintText: 'password',
                labelText: 'Password',
                controller: cubit.PasswordController),
          ],
        ));
  }
}
