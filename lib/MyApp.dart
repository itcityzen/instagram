import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'Core/Routes/ConstantRouter.dart';
import 'Core/Theme/theme_cubit.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        minTextAdapt: true,
        builder: (context, child) {
          return BlocBuilder<ThemeCubit, ThemeState>(builder: (context, state) {
            return MaterialApp.router(
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,

              theme:
                  state is ThemeisDark ? ThemeData.dark() : ThemeData.light(),
              routerConfig: AppRouter.router,
              debugShowCheckedModeBanner: false,
            );
          });
        });
  }
}
