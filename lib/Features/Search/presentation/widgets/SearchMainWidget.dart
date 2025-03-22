import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram2/Features/Search/presentation/widgets/ExploreMainScreen.dart';
import 'package:instagram2/Features/Search/presentation/widgets/SearchUserList.dart';

import '../manager/search_cubit.dart';

class SearchMainWidget extends StatefulWidget {
  const SearchMainWidget({super.key});

  @override
  State<SearchMainWidget> createState() => _SearchMainWidgetState();
}

class _SearchMainWidgetState extends State<SearchMainWidget> {
  String querry = "";
  @override
  void initState() {
    super.initState();
    BlocProvider.of<SearchCubit>(context).ExplorePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 10.h,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    hintStyle: TextStyle(color: Colors.grey),
                  ),
                  onChanged: (newquerry) {
                    setState(() {
                      querry = newquerry;
                    });
                    BlocProvider.of<SearchCubit>(context).search(newquerry);
                  },
                ),
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: querry.isEmpty
                        ? ExploreMainScreen()
                        : SearchUserList()))
          ],
        ));
  }
}
