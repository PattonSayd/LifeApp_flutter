import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lifeapp/constants/colors.dart';
import 'package:lifeapp/constants/fonts.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final String? label, hint;
  final List<TextInputFormatter>? inputFormatters;
  final Widget? suffix;
  final Widget? prefix;
  Color color;
  Color? fillColor;
  double? dividerThickness;
  final VoidCallback? callbackSuffixIcon;
  final Function(String)? onChanged;
  final Function()? onTap;
  final Function()? onEditingComplete;
  final Function(String value)? onFieldSubmitted;
  final int? minLines, maxLines;
  FocusNode? focusNode;
  TextEditingController controller;
  TextAlign? align;
  bool isClearable;
  double height;
  TextStyle? hintStyle;
  Offset? clearIconOffset;
  TextStyle? labelStyle;
  TextStyle? floatingLabelStyle;
  BoxConstraints? prefixIconConstraints;
  EdgeInsets padding;
  double? fontSize;
  bool isSuffixIconConstraints;
  bool obscureText;
  bool hasBorder;
  bool hasUnderLineBorder;
  Widget? underLineBorder;
  double dividerScale;
  bool autoFocus;
  TextAlignVertical verticalTextAlign;
  FontWeight fontWeight;
  TextInputAction? textInputAction;
  final int? maxLength;
  final bool showCursor;
  double? clearIconHeight;
  final TextCapitalization? textCapitalization;
  bool hasError;
  String? errorText;
  String? initialValue;

  CustomTextField(
      {this.keyboardType,
      this.label,
      this.textInputAction,
      this.verticalTextAlign = TextAlignVertical.center,
      this.color = CustomColors.textBlack,
      this.fillColor,
      this.onChanged,
      this.onTap,
      this.onEditingComplete,
      this.onFieldSubmitted,
      this.suffix,
      this.dividerScale = 1.01,
      this.hintStyle,
      this.labelStyle,
      this.prefixIconConstraints,
      this.floatingLabelStyle,
      this.clearIconHeight,
      this.clearIconOffset,
      this.dividerThickness,
      this.autoFocus = false,
      this.fontWeight = FontWeight.w500,
      this.height = 1.5,
      this.showCursor = true,
      this.align = TextAlign.start,
      this.prefix,
      this.padding = EdgeInsets.zero,
      this.inputFormatters,
      this.minLines,
      this.maxLines = 1,
      this.isSuffixIconConstraints = false,
      this.isClearable = false,
      this.hint,
      this.hasError = false,
      this.errorText = null,
      this.hasBorder = false,
      this.obscureText = false,
      this.hasUnderLineBorder = false,
      this.underLineBorder,
      this.initialValue,
      this.focusNode,
      this.fontSize = 15,
      this.maxLength = 1000,
      required this.controller,
      this.callbackSuffixIcon,
      this.textCapitalization});

  Widget build(BuildContext context) {
    if (focusNode == null) {
      focusNode = FocusNode();
    }
    return TextFormField(
      obscureText: obscureText,
      textInputAction: textInputAction ?? TextInputAction.next,
      inputFormatters: inputFormatters ?? [],
      initialValue: initialValue,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
        height: height,
      ),
      controller: controller,
      onChanged: (text) {
        onChanged?.call(text);
      },
      textAlign: align!,
      onTap: () {
        if (onTap != null) onTap!.call();
      },
      keyboardType: keyboardType,
      maxLength: maxLength,
      textAlignVertical: verticalTextAlign,
      scrollPadding: EdgeInsets.zero,
      onFieldSubmitted: onFieldSubmitted,
      cursorColor: hasError ? CustomColors.red : CustomColors.primary,
      decoration: InputDecoration(
        filled: fillColor == null ? false : true,
        fillColor: fillColor == null ? Colors.transparent : fillColor,
        errorText: errorText,
        counterText: '',
        alignLabelWithHint: true,
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: CustomColors.border,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: CustomColors.border,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
          borderSide: BorderSide(
            color: CustomColors.border,
          ),
        ),
        prefixIcon: prefix != null ? prefix : null,
        prefixIconConstraints: prefixIconConstraints,
        hintText: hint,
        suffixIcon: suffix != null ? suffix : null,
        contentPadding: padding,
        hintStyle: hintStyle ??
            TextStyle(
              fontSize: 16.csp,
              fontWeight: FontWeight.w400,
              color: CustomColors.textSecondary,
            ),
        labelText: label,
        labelStyle: labelStyle ??
            TextStyle(
              fontSize: fontSize,
              fontWeight: fontWeight,
              color: CustomColors.textBlack,
              height: height,
            ),
      ),
      minLines: minLines,
      maxLines: maxLines,
    );
  }
}
