import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram2/Features/MainScreen/presentation/manager/home_cubit.dart';

import '../../../Post/data/models/PostModel.dart';

class Homepostsview extends StatelessWidget {
  const Homepostsview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(builder: (context, state) {
      if (state is HomePostLoadedSuccess) {
        return GridView.builder(
          itemCount: state.posts.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, mainAxisSpacing: 3, crossAxisSpacing: 3),
          itemBuilder: (context, index) {
            PostModel posts = state.posts[index];
            return Image.network(
              posts.imageURL ?? "",
              fit: BoxFit.cover,
            );
          },
        );
      } else {
        return Center(child: Text("No Posts"));
      }
    });
  }
}
