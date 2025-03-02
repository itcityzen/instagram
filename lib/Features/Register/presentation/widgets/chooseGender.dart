import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:instagram2/Features/Register/presentation/manager/register_cubit.dart';

class ChooseGender extends StatelessWidget {
  const ChooseGender({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<RegisterCubit>();
    return (BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return Container(
            height: 40.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.r), color: Colors.white),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: DropdownButtonFormField(
                  decoration: InputDecoration(
                      labelText: 'Select Gender',
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.w),
                          borderRadius: BorderRadius.circular(5.r)),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 2.w),
                          borderRadius: BorderRadius.circular(5.r))),
                  items: [
                    DropdownMenuItem(value: "Male", child: Text('Male')),
                    DropdownMenuItem(value: "Female", child: Text('Female'))
                  ],
                  onChanged: (value) {
                    cubit.setGender(value);
                  }),
            ));
      },
    ));
  }
}
