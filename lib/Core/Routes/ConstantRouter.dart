import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram2/Features/Profile/presentation/pages/editScreen.dart';
import '../../Features/Login/presentation/pages/LoginScreen.dart';
import '../../Features/MainScreen/presentation/pages/MainScreen.dart';
import '../../Features/Post/presentation/pages/AddScreen.dart';
import '../../Features/Register/presentation/pages/RegisterScreen.dart';

class ConstantRouter {
  static const String splash = "/";
  static const String registerScreen = "/register";
  static const String loginScreen = "/login";
  static const String mainScreen = "/main";
  static const String editScreen = "/edit";
  static const String addScreen = "/addPost";
}

class AppRouter {
  static final GoRouter router = GoRouter(
      initialLocation: FirebaseAuth.instance.currentUser != null
          ? ConstantRouter.registerScreen
          : ConstantRouter.registerScreen,
      routes: [
        GoRoute(
            path: ConstantRouter.registerScreen,
            builder: (context, state) {
              return RegisterScreen();
            }),
        GoRoute(
            path: ConstantRouter.loginScreen,
            builder: (context, state) {
              return LoginScreen();
            }),
        GoRoute(
            path: ConstantRouter.mainScreen,
            builder: (context, state) {
              return MainScreen();
            }),
        GoRoute(
            path: ConstantRouter.editScreen,
            builder: (context, state) {
              return EditScreen();
            }),
        GoRoute(
            path: ConstantRouter.addScreen,
            builder: (context, state) {
              return AddScreen();
            }),
      ]);
}
