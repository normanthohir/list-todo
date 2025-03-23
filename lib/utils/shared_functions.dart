import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// untuk sneck bar
class SharedFunctions {
  void showSnackBar(
    BuildContext context, {
    required String message,
    Color? backgroundColor = Colors.red,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          elevation: 0,
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.transparent,
          content: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              message,
              style: TextStyle(color: Colors.white),
            ),
          )),
    );
  }

// utuk di pake category
  Color randomColor() {
    return Colors.primaries[Random().nextInt(Colors.primaries.length)];
  }

// unutk formating date waktu
  TimeOfDay parseTime(String time) {
    final format = RegExp(r'(\d+):(\d+) (\w+)');
    final match = format.firstMatch(time);

    if (match != null) {
      final hour = int.parse(match.group(1)!);
      final minute = int.parse(match.group(2)!);
      final period = match.group(3)!;

      final isPM = period.toLowerCase() == 'pm';
      final adjustedHour = isPM ? (hour % 12) + 12 : hour % 12;

      return TimeOfDay(hour: adjustedHour, minute: minute);
    } else {
      throw FormatException('Invalid time format');
    }
  }

  // untuk milih tanggal
  Future<DateTime?> selectDate(
    BuildContext context,
    DateTime? initialDate,
  ) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    return picked;
  }

  // untuk milih jam
  Future<TimeOfDay?> selectStartTime(
    BuildContext context,
    TimeOfDay? initialDate,
  ) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: initialDate ?? TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );
    return picked;
  }

  String formatTimeOfDay(TimeOfDay timeOfDay) {
    final now = DateTime.now();
    final dt = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );
    final format = DateFormat.jm();
    return format.format(dt);
  }
}
