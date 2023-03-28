import 'dart:io';
import 'package:flutter/material.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  CustomButton({
    Key? key,
    required this.onPressed,
    required this.text,
    this.height,
    this.width,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.backgroundColor,
    this.padding,
    this.loading,
    this.outlineColor,
  }) : super(key: key);

  final VoidCallback onPressed;
  final double? height;
  final double? width;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final Color? outlineColor;
  final String text;
  bool? loading;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 56.ch,
      width: width,
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
              padding ?? EdgeInsets.symmetric(horizontal: 10)),
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all<Color>(
              backgroundColor ?? CustomColors.primary),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          splashFactory:
              Platform.isIOS ? NoSplash.splashFactory : InkSplash.splashFactory,
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(
                color:
                    outlineColor != null ? outlineColor! : CustomColors.primary,
              ),
            ),
          ),
        ),
        onPressed: onPressed,
        child: loading != null && loading == true
            ? CircularProgressIndicator.adaptive(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                text,
                style: TextStyle(
                  fontWeight: fontWeight,
                  fontSize: fontSize,
                  color: color,
                  fontFamily: "EuclidCircularB",
                ),
              ),
      ),
    );
  }
}
