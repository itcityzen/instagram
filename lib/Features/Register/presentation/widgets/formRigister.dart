import 'package:easy_localization/easy_localization.dart';
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
                hintText: 'Username'.tr(),
                labelText: 'Username'.tr(),
                controller: cubit.UsernameController),
            SizedBox(
              height: 20.h,
            ),
            CustomFormTextField(
                prefixIcon: Icon(Icons.email,color: Colors.blue),
                hintText: 'Email'.tr(),
                labelText: 'Email'.tr(),
                controller: cubit.EmailController),
            SizedBox(
              height: 20.h,
            ),
            CustomFormTextField(
              prefixIcon: Icon(Icons.lock,color: Colors.blue),
                hintText: 'Password'.tr(),
                labelText: 'Password'.tr(),
                controller: cubit.PasswordController),
            SizedBox(
              height: 20.h,
            ),
            CustomFormTextField(
              prefixIcon: Icon(Icons.phone,color: Colors.blue),
                hintText: 'Phone'.tr(),
                labelText: 'Phone'.tr(),
                controller: cubit.PhoneController),
          ],
        ));
  }
}
