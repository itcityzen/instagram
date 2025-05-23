import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram2/Core/Routes/ConstantRouter.dart';
import 'package:instagram2/Features/Login/presentation/widgets/formLogin.dart';

import '../../../Register/presentation/widgets/formRigister.dart';
import '../widgets/buttonConsumer.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        actions: [IconButton(onPressed: () {
          if (context.locale.languageCode == 'en') {
            context.setLocale(const Locale('ar'));
          } else {
            context.setLocale(const Locale('en'));
          }
        }, icon: Icon(Icons.language))],
        title: Text(''),
        toolbarHeight: 30,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/instag-removebg-preview.png',
                  height: 200.h,
                  width: 200.w,
                ),
              ),
              FormLogin(),
              SizedBox(
                height: 40.h,
              ),
              LoginButtonconsumer(),
              SizedBox(
                height: 15.h,
              ),
              TextButton(
                  onPressed: () {
                    context.go(ConstantRouter.registerScreen);
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.blue, fontSize: 14.sp),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
