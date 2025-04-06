import 'package:easy_localization/easy_localization.dart';
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
        actions: [
          IconButton(
              onPressed: () {
                if (context.locale.languageCode == 'en') {
                  context.setLocale(const Locale('ar'));
                } else {
                  context.setLocale(const Locale('en'));
                }
              },
              icon: Icon(Icons.language))
        ],
        title: Text(''),
        toolbarHeight: 30,
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
                height: 1.h,
              ),
              TextButton(
                  onPressed: () {
                    context.go(ConstantRouter.loginScreen);
                  },
                  child: Text(
                    'Login'.tr(),
                    style: TextStyle(color: Colors.blue, fontSize: 14.sp),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
