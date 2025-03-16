import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:instagram2/Features/Post/data/repositories/PostRepository.dart';
import 'package:meta/meta.dart';

import '../../../Post/data/models/PostModel.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  PostRepository postRepository;
  HomeCubit(this.postRepository) : super(HomeInitial());

  void getAllHomePosts() async {
    try {
      emit(HomePostLoading());
      postRepository.getAllHomePosts().listen((posts) {
        emit(HomePostLoadedSuccess(posts));
      }, onError: (error) {
        emit(HomePostLoadedFailure(error.toString()));
      });
    } catch (e) {
      emit(HomePostLoadedFailure("Error to get Post ${e.toString()}"));
    }
  }
}
