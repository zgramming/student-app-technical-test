import 'package:flutter/material.dart';

void showSnackbar({
  required BuildContext context,
  required String message,
  Color? backgroundColor,
  Duration? duration,
}) {
  final snackBar = SnackBar(
    content: Text(message),
    backgroundColor: backgroundColor,
    duration: duration ?? const Duration(seconds: 3),
  );

  // Hide current snackbar if any
  ScaffoldMessenger.of(context).hideCurrentSnackBar();

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

Future<DateTime?> showDateTimePicker(
  BuildContext context, {
  bool withTimePicker = true,
}) async {
  DateTime? date;
  TimeOfDay? time;

  final datePicker = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2100),
  );

  if (datePicker != null) {
    date = datePicker;

    if (withTimePicker && context.mounted) {
      final timePicker = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (timePicker != null) {
        time = timePicker;
      }
    }
  }

  if (withTimePicker) {
    if (date != null && time != null) {
      return date.add(Duration(hours: time.hour, minutes: time.minute));
    }
  } else {
    if (date != null) {
      return date;
    }
  }

  return null;
}
