import 'package:flutter/material.dart';

/// Service for managing app themes with Material 3 and dynamic coloring support
class ThemeService {
  /// Default seed color for the app when dynamic colors aren't available
  static const Color defaultSeedColor = Color(0xFF6750A4);

  /// Creates a light theme using Material 3
  /// [seedColor] - The seed color for generating the color scheme
  /// [dynamicColorScheme] - Optional dynamic color scheme from the system (Monet)
  static ThemeData lightTheme({
    Color? seedColor,
    ColorScheme? dynamicColorScheme,
  }) {
    final colorScheme = dynamicColorScheme ??
        ColorScheme.fromSeed(
          seedColor: seedColor ?? defaultSeedColor,
          brightness: Brightness.light,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: colorScheme.surfaceContainerLow,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  /// Creates a dark theme using Material 3
  /// [seedColor] - The seed color for generating the color scheme
  /// [dynamicColorScheme] - Optional dynamic color scheme from the system (Monet)
  static ThemeData darkTheme({
    Color? seedColor,
    ColorScheme? dynamicColorScheme,
  }) {
    final colorScheme = dynamicColorScheme ??
        ColorScheme.fromSeed(
          seedColor: seedColor ?? defaultSeedColor,
          brightness: Brightness.dark,
        );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        elevation: 0,
        scrolledUnderElevation: 1,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        color: colorScheme.surfaceContainerLow,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(64, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: colorScheme.error),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}

/// Extension to easily access custom theme properties
extension ThemeDataExtension on ThemeData {
  /// Convenience getter for primary container color
  Color get primaryContainer => colorScheme.primaryContainer;

  /// Convenience getter for error container color
  Color get errorContainer => colorScheme.errorContainer;
}

// ============================================================================
// MONET DYNAMIC COLORING INTEGRATION PLACEHOLDER
// ============================================================================
//
// To enable dynamic coloring (Monet) on Android 12+, add the dynamic_color
// package and wrap your app with DynamicColorBuilder:
//
// 1. Add to pubspec.yaml:
//    dependencies:
//      dynamic_color: ^1.6.8
//
// 2. In your app.dart:
//
//    import 'package:dynamic_color/dynamic_color.dart';
//
//    class MyApp extends StatelessWidget {
//      @override
//      Widget build(BuildContext context) {
//        return DynamicColorBuilder(
//          builder: (ColorScheme? lightDynamic, ColorScheme? darkDynamic) {
//            return MaterialApp(
//              theme: ThemeService.lightTheme(
//                dynamicColorScheme: lightDynamic,
//              ),
//              darkTheme: ThemeService.darkTheme(
//                dynamicColorScheme: darkDynamic,
//              ),
//              home: const HomePage(),
//            );
//          },
//        );
//      }
//    }
//
// ============================================================================
