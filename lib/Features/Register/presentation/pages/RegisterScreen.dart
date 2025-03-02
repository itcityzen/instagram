import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram2/Core/Routes/ConstantRouter.dart';
import 'package:instagram2/Features/Register/presentation/widgets/chooseGender.dart';
import 'package:instagram2/Features/Register/presentation/widgets/chooseImage.dart';

import '../widgets/buttonConsumer.dart';
import '../widgets/formRigister.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(''),
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/instag-removebg-preview.png',
                  height: 200.h,
                  width: 200.w,
                ),
              ),
              ChooseImage(),
              SizedBox(
                height: 20.h,
              ),
              Formrigister(),
              SizedBox(
                height: 20.h,
              ),
              ChooseGender(),
              SizedBox(
                height: 20.h,
              ),
              Buttonconsumer(),
              SizedBox(
                height: 15.h,
              ),
              TextButton(
                  onPressed: () {
                    context.go(ConstantRouter.loginScreen);
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.blue, fontSize: 14.sp),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
