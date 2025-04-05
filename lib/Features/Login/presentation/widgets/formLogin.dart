import 'package:easy_localization/easy_localization.dart';
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
                hintText: 'Email'.tr(),
                labelText: 'Email'.tr(),
                controller: cubit.EmailController),
            SizedBox(
              height: 30.h,
            ),
            CustomFormTextField(
                prefixIcon: Icon(Icons.lock, color: Colors.blue),
                hintText: 'Password'.tr(),
                labelText: 'Password'.tr(),
                controller: cubit.PasswordController),
          ],
        ));
  }
}
