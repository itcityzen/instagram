import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:instagram2/Features/Login/data/repositories/LoginRepository.dart';
import 'package:instagram2/Features/Login/data/repositories/LoginRepositoryImplementation.dart';
import 'package:instagram2/Features/Login/presentation/manager/login_cubit.dart';

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
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

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
      () => ProfileCubit(getIt<ProfileRepository>()));
}
