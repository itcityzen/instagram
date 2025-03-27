import 'package:bloc/bloc.dart';
import 'package:instagram2/Features/Profile/data/repositories/ProfileRepository.dart';
import 'package:instagram2/Features/Register/data/models/UserModel.dart';
import 'package:meta/meta.dart';

part 'follow_state.dart';

class FollowCubit extends Cubit<FollowState> {
  ProfileRepository profileRepository;

  FollowCubit(this.profileRepository) : super(FollowInitial());

  followersandfollowings(List<String> allUsersIDs) async {
    emit(FollowLoading());
    try {
      final users =
          await profileRepository.getFollowersAndFollowings(allUsersIDs);
      emit(FollowSuccess(users));
    } catch (e) {
      emit(FollowError(e.toString()));
    }
  }
}
