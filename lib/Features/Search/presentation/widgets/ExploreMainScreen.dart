import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram2/Features/Search/presentation/manager/search_cubit.dart';
import 'package:instagram2/Features/Search/presentation/widgets/SearchMainWidget.dart';

class ExploreMainScreen extends StatelessWidget {
  const ExploreMainScreen({super.key});

  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      if (state is ExploreLoading) {
        return Center(child: CircularProgressIndicator());
      }
      if (state is ExploreError) {
        return Center(child: Text(state.ErrorMessage));
      } else if (state is ExploreSuccess) {
        return MasonryGridView.builder(
            gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemCount: state.posts.length,
            itemBuilder: (context, index) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  state.posts[index].imageURL!,
                  height: (index % 5 + 1) * 100,
                  fit: BoxFit.cover,
                ),
              );
            });
      }
      return Center(child: Text("No posts found"));
    });
  }
}
