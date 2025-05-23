import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram2/Core/DependcyInjection/DependcyInjection.dart';
import 'package:instagram2/Core/Firebase%20Services/FirebaseAuthenticationService.dart';
import 'package:instagram2/Core/Routes/ConstantRouter.dart';
import 'package:instagram2/Features/Profile/presentation/manager/profile_cubit.dart';
import 'package:instagram2/Features/Profile/presentation/widgets/chooseUpdatedImage.dart';

import '../../../../Core/Theme/theme_cubit.dart';
import '../../../../Core/Widgets/CustomFormTextField.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileCubit = context.read<ProfileCubit>();

    return Scaffold(
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
                icon: Icon(Icons.language)),
            BlocBuilder<ThemeCubit, ThemeState>(
              builder: (context, state) {
                if (state is ThemeisLight) {
                  return IconButton(
                      onPressed: () {
                        context.read<ThemeCubit>().ToggleTheme();
                      },
                      iconSize: 25,
                      icon: Icon(
                        Icons.sunny,
                        color: Colors.black,
                      ));
                }
                return IconButton(
                    onPressed: () {
                      context.read<ThemeCubit>().ToggleTheme();
                    },
                    iconSize: 25,
                    icon: Icon(
                      Icons.nightlight_rounded,
                      color: Colors.white,
                    ));
              },
            )
          ],
        ),
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
                hintText: 'Username'.tr(),
                labelText: 'Username'.tr(),
                controller: profileCubit.usernameController),
            SizedBox(
              height: 20.h,
            ),
            CustomFormTextField(
                prefixIcon: Icon(Icons.alternate_email, color: Colors.blue),
                hintText: 'Website'.tr(),
                labelText: 'Website'.tr(),
                controller: profileCubit.websiteController),
            SizedBox(
              height: 20.h,
            ),
            CustomFormTextField(
                prefixIcon: Icon(Icons.message, color: Colors.blue),
                hintText: 'Bio'.tr(),
                labelText: 'Bio'.tr(),
                controller: profileCubit.bioController),
            SizedBox(
              height: 20.h,
            ),
            CustomFormTextField(
                prefixIcon: Icon(Icons.phone, color: Colors.blue),
                hintText: 'Phone'.tr(),
                labelText: 'Phone'.tr(),
                controller: profileCubit.phoneController),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(120.w, 45.h),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                onPressed: () {
                  profileCubit.updateUserData();
                  Navigator.pop(context);
                },
                child: Text(
                  'Save'.tr(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                )),
            SizedBox(
              height: 20.h,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(120.w, 45.h),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                onPressed: () {
                  getIt<FirebaseAuthenticationService>().Logout();
                  context.go(ConstantRouter.registerScreen);
                },
                child: Text(
                  'Logout'.tr(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ))
          ],
        )));
  }
}
