import 'package:flutter/material.dart';

import 'fonts.dart';

ButtonStyle elevatedButtonStyle({
  Color? backgroundColor,
  EdgeInsetsGeometry? padding,
  BorderRadiusGeometry? radius,
  Size? minimumSize,
}) =>
    ElevatedButton.styleFrom(
      padding: padding ?? const EdgeInsets.all(16.0),
      backgroundColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: radius ?? BorderRadius.circular(10.0),
      ),
      minimumSize: minimumSize ?? const Size(0, 48),
    );

ButtonStyle outlineButtonStyle({
  Color? backgroundColor,
  EdgeInsetsGeometry? padding,
  BorderRadiusGeometry? radius,
  Size? minimumSize,
}) =>
    OutlinedButton.styleFrom(
      padding: padding ?? const EdgeInsets.all(16.0),
      // backgroundColor: backgroundColor ?? primary,
      shape: RoundedRectangleBorder(
        borderRadius: radius ?? BorderRadius.circular(10.0),
      ),
      minimumSize: minimumSize ?? const Size(0, 48),
    );

InputDecoration inputDecorationRounded({double? radius}) => InputDecoration(
      filled: true,
      isDense: true,
      fillColor: Colors.grey[200],
      contentPadding: const EdgeInsets.all(16.0),
      hintStyle: bodyFont.copyWith(fontSize: 12.0),
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(radius ?? 10),
      ),
    );
