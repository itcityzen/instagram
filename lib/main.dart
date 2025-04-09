import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram2/Core/SharedPreferences/CachHelper.dart';
import 'package:instagram2/Core/Theme/theme_cubit.dart';
import 'package:instagram2/Features/Chat/presentation/manager/rooms_cubit.dart';
import 'package:instagram2/Features/Login/presentation/manager/login_cubit.dart';
import 'package:instagram2/Features/MainScreen/presentation/manager/home_cubit.dart';
import 'package:instagram2/Features/Profile/presentation/manager/follow_cubit.dart';
import 'package:instagram2/Features/Profile/presentation/manager/profile_cubit.dart';
import 'package:instagram2/Features/Search/presentation/manager/anothe_user_cubit.dart';
import 'package:instagram2/Features/Search/presentation/manager/search_cubit.dart';
import 'Core/DependcyInjection/DependcyInjection.dart';
import 'Features/Post/presentation/manager/posts_cubit.dart';
import 'Features/Register/presentation/manager/register_cubit.dart';
import 'MyApp.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await SharedPreferencesHelper.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translation',
      fallbackLocale: Locale('en'),

      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => getIt<RegisterCubit>()),
          BlocProvider(create: (context) => getIt<LoginCubit>()),
          // .. then function = for piriority calling of getting data like home page and profile in loading data
          BlocProvider(
              create: (context) => getIt<ProfileCubit>()..getUserData()),
          BlocProvider(create: (context) => getIt<PostsCubit>()),
          BlocProvider(create: (context) => getIt<AnotherUserCubit>()),
          BlocProvider(create: (context) => getIt<ThemeCubit>()),
          BlocProvider(create: (context) => getIt<FollowCubit>()),
          BlocProvider(create: (context) => getIt<RoomsCubit>()),

        ],
        child: MyApp(),
      ),
    ),
  );
}
