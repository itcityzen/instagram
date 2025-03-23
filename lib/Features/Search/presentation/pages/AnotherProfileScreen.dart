import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram2/Features/Profile/presentation/widgets/ProfileView.dart';
import 'package:instagram2/Features/Search/presentation/manager/anothe_user_cubit.dart';
import 'package:instagram2/Features/Search/presentation/manager/search_cubit.dart';

class AnotherProfileScreen extends StatelessWidget {
  const AnotherProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 12.h,
      ),
      body: BlocBuilder<AnotherUserCubit, AnotherUserState>(
          builder: (context, state) {
        if (state is anotherUserLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is anotherUserSuccess) {
          return ProfileView(user: state.user);
        } else if (state is anotherUserError) {
          return Center(
            child: Text(state.ErrorMessage),
          );
        } else {
          return Center(
            child: Text("Something went wrong"),
          );
        }
      }),
    );
  }
}
