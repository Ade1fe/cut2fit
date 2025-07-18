import 'package:flutter/material.dart';
import 'package:cut2fit/pages/splash_page.dart';
import 'package:cut2fit/utils/database_helper.dart';

// Initialize DatabaseHelper globally
final dbHelper = DatabaseHelper.instance;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the database helper
  try {
    await dbHelper.database; // This ensures the database is created and opened
    print('Database initialized successfully.');
  } catch (e) {
    print('Failed to initialize database: $e');
    // You might want to show an error dialog to the user here
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Professional Measurement App',
      theme: ThemeData(
        primarySwatch: Colors.orange, // Changed to orange
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // A modern, clean font
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black87,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: Colors.grey[50], // Light background
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange[700], // Changed to orange
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 3,
            textStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.grey[100],
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
            borderSide: BorderSide(
              color: Colors.orange[700]!,
              width: 2,
            ), // Changed to orange
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          hintStyle: TextStyle(color: Colors.grey[500]),
        ),
      ),
      home: const SplashPage(), // Still starts with SplashPage
    );
  }
}

// Extension for showing snackbars easily
extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Colors.red[700]
            : Colors.orange[700], // Changed to orange for success
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }
}
