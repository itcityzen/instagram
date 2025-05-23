import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomFormTextField extends StatelessWidget {
  final String hintText;
  final String labelText;
  final bool isObscureText;
  final Widget? prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const CustomFormTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    required this.labelText,
    required this.controller,
    this.isObscureText = false,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: TextFormField(
          controller: controller,
          obscureText: isObscureText,
          validator: validator,
          decoration: InputDecoration(
            labelText: labelText,
            labelStyle: TextStyle(fontSize: 16.sp, color: Colors.black),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.r),
              borderSide: BorderSide(color: Colors.black54, width: 2.w),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5.r),
                borderSide: BorderSide(color: Colors.black, width: 2.w)),
            prefixIcon: prefixIcon,
            filled: true,
            fillColor: Colors.white10,
            contentPadding: EdgeInsets.symmetric(
              vertical: 20.h,
              horizontal: 16.w,
            ),
          ),
          style: TextStyle(fontSize: 12.sp),
        ),
      ),
    );
  }
}
