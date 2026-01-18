import 'package:flutter/material.dart';

/// Authentication screen imports
import 'screens/login/login_screen.dart';
import 'screens/login/signup_screen.dart';
import 'screens/login/success_screen.dart';
import 'screens/home/home_screen.dart';


/// The entry point of the Excelerate Connect application.
void main() {
  runApp(const MyApp());
}

/// [MyApp] is the root configuration widget of the application.
///
/// It sets up the global theme, the initial landing page,
/// and defines the named navigation routes used throughout the app.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excelerate Connect',

      // Removes the "Debug" banner from the top-right corner
      debugShowCheckedModeBanner: false,

      /// UI Theme Configuration
      /// Uses Material 3 design principles with a custom primary seed color.
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4361EE), // Main brand blue
        ),
        useMaterial3: true,
        // Sets a light grey background globally for all Scaffolds
        scaffoldBackgroundColor: const Color(0xFFF5F5F5),
      ),

      /// The widget that will be displayed when the app starts.
      home: const LoginScreen(),

      /// Named Navigation Routes
      /// Using strings as routes makes it easier to navigate deep into the
      /// application without passing context manually everywhere.
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/success': (context) => const SuccessScreen(),
        '/home': (context) => const HomeScreen(),

      },
    );
  }
}