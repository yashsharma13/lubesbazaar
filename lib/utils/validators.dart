// lib/utils/validators.dart
class Validators {
  /// Required field validator
  static String? requiredField(
    String? value, {
    String message = "This field is required",
  }) {
    if (value == null || value.trim().isEmpty) return message;
    return null;
  }

  /// Basic email validator
  static String? email(
    String? value, {
    String message = "Enter a valid email",
  }) {
    if (value == null || value.trim().isEmpty) return "Email is required";
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) return message;
    return null;
  }

  /// Password min-length validator (default 6)
  static String? password(String? value, {int min = 6, String? message}) {
    if (value == null || value.isEmpty) return "Password is required";
    if (value.length < min) {
      return message ?? "Password must be at least $min characters";
    }
    return null;
  }

  /// Name validator (letters + spaces, min 2 chars)
  static String? name(String? value, {String message = "Enter a valid name"}) {
    if (value == null || value.trim().isEmpty) return "Name is required";
    final nameRegex = RegExp(r"^[A-Za-z][A-Za-z\s'.-]{1,}$");
    if (!nameRegex.hasMatch(value.trim())) return message;
    return null;
  }

  /// Indian 10-digit phone (starts 6-9)
  static String? phoneIN(
    String? value, {
    String message = "Enter a valid 10-digit mobile",
  }) {
    if (value == null || value.trim().isEmpty) return "Mobile is required";
    final phoneRegex = RegExp(r'^[6-9]\d{9}$');
    if (!phoneRegex.hasMatch(value.trim())) return message;
    return null;
  }

  /// Generic min length
  static String? minLength(String? value, int min, {String? message}) {
    if (value == null) return "This field is required";
    if (value.trim().length < min) {
      return message ?? "Enter at least $min characters";
    }
    return null;
  }

  /// Generic max length
  static String? maxLength(String? value, int max, {String? message}) {
    if (value == null) return null;
    if (value.trim().length > max) {
      return message ?? "Must be at most $max characters";
    }
    return null;
  }

  /// Match with another controller's value (e.g., confirm email/password)
  static String? matches(
    String? value,
    String otherValue, {
    String message = "Values do not match",
  }) {
    if ((value ?? "").trim() != otherValue.trim()) return message;
    return null;
  }

  /// Strong password (optional): at least 8, upper, lower, digit, special
  static String? strongPassword(String? value, {String? message}) {
    if (value == null || value.isEmpty) return "Password is required";
    final regex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[^A-Za-z0-9]).{8,}$',
    );
    if (!regex.hasMatch(value)) {
      return message ?? "Use upper, lower, number & special char (8+ chars)";
    }
    return null;
  }
}
