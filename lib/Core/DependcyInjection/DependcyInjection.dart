import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram2/Core/Theme/theme_cubit.dart';
import 'package:instagram2/Features/Chat/data/repositories/ChatRepository.dart';
import 'package:instagram2/Features/Chat/data/repositories/ChatRepositoryImplementation.dart';
import 'package:instagram2/Features/Chat/presentation/manager/messages_cubit.dart';
import 'package:instagram2/Features/Chat/presentation/manager/rooms_cubit.dart';
import 'package:instagram2/Features/Login/data/repositories/LoginRepository.dart';
import 'package:instagram2/Features/Login/data/repositories/LoginRepositoryImplementation.dart';
import 'package:instagram2/Features/Login/presentation/manager/login_cubit.dart';
import 'package:instagram2/Features/MainScreen/data/repositories/HomeRepository.dart';
import 'package:instagram2/Features/MainScreen/data/repositories/HomeRepositoryImplementation.dart';
import 'package:instagram2/Features/Post/data/repositories/PostRepository.dart';
import 'package:instagram2/Features/Post/data/repositories/PostRepositoryImplementation.dart';
import 'package:instagram2/Features/Post/presentation/manager/comment_cubit.dart';
import 'package:instagram2/Features/Post/presentation/manager/posts_cubit.dart';
import 'package:instagram2/Features/Profile/presentation/manager/follow_cubit.dart';
import 'package:instagram2/Features/Search/data/repositories/SearchRepository.dart';
import 'package:instagram2/Features/Search/data/repositories/SearchRepositoryImplementation.dart';
import 'package:instagram2/Features/Search/presentation/manager/anothe_user_cubit.dart';
import 'package:instagram2/Features/Search/presentation/manager/search_cubit.dart';

import '../../Features/MainScreen/presentation/manager/home_cubit.dart';
import '../../Features/Profile/data/repositories/ProfileRepository.dart';
import '../../Features/Profile/data/repositories/ProfileRepositoryImplementation.dart';
import '../../Features/Profile/presentation/manager/profile_cubit.dart';
import '../../Features/Register/data/repositories/RegisterRepository.dart';
import '../../Features/Register/data/repositories/RegisterRepositoryImplementation.dart';
import '../../Features/Register/presentation/manager/register_cubit.dart';
import '../Firebase Services/FirebaseAuthenticationService.dart';
import '../Firebase Services/FirebaseStorageService.dart';

final getIt = GetIt.instance;
void setup() {
  // Register Firebase Instances
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);

  // Register Services

  getIt.registerLazySingleton<FirebaseAuthenticationService>(
      () => FirebaseAuthenticationService(getIt<FirebaseAuth>()));

  getIt.registerLazySingleton<FirebaseStorageService>(
      () => FirebaseStorageService(getIt<FirebaseStorage>()));

  // Register Repository

  getIt.registerLazySingleton<RegisterRepository>(() =>
      RegisterREPImplementation(getIt<FirebaseAuthenticationService>(),
          getIt<FirebaseFirestore>(), getIt<FirebaseStorageService>()));
// Register Cubit
  getIt.registerLazySingleton<RegisterCubit>(
      () => RegisterCubit(getIt<RegisterRepository>()));

  // Login Repository

  getIt.registerLazySingleton<LoginRepository>(() =>
      LoginRepositoryImplementation(getIt<FirebaseAuthenticationService>()));
  // Login Cubit
  getIt.registerLazySingleton<LoginCubit>(
      () => LoginCubit(getIt<LoginRepository>()));

  // Profile Repository
  getIt.registerLazySingleton<ProfileRepository>(() =>
      ProfileRepositoryImplementation(
          getIt<FirebaseFirestore>(), getIt<FirebaseStorageService>()));

  // Profile Cubit
  getIt.registerLazySingleton<ProfileCubit>(
      () => ProfileCubit(getIt<ProfileRepository>(), getIt<HomeRepository>()));

  // Post Repository
  getIt.registerLazySingleton<PostRepository>(() =>
      PostRepositoryImplementation(
          getIt<FirebaseStorageService>(), getIt<FirebaseFirestore>()));

  // Post Cubit
  getIt.registerLazySingleton<PostsCubit>(
      () => PostsCubit(getIt<PostRepository>()));

  // Home Repository
  getIt.registerLazySingleton<HomeRepository>(() =>
      HomeRepositoryImplementation(
          getIt<FirebaseFirestore>(), getIt<FirebaseStorageService>()));

  // Home Cubit
  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<PostRepository>()));

  //Comment Cubit
  getIt.registerFactory<CommentCubit>(
      () => CommentCubit(getIt<PostRepository>()));

  // Search Repository
  getIt.registerLazySingleton<SearchRepository>(
      () => SearchRepositoryImplementation(getIt<FirebaseFirestore>()));

  //Search Cubit
  getIt.registerFactory<SearchCubit>(
      () => SearchCubit(getIt<PostRepository>(), getIt<SearchRepository>()));

  //AnotherUser Cubit
  getIt.registerFactory<AnotherUserCubit>(
      () => AnotherUserCubit(getIt<SearchRepository>()));
  //Theme Cubit
  getIt.registerFactory<ThemeCubit>(() => ThemeCubit());

  //Follow Cubit
  getIt.registerFactory<FollowCubit>(
      () => FollowCubit(getIt<ProfileRepository>()));

  // Rooms Repository
  getIt.registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImplementation(getIt<FirebaseFirestore>()));

  //Rooms Cubit
  getIt.registerFactory<RoomsCubit>(() => RoomsCubit(getIt<ChatRepository>()));

  //Messages Cubit
  getIt.registerFactory<MessagesCubit>(
      () => MessagesCubit(getIt<ChatRepository>()));
}
