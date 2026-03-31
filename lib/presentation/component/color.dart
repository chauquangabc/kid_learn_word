
import 'dart:ui';

class AppColors {
  // Surface
  static const Color surface = Color(0xFFF1F9F1);
  static const Color surfaceContainer = Color(0xFFE1EBE2);
  static const Color surfaceContainerLow = Color(0xFFEBF3EC);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFD1DED2);

  // Primary
  static const Color primary = Color(0xFFAA2C32);
  static const Color primaryContainer = Color(0xFFFF7574);
  static const Color secondaryFixed = Color(0xFF7CF6EC);
  static const Color tertiary = Color(0xFF6A5B00);

  // Text
  static const Color onSurface = Color(0xFF29302B);
  static const Color onSurfaceVariant = Color(0xFF5C645E);
  static const Color outlineVariant = Color(0xFFA7AFA8);

  // Utility
  static const Color white = Color(0xFFFFFFFF);
  static const Color glass = Color(0x99FFFFFF);
  static const Color shadow = Color(0x1A29302B);

  // Extra used in screens
  static const Color coral     = Color(0xFFE5605E);
  static const Color gold      = Color(0xFFDAA520);
  static const Color green     = Color(0xFF00A87E);
  static const Color bgLight   = Color(0xFFF2F9F5);

  // Settings / text tokens (mirror của RN COLORS)
  static const Color border      = Color(0xFFD1DED2); // = surfaceVariant
  static const Color textDark    = Color(0xFF29302B); // = onSurface
  static const Color textMid     = Color(0xFF5C645E); // = onSurfaceVariant
  static const Color textLight   = Color(0xFFA7AFA8); // = outlineVariant
  static const Color primaryPale = Color(0x1AAA2C32); // primary ~10% opacity
}

class AppSpacing {
  static const double xs  = 4;
  static const double sm  = 8;
  static const double md  = 16;
  static const double lg  = 24;
  static const double xl  = 32;
  static const double xxl = 64;
  static const double s4  = 14;
  static const double s6  = 32;
  static const double s10 = 40;
  static const double s12 = 48;
}

class AppRadius {
  static const double def  = 16;
  static const double lg   = 32;
  static const double xl   = 48;
  static const double full = 9999;
}