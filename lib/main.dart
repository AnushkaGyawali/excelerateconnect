import 'package:flutter/material.dart';
import 'theme/app_theme.dart';

// Screens
import 'screens/login/login_screen.dart';
import 'screens/login/signup_screen.dart';
import 'screens/login/success_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/programs_screen.dart';
import 'screens/search_screen.dart';
import 'screens/program_details_screen.dart';
import 'screens/registration_form.dart';
import 'screens/profile/my_programs_screen.dart';

// Models
import 'models/program.dart';

// Services
import 'services/enrollment_service.dart';
import 'services/auth_service.dart';

// Add import alias or create local alias
import 'models/user.dart' as my_app; // Add this import with alias

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize auth service
  final authService = AuthService();
  await authService.init();

  runApp(MyApp(authService: authService));
}

class MyApp extends StatefulWidget {
  final AuthService authService;

  const MyApp({super.key, required this.authService});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Excelerate Connect',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: widget.authService.isLoggedIn()
          ? RootShell(authService: widget.authService)
          : const LoginScreen(),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/success': (context) => const SuccessScreen(),
        '/my-programs': (context) => const MyProgramsScreen(),
        '/messages': (context) => const MessagesScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/program_details') {
          final program = settings.arguments as Program;
          return MaterialPageRoute(
            builder: (context) => ProgramDetailsScreen(program: program),
          );
        }
        if (settings.name == '/registration') {
          final program = settings.arguments as Program;
          return MaterialPageRoute(
            builder: (context) => RegistrationForm(program: program),
          );
        }
        if (settings.name == '/profile') {
          return MaterialPageRoute(
            builder: (context) =>
                ProfileScreen(authService: widget.authService),
          );
        }
        if (settings.name == '/main') {
          return MaterialPageRoute(
            builder: (context) => RootShell(authService: widget.authService),
          );
        }
        return null;
      },
    );
  }
}

// Update ProfileScreen to accept AuthService
class ProfileScreen extends StatelessWidget {
  final AuthService authService;

  const ProfileScreen({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    final enrollmentService = EnrollmentService();
    final enrolledCount = enrollmentService.enrolledCount;
    final currentUser = authService.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Profile Header
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: AppTheme.primary,
                    child: Text(
                      currentUser?.name.substring(0, 1).toUpperCase() ?? 'U',
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    currentUser?.name ?? 'User',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    currentUser?.email ?? 'user@example.com',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            enrolledCount.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primary,
                            ),
                          ),
                          const Text('Programs'),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            '12',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primary,
                            ),
                          ),
                          const Text('Hours'),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            '3',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primary,
                            ),
                          ),
                          const Text('Certificates'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Menu Items
          Card(
            child: Column(
              children: [
                // Edit Profile
                ListTile(
                  leading: const Icon(Icons.edit, color: AppTheme.primary),
                  title: const Text('Edit Profile'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showEditProfileDialog(context, currentUser);
                  },
                ),
                const Divider(height: 0),

                // My Programs
                ListTile(
                  leading: const Icon(Icons.school, color: AppTheme.primary),
                  title: const Text('My Programs'),
                  trailing: Chip(
                    label: Text(enrolledCount.toString()),
                    backgroundColor: AppTheme.primary.withOpacity(0.1),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const MyProgramsScreen(),
                      ),
                    );
                  },
                ),
                const Divider(height: 0),

                // My Certificates
                ListTile(
                  leading: const Icon(Icons.assignment, color: Colors.orange),
                  title: const Text('My Certificates'),
                  trailing: const Chip(
                    label: Text('3'),
                    backgroundColor: Colors.orangeAccent,
                  ),
                  onTap: () {
                    _showCertificatesScreen(context);
                  },
                ),
                const Divider(height: 0),

                // Notifications
                ListTile(
                  leading: const Icon(Icons.notifications, color: Colors.blue),
                  title: const Text('Notifications'),
                  trailing: Switch(
                    value: true,
                    onChanged: (value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(value
                              ? 'Notifications enabled'
                              : 'Notifications disabled'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                  ),
                ),
                const Divider(height: 0),

                // Settings
                ListTile(
                  leading: const Icon(Icons.settings, color: Colors.grey),
                  title: const Text('Settings'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showSettingsScreen(context);
                  },
                ),
                const Divider(height: 0),

                // Help & Support
                ListTile(
                  leading: const Icon(Icons.help, color: Colors.blue),
                  title: const Text('Help & Support'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showHelpSupportScreen(context);
                  },
                ),
                const Divider(height: 0),

                // Logout
                ListTile(
                  leading: const Icon(Icons.logout, color: Colors.red),
                  title:
                      const Text('Logout', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    _showLogoutConfirmation(context, enrollmentService);
                  },
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // About App
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About Excelerate Connect',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Version 1.0.0',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '© 2024 Excelerate. All rights reserved.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // FIXED: Use the aliased User class
  void _showEditProfileDialog(BuildContext context, my_app.User? currentUser) {
    final nameController = TextEditingController(text: currentUser?.name ?? '');
    final emailController =
        TextEditingController(text: currentUser?.email ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Profile'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: 'Full Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 8),
            const Text(
              'Note: Email changes may require verification',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.isNotEmpty &&
                  emailController.text.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile updated successfully'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
                Navigator.pop(context);
              }
            },
            child: const Text('Save Changes'),
          ),
        ],
      ),
    );
  }

  void _showCertificatesScreen(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 60,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'My Certificates',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Download your earned certificates',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // Certificate 1
            _CertificateCard(
              title: 'Flutter Development',
              date: 'Completed: Oct 15, 2024',
              onDownload: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Certificate downloaded successfully'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            // Certificate 2
            _CertificateCard(
              title: 'UI/UX Design',
              date: 'Completed: Sep 28, 2024',
              onDownload: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Certificate downloaded successfully'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            const SizedBox(height: 12),

            // Certificate 3
            _CertificateCard(
              title: 'Web Development',
              date: 'Completed: Aug 10, 2024',
              onDownload: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Certificate downloaded successfully'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),

            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Close',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSettingsScreen(BuildContext context) {
    bool darkMode = false;
    bool autoPlay = true;
    bool downloadWifiOnly = true;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: const Row(
              children: [
                Icon(Icons.settings, color: AppTheme.primary),
                SizedBox(width: 10),
                Text('App Settings'),
              ],
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView(
                shrinkWrap: true,
                children: [
                  const Text(
                    'General Settings',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Dark Mode'),
                    subtitle: const Text('Switch to dark theme'),
                    value: darkMode,
                    onChanged: (value) => setState(() => darkMode = value),
                  ),
                  SwitchListTile(
                    title: const Text('Auto-play Videos'),
                    subtitle: const Text('Automatically play course videos'),
                    value: autoPlay,
                    onChanged: (value) => setState(() => autoPlay = value),
                  ),
                  SwitchListTile(
                    title: const Text('Download on Wi-Fi Only'),
                    subtitle: const Text('Save mobile data'),
                    value: downloadWifiOnly,
                    onChanged: (value) =>
                        setState(() => downloadWifiOnly = value),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'App Theme',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _ThemeOption(
                        color: AppTheme.primary,
                        selected: true,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Theme changed to Blue'),
                              backgroundColor: Colors.blue,
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      _ThemeOption(
                        color: Colors.green,
                        selected: false,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Theme changed to Green'),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      _ThemeOption(
                        color: Colors.purple,
                        selected: false,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Theme changed to Purple'),
                              backgroundColor: Colors.purple,
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                      _ThemeOption(
                        color: Colors.orange,
                        selected: false,
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Theme changed to Orange'),
                              backgroundColor: Colors.orange,
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Choose your preferred app color theme',
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Settings saved successfully'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                ),
                child: const Text('Save Settings',
                    style: TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showHelpSupportScreen(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.help, color: Colors.blue),
            SizedBox(width: 10),
            Text('Help & Support'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'How can we help you today?',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            _SupportOption(
              icon: Icons.help_outline,
              title: 'Frequently Asked Questions',
              subtitle: 'Find answers to common questions',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Opening Frequently Asked Questions'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            _SupportOption(
              icon: Icons.email,
              title: 'Contact Support',
              subtitle: 'Get help from our support team',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Opening contact support form'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            _SupportOption(
              icon: Icons.bug_report,
              title: 'Report a Bug',
              subtitle: 'Found an issue? Let us know',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Opening bug report form'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            _SupportOption(
              icon: Icons.feedback,
              title: 'Send Feedback',
              subtitle: 'Share your thoughts with us',
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Opening feedback form'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _showLogoutConfirmation(
      BuildContext context, EnrollmentService enrollmentService) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Row(
          children: [
            Icon(Icons.logout, color: Colors.red),
            SizedBox(width: 10),
            Text('Confirm Logout'),
          ],
        ),
        content: const Text(
            'Are you sure you want to logout from Excelerate Connect?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              // Clear enrollments
              enrollmentService.clearEnrollments();

              // Logout from auth service
              authService.logout();

              // Navigate to login and clear all routes
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/login',
                (route) => false,
              );

              // Show logout message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logged out successfully'),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            child: const Text('Logout', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class _CertificateCard extends StatelessWidget {
  final String title;
  final String date;
  final VoidCallback onDownload;

  const _CertificateCard({
    required this.title,
    required this.date,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.verified, color: Colors.green, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.download, color: AppTheme.primary),
              ),
              onPressed: onDownload,
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeOption extends StatelessWidget {
  final Color color;
  final bool selected;
  final VoidCallback onTap;

  const _ThemeOption({
    required this.color,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(10),
              border: selected
                  ? Border.all(color: Colors.black, width: 3)
                  : Border.all(color: Colors.grey[300]!, width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          if (selected)
            const Icon(Icons.check_circle, color: Colors.green, size: 16),
        ],
      ),
    );
  }
}

class _SupportOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SupportOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8),
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(fontSize: 12, color: Colors.grey),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}

// Messages Screen
class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> messages = [
      {
        'name': 'Sarah Johnson',
        'message': 'Hi! Are you attending the workshop tomorrow?',
        'time': '10:30 AM',
        'unread': true,
        'avatar': 'SJ',
      },
      {
        'name': 'Tech Support',
        'message':
            'Your issue has been resolved. Let us know if you need further assistance.',
        'time': 'Yesterday',
        'unread': false,
        'avatar': 'TS',
      },
      {
        'name': 'Alex Chen',
        'message': 'Great work on the Flutter project!',
        'time': '2 days ago',
        'unread': false,
        'avatar': 'AC',
      },
      {
        'name': 'Excelerate Team',
        'message': 'New course launched: Advanced Web Development',
        'time': '1 week ago',
        'unread': true,
        'avatar': 'ET',
      },
      {
        'name': 'Maria Garcia',
        'message': 'Let\'s collaborate on the UI/UX project',
        'time': '2 weeks ago',
        'unread': false,
        'avatar': 'MG',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Messages'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Search messages')),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('More options')),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // New Message Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton.icon(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Compose new message')),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text(
                'New Message',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ),

          // Messages List
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: AppTheme.primary,
                      child: Text(
                        message['avatar'],
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    title: Row(
                      children: [
                        Expanded(
                          child: Text(
                            message['name'],
                            style: TextStyle(
                              fontWeight: message['unread']
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                        Text(
                          message['time'],
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    subtitle: Text(
                      message['message'],
                      style: TextStyle(
                        fontWeight: message['unread']
                            ? FontWeight.w600
                            : FontWeight.normal,
                        color: message['unread'] ? Colors.black : Colors.grey,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: message['unread']
                        ? Container(
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(
                              color: AppTheme.primary,
                              shape: BoxShape.circle,
                            ),
                          )
                        : null,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => ChatDetailScreen(message: message),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Chat Detail Screen
class ChatDetailScreen extends StatelessWidget {
  final Map<String, dynamic> message;

  const ChatDetailScreen({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['name'],
              style: const TextStyle(fontSize: 16),
            ),
            const Text(
              'Online',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Received message
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message['message'],
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${message['time']} • Received',
                          style: const TextStyle(
                            fontSize: 10,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Sent message
                Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 8),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'Yes, I\'ll be there! Looking forward to it.',
                          style: TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Now • Sent',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Message input
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey[300]!)),
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {},
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[100],
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: AppTheme.primary),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class RootShell extends StatefulWidget {
  final AuthService authService;

  const RootShell({super.key, required this.authService});

  @override
  State<RootShell> createState() => _RootShellState();
}

class _RootShellState extends State<RootShell> {
  int _index = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      const HomeScreen(),
      const ProgramsScreen(),
      const SearchScreen(),
      const MessagesScreen(),
      ProfileScreen(authService: widget.authService),
    ];
  }

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

// Bottom Navigation Bar
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
            _NavItem(
              icon: Icons.home_rounded,
              label: "Home",
              selected: currentIndex == 0,
              onTap: () => onChanged(0),
            ),
            _NavItem(
              icon: Icons.grid_view_rounded,
              label: "Course",
              selected: currentIndex == 1,
              onTap: () => onChanged(1),
            ),
            _NavCenterItem(
              selected: currentIndex == 2,
              onTap: () => onChanged(2),
            ),
            _NavItem(
              icon: Icons.chat_bubble_outline_rounded,
              label: "Message",
              selected: currentIndex == 3,
              onTap: () => onChanged(3),
            ),
            _NavItem(
              icon: Icons.person_outline_rounded,
              label: "Account",
              selected: currentIndex == 4,
              onTap: () => onChanged(4),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

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
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavCenterItem extends StatelessWidget {
  final bool selected;
  final VoidCallback onTap;
  const _NavCenterItem({
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 30,
              offset: Offset(0, 12),
              color: Color(0x22000000),
            ),
          ],
        ),
        child: Center(
          child: Container(
            width: 44,
            height: 44,
            decoration: const BoxDecoration(
              color: Color(0xFF2D5BFF),
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.search_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}