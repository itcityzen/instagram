import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:instagram2/Core/DependcyInjection/DependcyInjection.dart';
import 'package:instagram2/Features/Post/data/models/PostModel.dart';
import 'package:instagram2/Features/Post/data/repositories/PostRepository.dart';
import 'package:instagram2/Features/Search/data/repositories/SearchRepository.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import '../../../Register/data/models/UserModel.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  PostRepository postRepository;
  SearchRepository searchRepository;
  final _queryController = BehaviorSubject<String>();

  SearchCubit(this.postRepository, this.searchRepository)
      : super(SearchInitial()) {
    _queryController
        .debounceTime(const Duration(milliseconds: 500))
        .distinct()
        .listen(_handleSearchQuery);
  }

  void ExplorePosts() {
    emit(ExploreLoading());
    var currentID = getIt<FirebaseAuth>().currentUser!.uid;
    postRepository.getallRandomlyPosts(currentID).listen((Posts) {
      emit(ExploreSuccess(Posts));
      print("Explore is Done");
    }, onError: (error) {
      emit(ExploreError(error.toString()));
    });
  }

  void search(String query) {
    _queryController.add(query); // Add query to the stream
  }

  Future<void> _handleSearchQuery(String query) async {
    final trimmedQuery = query.trim();
    if (trimmedQuery.isEmpty) {
      emit(SearchInitial());
      return;
    }

    emit(SearchLoading());
    try {
      // Call the search function from your SearchRepo (Firebase)
      final users = await searchRepository.searchUsers(trimmedQuery);
      emit(SearchSuccess(users));
    } catch (e) {
      emit(SearchError('Error: ${e.toString()}'));
    }
  }

  @override
  Future<void> close() {
    _queryController.close();
    return super.close();
  }
}
