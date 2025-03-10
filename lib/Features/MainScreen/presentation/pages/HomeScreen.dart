import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram2/Features/MainScreen/presentation/manager/home_cubit.dart';
import 'package:instagram2/Features/MainScreen/presentation/widgets/HomePostsView.dart';

import '../../../Profile/presentation/manager/profile_cubit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              )),
          SizedBox(
            width: 1.w,
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.send,
                size: 35,
              ))
        ],
      ),
      body: BlocConsumer<HomeCubit, HomeState>(listener: (context, state) {
        if (state is HomePostLoadedSuccess) {
          context.read<HomeCubit>().getAllHomePosts();
        }
      }, builder: (context, state) {
        if (state is HomePostLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is HomePostLoadedSuccess) {
          return Homepostsview();
        } else if (state is HomePostLoadedFailure) {
          return Center(child: Text(state.ErrorMessage));
        }
        return Center(child: Text('Fail to get Posts'));
      }),
    );
  }
}
