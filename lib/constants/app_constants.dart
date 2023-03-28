import 'package:flutter/material.dart';
import 'package:lifeapp/constants/colors.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppConstants {
  // static final lightGreyDecoration = BoxDecoration(
  // color: CustomColors.lightGrey,
  // borderRadius: BorderRadius.circular(5.r),
  // );

  static BoxDecoration defaultDecoration({
    double? borderRadius,
    Color? color,
  }) {
    return BoxDecoration(
      color: color ?? CustomColors.lightGrey,
      borderRadius: BorderRadius.circular(borderRadius ?? 8.r),
    );
  }


}



