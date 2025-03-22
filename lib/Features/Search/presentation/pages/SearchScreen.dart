import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:instagram2/Core/DependcyInjection/DependcyInjection.dart';
import 'package:instagram2/Features/Search/presentation/manager/search_cubit.dart';
import 'package:instagram2/Features/Search/presentation/widgets/ExploreMainScreen.dart';
import 'package:instagram2/Features/Search/presentation/widgets/SearchMainWidget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchCubit>(),
      child: SearchMainWidget(),
    );
  }
}
