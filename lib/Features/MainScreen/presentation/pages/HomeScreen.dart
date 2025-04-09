import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram2/Core/DependcyInjection/DependcyInjection.dart';
import 'package:instagram2/Core/Routes/ConstantRouter.dart';
import 'package:instagram2/Features/Chat/presentation/manager/rooms_cubit.dart';
import 'package:instagram2/Features/MainScreen/presentation/manager/home_cubit.dart';
import 'package:instagram2/Features/MainScreen/presentation/widgets/HomePostsView.dart';
import 'package:instagram2/Features/Post/data/models/PostModel.dart';

import '../../../Profile/presentation/manager/profile_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          centerTitle: false,
          title: SizedBox(
            height: 40.h,
            width: 105.w,
            child: Image.asset(
              'assets/instag-removebg-preview.png',
              fit: BoxFit.fitHeight,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.favorite_border,
                  size: 35,
                  color: Colors.black,
                )),
            SizedBox(
              width: 1.w,
            ),
            IconButton(
                onPressed: () {
                  context.push(ConstantRouter.RoomsScreen);
                },
                icon: Icon(Icons.send, size: 35, color: Colors.black))
          ],
        ),
        body: BlocProvider(
          create: (context) => getIt<HomeCubit>()..getAllHomePosts(),
          child: BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
            if (state is HomePostLoadedFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.ErrorMessage}')),
              );
            }
          }, builder: (context, state) {
            if (state is HomePostLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is HomePostLoadedSuccess) {
              return ListView.builder(
                  itemCount: state.posts.length,
                  itemBuilder: (context, index) {
                    PostModel posts = state.posts[index];
                    return Homepostsview(posts: posts);
                  });
            } else {
              return Center(child: Text('Fail to get Posts'));
            }
          }),
        ),
      ),
    );
  }
}
