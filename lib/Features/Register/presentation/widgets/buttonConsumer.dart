import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../Core/Routes/ConstantRouter.dart';
import '../../../../Core/Widgets/CustomButton.dart';
import '../manager/register_cubit.dart';

class Buttonconsumer extends StatelessWidget {
  const Buttonconsumer({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<RegisterCubit>();

    return BlocConsumer<RegisterCubit, RegisterState>(
        builder: (context, state) {
      if (state is RegisterLoading) {
        return CircularProgressIndicator();
      }
      return CustomButton(
        onPressed: () {
          cubit.signUp();
        },
        text: 'Register'.tr(),
      );
    }, listener: (context, state) {
      if (state is RegisterSuccess) {
        context.go(ConstantRouter.loginScreen);
      }
      if (state is RegisterFailure) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.ErrorMessage)));
      }
    });
  }
}
