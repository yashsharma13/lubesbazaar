// lib/utils/helpers.dart
import 'dart:async';
import 'package:flutter/material.dart';

class Helpers {
  /// Trim text of a controller
  static void trimCtrl(TextEditingController c) {
    c.text = c.text.trim();
  }

  /// Trim a list of controllers
  static void trimAll(Iterable<TextEditingController> ctrls) {
    for (final c in ctrls) {
      c.text = c.text.trim();
    }
  }

  /// Remove extra spaces from a string (collapse multiple spaces)
  static String removeExtraSpaces(String input) =>
      input.replaceAll(RegExp(r'\s+'), ' ').trim();

  /// Title Case (simple)
  static String toTitleCase(String input) {
    final cleaned = removeExtraSpaces(input.toLowerCase());
    if (cleaned.isEmpty) return cleaned;
    return cleaned
        .split(' ')
        .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
        .join(' ');
  }

  /// Is null or empty (after trim)
  static bool isNullOrEmpty(String? s) => s == null || s.trim().isEmpty;

  /// Safe int parse
  static int? parseIntSafe(String? s) {
    if (s == null) return null;
    return int.tryParse(s.trim());
  }

  /// Safe double parse
  static double? parseDoubleSafe(String? s) {
    if (s == null) return null;
    return double.tryParse(s.trim());
  }

  /// Show a SnackBar quickly
  static void showSnack(
    BuildContext context,
    String message, {
    int seconds = 2,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: seconds),
      ),
    );
  }

  /// Unfocus keyboard
  static void unfocus(BuildContext context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }

  /// Move focus to next field
  static void focusNext(BuildContext context) =>
      FocusScope.of(context).nextFocus();

  /// Try pop safely
  static void safePop(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  /// Debouncer: call expensive function after user stops typing
  static Debouncer debouncer({int milliseconds = 400}) =>
      Debouncer(milliseconds: milliseconds);
}

/// Simple debouncer
class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({this.milliseconds = 400});

  void run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() => _timer?.cancel();
}
