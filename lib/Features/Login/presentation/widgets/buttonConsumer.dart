import 'dart:core';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram2/Features/Login/presentation/manager/login_cubit.dart';

import '../../../../Core/Routes/ConstantRouter.dart';
import '../../../../Core/Widgets/CustomButton.dart';

class LoginButtonconsumer extends StatelessWidget {
  const LoginButtonconsumer({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LoginCubit>();

    return BlocConsumer<LoginCubit, LoginState>(builder: (context, state) {
      if (state is LoginLoading) {
        return CircularProgressIndicator();
      }
      return CustomButton(
        onPressed: () {
          cubit.Login();
        },
        text: 'Login',
      );
    }, listener: (context, state) {
      if (state is LoginSuccess) {
        context.go(ConstantRouter.mainScreen);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Login Success Welcome ${state.user.email}')));
      }
      if (state is LoginError) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.ErrorMessage!)));
      }
    });
  }
}
