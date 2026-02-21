/// Utility class for converting and validating user input
class InputConverter {
  /// Converts a string to an unsigned integer
  /// Returns null if the string is not a valid positive integer
  int? stringToUnsignedInt(String str) {
    final parsed = int.tryParse(str);
    if (parsed == null || parsed < 0) {
      return null;
    }
    return parsed;
  }

  /// Converts a string to a double
  /// Returns null if the string is not a valid number
  double? stringToDouble(String str) {
    return double.tryParse(str);
  }

  /// Converts a string to a positive decimal (for prices, quantities)
  double? stringToPositiveDecimal(String str) {
    final parsed = double.tryParse(str);
    if (parsed == null || parsed < 0) {
      return null;
    }
    return parsed;
  }
}
