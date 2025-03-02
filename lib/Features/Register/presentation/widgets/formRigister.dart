import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/Widgets/CustomFormTextField.dart';
import '../manager/register_cubit.dart';

class Formrigister extends StatelessWidget {
  const Formrigister({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegisterCubit>();
    return Form(
        key: cubit.formKey,
        child: Column(
          children: [
            CustomFormTextField(
                prefixIcon: Icon(Icons.person,color: Colors.blue,),
                hintText: 'username',
                labelText: 'Username',
                controller: cubit.UsernameController),
            SizedBox(
              height: 20.h,
            ),
            CustomFormTextField(
                prefixIcon: Icon(Icons.email,color: Colors.blue),
                hintText: 'email',
                labelText: 'Email',
                controller: cubit.EmailController),
            SizedBox(
              height: 20.h,
            ),
            CustomFormTextField(
              prefixIcon: Icon(Icons.lock,color: Colors.blue),
                hintText: 'password',
                labelText: 'Password',
                controller: cubit.PasswordController),
            SizedBox(
              height: 20.h,
            ),
            CustomFormTextField(
              prefixIcon: Icon(Icons.phone,color: Colors.blue),
                hintText: 'phone',
                labelText: 'Phone',
                controller: cubit.PhoneController),
          ],
        ));
  }
}
