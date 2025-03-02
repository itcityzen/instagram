import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram2/Features/Login/presentation/manager/login_cubit.dart';
import 'package:instagram2/Features/Profile/presentation/manager/profile_cubit.dart';
import 'Core/DependcyInjection/DependcyInjection.dart';
import 'Features/Register/presentation/manager/register_cubit.dart';
import 'MyApp.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<RegisterCubit>()),
        BlocProvider(create: (context) => getIt<LoginCubit>()),
        BlocProvider(create: (context) => getIt<ProfileCubit>()..getUserData()),
      ],
      child: MyApp(),
    ),
  );
}
