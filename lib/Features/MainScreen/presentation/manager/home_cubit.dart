import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:instagram2/Features/MainScreen/data/repositories/HomeRepository.dart';
import 'package:meta/meta.dart';

import '../../../Post/data/models/PostModel.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeRepository homeRepository;
  HomeCubit(this.homeRepository) : super(HomeInitial());

  Future<void> getAllHomePosts() async {
    StreamSubscription<List<PostModel>>? postSubscription;
    try {
      emit(HomePostLoading());
      postSubscription = homeRepository.getAllHomePosts().listen((posts) {
        emit(HomePostLoadedSuccess(posts));
      }, onError: (error) {
        emit(HomePostLoadedFailure(error.toString()));
      });
    } catch (e) {
      emit(HomePostLoadedFailure("Error to get Post ${e.toString()}"));
    }
  }
}
