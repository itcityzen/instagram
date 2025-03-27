import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../Core/DependcyInjection/DependcyInjection.dart';
import '../../../Search/presentation/manager/search_cubit.dart';
import '../../../Search/presentation/widgets/SearchMainWidget.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SearchCubit>(),
      child: SearchMainWidget(),
    );
  }
}
