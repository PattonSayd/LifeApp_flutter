import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lifeapp/constants/assets.dart';
import 'package:lifeapp/constants/colors.dart';

Text defaultText(
  String text, {
  double? fontSize,
  double? height,
  FontWeight? fontWeight,
  Color? color,
  int? maxLines,
  TextOverflow? overflow,
  TextAlign? textAlign,
}) {
  return Text(
    text,
    style: TextStyle(
      fontSize: fontSize ?? 12.csp,
      fontWeight: fontWeight ?? FontWeight.w600,
      color: color ?? Colors.black,
      height: height,
      fontFamily: "EuclidCircularB",
    ),
    textAlign: textAlign,
    maxLines: maxLines,
    overflow: overflow,
  );
}

Padding rowText({
  required String text,
  String suffixText = '',
  EdgeInsetsGeometry? padding,
  bool isIcon = false,
  bool isPrimary = false,
  required VoidCallback onPressed,
}) {
  return Padding(
    padding: padding ?? EdgeInsets.symmetric(horizontal: 28.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        defaultText(
          text,
          fontWeight: FontWeight.w600,
          fontSize: 18.csp,
        ),
        if (suffixText != '')
          ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              primary: isPrimary
                  ? CustomColors.primary
                  : CustomColors.primary.withOpacity(0.06),
              padding: EdgeInsets.only(
                left: 16.w,
                right: 16.w,
                top: 10.ch,
                bottom: 10.ch,
              ),
            ),
            child: defaultText(
              suffixText,
              color: isPrimary ? Colors.white : CustomColors.primary,
              fontWeight: isPrimary ? FontWeight.w600 : FontWeight.w400,
              fontSize: isPrimary ? 14.csp : 16.csp,
            ),
          ),
        if (isIcon)
          SvgPicture.asset(
            Assets.closeEyeSvg,
            width: 24.w,
            height: 22.ch,
          )
      ],
    ),
  );
}

extension FontSize on num {
  double customFontSize(num fontSize) {
    if (fontSize / fontSize.sp >= 1.1) {
      return fontSize / 1.1;
    } else {
      return fontSize.sp;
    }
  }

  double customHeight(num height) {
    if (height / height.h >= 1.1) {
      return height / 1.1;
    } else {
      return height.h;
    }
  }

  double customWidth(num width) {
    if (width / width.h >= 1.1) {
      return width / 1.1;
    } else {
      return width.h;
    }
  }

  double get csp => customFontSize(this);
  double get ch => customHeight(this);
  double get cw => customWidth(this);
}
