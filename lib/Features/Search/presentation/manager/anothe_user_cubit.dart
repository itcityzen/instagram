import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram2/Features/Search/data/repositories/SearchRepository.dart';
import 'package:meta/meta.dart';

import '../../../../Core/DependcyInjection/DependcyInjection.dart';
import '../../../Register/data/models/UserModel.dart';

part 'anothe_user_state.dart';

class AnotherUserCubit extends Cubit<AnotherUserState> {
  SearchRepository searchRepository;
  AnotherUserCubit(this.searchRepository) : super(AnotherUserInitial());

  StreamSubscription<UserModel>? _subscription;
  void getUserData(String userID) async {
    emit(anotherUserLoading());
    // any user have one subscription , close old one and open a new subscription for a new user
    _subscription?.cancel();
    _subscription =
        searchRepository.getAnotherUserProfile(userID).listen((user) {
      emit(anotherUserSuccess(user));
    }, onError: (error) {
      emit(anotherUserError(error.toString()));
    });
  }

  var currentUserID = getIt<FirebaseAuth>().currentUser!.uid;
  void getFollow(String anotherUserID) async {
    try {
      await searchRepository.followUser(currentUserID, anotherUserID);
    } catch (e) {
      emit(anotherUserError(e.toString()));
    }
  }


  @override
  // to close the subscription of each user
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
