import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:instagram2/Core/Routes/ConstantRouter.dart';
import 'package:instagram2/Features/Search/presentation/manager/anothe_user_cubit.dart';
import 'package:instagram2/Features/Search/presentation/manager/search_cubit.dart';

class SearchUserList extends StatelessWidget {
  const SearchUserList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(builder: (context, state) {
      if (state is SearchLoading) {
        return Center(child: CircularProgressIndicator());
      } else if (state is SearchSuccess) {
        return ListView.builder(
            itemCount: state.users.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  context
                      .read<AnotherUserCubit>()
                      .getUserData(state.users[index].uid!);
                  context.push(ConstantRouter.AnotherUserProfile);
                },
                child: ListTile(
                    title: Text(state.users[index].username!),
                    subtitle: Text(state.users[index].email!),
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(state.users[index].profileUrl!),
                    )),
              );
            });
      }
      if (state is SearchError) {
        return Center(child: Text(state.ErrorMessage));
      }
      return Center(child: Text("Something went wrong"));
    });
  }
}
