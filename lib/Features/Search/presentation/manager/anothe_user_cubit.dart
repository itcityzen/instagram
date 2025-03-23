import 'package:bloc/bloc.dart';
import 'package:instagram2/Features/Search/data/repositories/SearchRepository.dart';
import 'package:meta/meta.dart';

import '../../../Register/data/models/UserModel.dart';

part 'anothe_user_state.dart';

class AnotherUserCubit extends Cubit<AnotherUserState> {
  SearchRepository searchRepository ;
  AnotherUserCubit(this.searchRepository) : super(AnotherUserInitial());



  void getUserData(String userID) async {
    emit(anotherUserLoading());
    try {
      final user = await searchRepository.getAnotherUserProfile(userID);
      emit(anotherUserSuccess(user));
    } catch (e) {
      emit(anotherUserError(e.toString()));
    }
  }

}
