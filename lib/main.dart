import 'package:flutter/material.dart';

/// Import shared theme and models
import 'theme/app_theme.dart';

/// Authentication screen imports (Anushka)
import 'screens/login/login_screen.dart';
import 'screens/login/signup_screen.dart';
import 'screens/login/success_screen.dart';

/// UI screen imports (Aabid)
import 'screens/home/home_screen.dart';
import 'screens/programs_screen.dart';
import 'screens/program_details_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excelerate Connect',
      debugShowCheckedModeBanner: false,

      /// UI Theme Configuration
      /// Using Aabid's predefined lightTheme for consistency
      theme: AppTheme.lightTheme,

      /// Entry Point
      home: const LoginScreen(),

      /// Named Navigation Routes
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/success': (context) => const SuccessScreen(),

        // This is now the main entry point for the "Logged In" state
        '/main': (context) => const RootShell(),

        // Sub-routes for specific pages
        '/home': (context) => const HomeScreen(),
        '/programs': (context) => const ProgramsScreen(),

        // FIXED: '/program_details' was removed from here because it requires
        // a 'program' parameter that cannot be provided in a static routes map.
      },
    );
  }
}

// --- Aabid's Navigation Structure Integrated Below ---

/// [RootShell] acts as the "Master Frame" with the Bottom Navigation Bar.
/// It stays active while the user switches between Home, Courses, and Profile.
class RootShell extends StatefulWidget {
  const RootShell({super.key});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  // These are the screens reachable via the Bottom Nav
  final _pages = const [
    HomeScreen(),
    ProgramsScreen(),
    Placeholder(), // Search/Center Item
    Placeholder(), // Message
    Placeholder(), // Account
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_index],
      bottomNavigationBar: AppBottomNav(
        currentIndex: _index,
        onChanged: (i) => setState(() => _index = i),
      ),
    );
  }
}

/// Custom Bottom Navigation Bar from Aabid's UI Branch
class AppBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onChanged;

  const AppBottomNav({
    super.key,
    required this.currentIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Container(
        height: 72,
        padding: const EdgeInsets.symmetric(horizontal: 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 30,
              offset: Offset(0, -10),
              color: Color(0x14000000),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _NavItem(icon: Icons.home_rounded, label: "Home", selected: currentIndex == 0, onTap: () => onChanged(0)),
            _NavItem(icon: Icons.grid_view_rounded, label: "Course", selected: currentIndex == 1, onTap: () => onChanged(1)),
            _NavCenterItem(selected: currentIndex == 2, onTap: () => onChanged(2)),
            _NavItem(icon: Icons.chat_bubble_outline_rounded, label: "Message", selected: currentIndex == 3, onTap: () => onChanged(3)),
            _NavItem(icon: Icons.person_outline_rounded, label: "Account", selected: currentIndex == 4, onTap: () => onChanged(4)),
          ],
        ),
      ),
    );
  }
}

/// Individual Nav Item (Internal to main.dart)
class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({required this.icon, required this.label, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = selected ? const Color(0xFF2D5BFF) : const Color(0xFFB8C0D0);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        width: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24, color: color),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color)),
          ],
        ),
      ),
    );
  }
}

/// Center "Search" Item in the Bottom Nav
class _NavCenterItem extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  const _NavCenterItem({required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56, height: 56,
        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [
          BoxShadow(blurRadius: 30, offset: Offset(0, 12), color: Color(0x22000000)),
        ]),
        child: Center(
          child: Container(
            width: 44, height: 44,
            decoration: const BoxDecoration(color: Color(0xFF2D5BFF), shape: BoxShape.circle),
            child: const Icon(Icons.search_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}