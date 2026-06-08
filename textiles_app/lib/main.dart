import 'package:flutter/material.dart';
import 'screens/farms_home_screen.dart';
import 'screens/textiles_catalog_screen.dart';
import 'screens/textiles_product_detail_screen.dart';
import 'screens/auth_screen.dart';

import 'package:flex_color_scheme/flex_color_scheme.dart';

void main() {
  runApp(const TextilesApp());
}

class TextilesApp extends StatelessWidget {
  const TextilesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nallam Group | Farms & Textiles',
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(
        colors: const FlexSchemeColor(
          primary: Color(0xFF1F3A2E),
          primaryContainer: Color(0xFFD4E7DC),
          secondary: Color(0xFF8A5A3B),
          secondaryContainer: Color(0xFFF3E5DC),
          tertiary: Color(0xFFC7A86B),
          tertiaryContainer: Color(0xFFF9EED6),
          appBarColor: Color(0xFF1F3A2E),
          error: Color(0xFFB00020),
        ),
        surfaceMode: FlexSurfaceMode.levelSurfacesLowScaffold,
        blendLevel: 7,
        subThemesData: const FlexSubThemesData(
          blendOnLevel: 10,
          blendOnColors: false,
          useMaterial3Typography: true,
          useM2StyleDividerInM3: true,
          alignedDropdown: true,
          useInputDecoratorThemeInDialogs: true,
        ),
        visualDensity: FlexColorScheme.comfortablePlatformDensity,
        useMaterial3: true,
      ).copyWith(
        scaffoldBackgroundColor: const Color(0xFFFCFBF8),
        textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: 'Cormorant Garamond', fontWeight: FontWeight.bold),
          displayMedium: TextStyle(fontFamily: 'Cormorant Garamond', fontWeight: FontWeight.bold),
          displaySmall: TextStyle(fontFamily: 'Cormorant Garamond', fontWeight: FontWeight.bold),
          headlineLarge: TextStyle(fontFamily: 'Cormorant Garamond', fontWeight: FontWeight.bold),
          headlineMedium: TextStyle(fontFamily: 'Cormorant Garamond', fontWeight: FontWeight.bold),
          headlineSmall: TextStyle(fontFamily: 'Cormorant Garamond', fontWeight: FontWeight.bold),
          titleLarge: TextStyle(fontFamily: 'Cormorant Garamond', fontWeight: FontWeight.bold),
          titleMedium: TextStyle(fontFamily: 'Plus Jakarta Sans', fontWeight: FontWeight.w600),
          titleSmall: TextStyle(fontFamily: 'Plus Jakarta Sans', fontWeight: FontWeight.w600),
          bodyLarge: TextStyle(fontFamily: 'Plus Jakarta Sans'),
          bodyMedium: TextStyle(fontFamily: 'Plus Jakarta Sans'),
          bodySmall: TextStyle(fontFamily: 'Plus Jakarta Sans'),
          labelLarge: TextStyle(fontFamily: 'Plus Jakarta Sans', fontWeight: FontWeight.bold),
        ),
      ),
      onGenerateRoute: (settings) {
        final name = settings.name ?? '/';
        final uri = Uri.parse(name);
        
        if (uri.path == '/product') {
          final productId = settings.arguments as String? ?? uri.queryParameters['id'];
          return FadePageRoute(
            child: const TextilesProductDetailScreen(),
            settings: RouteSettings(
              name: name,
              arguments: productId,
            ),
          );
        }
        
        if (uri.path == '/catalog') {
          final category = settings.arguments as String? ?? uri.queryParameters['category'];
          return FadePageRoute(
            child: const TextilesCatalogScreen(),
            settings: RouteSettings(
              name: name,
              arguments: category,
            ),
          );
        }
        
        if (uri.path == '/auth') {
          return FadePageRoute(
            child: const AuthScreen(),
            settings: settings,
          );
        }
        
        // Default route (Home)
        return FadePageRoute(
          child: const FarmsHomeScreen(),
          settings: settings,
        );
      },
    );
  }
}

class FadePageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;

  FadePageRoute({required this.child, required RouteSettings settings})
      : super(
          settings: settings,
          pageBuilder: (context, animation, secondaryAnimation) => child,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          transitionDuration: const Duration(milliseconds: 200),
          reverseTransitionDuration: const Duration(milliseconds: 150),
        );
}
