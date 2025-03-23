import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram2/Features/Post/presentation/widgets/AddDescriptionScreen.dart';
import 'package:instagram2/Features/Profile/presentation/pages/editScreen.dart';
import 'package:instagram2/Features/Search/presentation/pages/AnotherProfileScreen.dart';
import '../../Features/Login/presentation/pages/LoginScreen.dart';
import '../../Features/MainScreen/presentation/pages/MainScreen.dart';
import '../../Features/Post/data/models/PostModel.dart';
import '../../Features/Post/presentation/pages/AddScreen.dart';
import '../../Features/Profile/presentation/pages/SinglePhotoView.dart';
import '../../Features/Register/presentation/pages/RegisterScreen.dart';

class ConstantRouter {
  static const String splash = "/";
  static const String registerScreen = "/register";
  static const String loginScreen = "/login";
  static const String mainScreen = "/main";
  static const String editScreen = "/edit";
  static const String addScreen = "/addPost";
  static const String addDescriptionScreen = "/addDesriptionPost";
  static const String SinglePhotoView = "/singlePhotoView";
  static const String AnotherUserProfile = "/AnotherUserProfile";
}

class AppRouter {
  static final GoRouter router = GoRouter(
      initialLocation: FirebaseAuth.instance.currentUser != null
          ? ConstantRouter.mainScreen
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
        GoRoute(
            path: ConstantRouter.addDescriptionScreen,
            builder: (context, state) {
              return AddDescriptionScreen();
            }),
        GoRoute(
            path: ConstantRouter.SinglePhotoView,
            builder: (context, state) {
              PostModel postss = state.extra as PostModel;
              return Singlephotoview(posts: postss);
            }),
        GoRoute(
            path: ConstantRouter.AnotherUserProfile,
            builder: (context, state) {
              return AnotherProfileScreen();
            }),
      ]);
}
