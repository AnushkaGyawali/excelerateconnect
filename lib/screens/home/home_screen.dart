import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../services/auth_service.dart';
import '../../screens/programs_screen.dart';
import '../../screens/program_details_screen.dart';
import '../../screens/profile/my_programs_screen.dart';
import '../../models/program.dart';

/// [HomeScreen] serves as the main dashboard for the user after a successful login.
/// It displays the user's progress, news, and learning plans.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = AuthService().currentUser;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              /// Top Profile and Progress Header Section
              _HomeHeader(userName: currentUser?.name ?? 'User'),

              const SizedBox(height: 18),

              /// Main Dashboard Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    /// Horizontal News Slider
                    /// FIXED: Increased height from 160 to 210 to prevent overflow
                    SizedBox(
                      height: 210,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        children: [
                          const SizedBox(width: 10),
                          _NewsBanner(
                            title: "UI/UX Design Workshop",
                            description: "Master design principles this weekend",
                            buttonText: "Register Now",
                            color: const Color(0xFFCEECFE),
                            buttonColor: const Color(0xFFFF7A3D),
                            icon: Icons.design_services,
                            onButtonPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ProgramDetailsScreen(
                                    program: Program(
                                      id: '1',
                                      title: 'UI/UX Design Workshop',
                                      description: 'Master design principles and tools in this intensive weekend workshop',
                                      duration: '2 days',
                                      hours: 16,
                                      price: '\$49',
                                      category: 'Design',
                                      level: 'Beginner',
                                      rating: 4.8,
                                      enrolled: 142,
                                      provider: 'Excelerate Academy',
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                          _NewsBanner(
                            title: "Flutter Masterclass",
                            description: "Advanced Flutter techniques",
                            buttonText: "Explore",
                            color: const Color(0xFFDCEFFF),
                            buttonColor: AppTheme.primary,
                            icon: Icons.code,
                            onButtonPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ProgramsScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                          _NewsBanner(
                            title: "AI & ML Bootcamp",
                            description: "Learn AI/ML fundamentals",
                            buttonText: "Join Now",
                            color: const Color(0xFFE9E0FF),
                            buttonColor: const Color(0xFF6C63FF),
                            icon: Icons.smart_toy,
                            onButtonPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ProgramDetailsScreen(
                                    program: Program(
                                      id: '3',
                                      title: 'AI & ML Bootcamp',
                                      description: 'Comprehensive introduction to Artificial Intelligence and Machine Learning',
                                      duration: '8 weeks',
                                      hours: 64,
                                      price: '\$199',
                                      category: 'Technology',
                                      level: 'Intermediate',
                                      rating: 4.9,
                                      enrolled: 256,
                                      provider: 'Tech Masters Inc.',
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                          _NewsBanner(
                            title: "Hackathon 2024",
                            description: "Annual coding competition",
                            buttonText: "Join Now",
                            color: const Color(0xFFFFF0E6),
                            buttonColor: const Color(0xFF4CAF50),
                            icon: Icons.emoji_events,
                            onButtonPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ProgramDetailsScreen(
                                    program: Program(
                                      id: '4',
                                      title: 'Hackathon 2024',
                                      description: 'Annual coding competition with exciting prizes',
                                      duration: '48 hours',
                                      hours: 48,
                                      price: 'Free',
                                      category: 'Competition',
                                      level: 'All Levels',
                                      rating: 4.7,
                                      enrolled: 500,
                                      provider: 'Excelerate Community',
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 10),
                          _NewsBanner(
                            title: "Mobile Development",
                            description: "iOS & Android development",
                            buttonText: "Start Now",
                            color: const Color(0xFFFFF0E6),
                            buttonColor: const Color(0xFF9C27B0),
                            icon: Icons.phone_android,
                            onButtonPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ProgramsScreen(),
                                ),
                              );
                            },
                          ),
                          const SizedBox(width: 2),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    SectionTitle(
                      title: "My Learning Plans",
                      onSeeAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MyProgramsScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _PlanTile(
                      title: "App Development Bootcamp",
                      progress: "40/48 hours",
                      icon: Icons.phone_android,
                      progressValue: 40/48,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProgramDetailsScreen(
                              program: Program(
                                id: '5',
                                title: 'App Development Bootcamp',
                                description: 'Complete mobile app development course',
                                duration: '48 hours',
                                hours: 48,
                                price: '\$149',
                                category: 'Development',
                                level: 'Advanced',
                                rating: 4.6,
                                enrolled: 189,
                                provider: 'Mobile Dev Academy',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    _PlanTile(
                      title: "Web Development Mastery",
                      progress: "6/24 hours",
                      icon: Icons.web,
                      progressValue: 6/24,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProgramDetailsScreen(
                              program: Program(
                                id: '6',
                                title: 'Web Development Mastery',
                                description: 'Full-stack web development course',
                                duration: '24 hours',
                                hours: 24,
                                price: '\$99',
                                category: 'Development',
                                level: 'Intermediate',
                                rating: 4.5,
                                enrolled: 312,
                                provider: 'Web Wizards',
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 10),
                    _PlanTile(
                      title: "Data Science Fundamentals",
                      progress: "12/36 hours",
                      icon: Icons.analytics,
                      progressValue: 12/36,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProgramDetailsScreen(
                              program: Program(
                                id: '7',
                                title: 'Data Science Fundamentals',
                                description: 'Introduction to data science and analytics',
                                duration: '36 hours',
                                hours: 36,
                                price: '\$179',
                                category: 'Data Science',
                                level: 'Beginner',
                                rating: 4.8,
                                enrolled: 278,
                                provider: 'Data Science Institute',
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),

                    SectionTitle(
                      title: "Upcoming Events",
                      onSeeAll: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const ProgramsScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    _EventCard(
                      title: "Tech Networking Meetup",
                      date: "Tomorrow, 6:00 PM",
                      location: "Innovation Center",
                      participants: 45,
                      onTap: () {
                        _showEventDetails(context, "Tech Networking Meetup");
                      },
                    ),
                    const SizedBox(height: 10),
                    _EventCard(
                      title: "Startup Pitch Competition",
                      date: "Oct 25, 2:00 PM",
                      location: "Business Hub",
                      participants: 28,
                      onTap: () {
                        _showEventDetails(context, "Startup Pitch Competition");
                      },
                    ),

                    const SizedBox(height: 18),
                    _MeetupBanner(
                      onTap: () {
                        _showMeetupDetails(context);
                      },
                    ),
                    const SizedBox(height: 26),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEventDetails(BuildContext context, String eventName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(eventName),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📍 Innovation Center"),
            SizedBox(height: 8),
            Text("⏰ Tomorrow, 6:00 PM - 8:00 PM"),
            SizedBox(height: 8),
            Text(
              "Join us for an exciting networking event with industry experts, tech leaders, and fellow developers. Free food and drinks provided!",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.people, size: 16),
                SizedBox(width: 4),
                Text("45 attending"),
              ],
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _showRegistrationSuccess(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
            ),
            child: const Text('Register Now', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showMeetupDetails(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
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
              "Offline Learning Exchange",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Join our monthly meetup where learners share experiences, challenges, and solutions in a collaborative environment.",
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [
                Icon(Icons.calendar_today, color: AppTheme.primary),
                SizedBox(width: 10),
                Text("Last Saturday of every month"),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.location_on, color: AppTheme.primary),
                SizedBox(width: 10),
                Text("Excelerate Learning Center"),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showRegistrationSuccess(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Join Next Meetup",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  void _showRegistrationSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                'Successfully registered for the event!',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 20),
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ],
        ),
        backgroundColor: Colors.green,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

/// The Header section containing the Blue background, Greeting, and Progress Card.
class _HomeHeader extends StatelessWidget {
  final String userName;

  const _HomeHeader({required this.userName});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
      decoration: BoxDecoration(
        color: AppTheme.primary,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primary,
            AppTheme.primary.withOpacity(0.8),
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, $userName",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Welcome to Excelerate Connect",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFD6DEFF),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // User Profile Icon with navigation to Profile Screen
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, '/profile');
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          /// Daily Progress Indicator Card with tap functionality
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const MyProgramsScreen(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.timeline, color: AppTheme.primary, size: 18),
                      SizedBox(width: 8),
                      Text(
                        "Today's Progress",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textSoft,
                        ),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Text(
                            "View Programs",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: AppTheme.primary,
                            ),
                          ),
                          SizedBox(width: 4),
                          Icon(Icons.arrow_forward, size: 14, color: AppTheme.primary),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "46",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: AppTheme.textDark,
                        ),
                      ),
                      SizedBox(width: 4),
                      Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(
                          "minutes",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.textSoft,
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        "of 60 goal",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textSoft,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Stack(
                    children: [
                      Container(
                        height: 10,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFEFEF),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      LayoutBuilder(
                          builder: (context, constraints) {
                            // 46/60 is approx 0.77
                            return Container(
                              height: 10,
                              width: constraints.maxWidth * 0.77,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFFFF7A3D), Color(0xFFFC7B5A)],
                                ),
                                borderRadius: BorderRadius.circular(5),
                              ),
                            );
                          }
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "77% completed",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.textSoft,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Promotional or News Banner widget for horizontal slider.
class _NewsBanner extends StatelessWidget {
  final String title;
  final String description;
  final String buttonText;
  final Color color;
  final Color buttonColor;
  final IconData icon;
  final VoidCallback onButtonPressed;

  const _NewsBanner({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.color,
    required this.buttonColor,
    required this.icon,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onButtonPressed,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 280,
        // FIXED: Increased height to 190 to accommodate text and button without overflow
        height: 190,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min, // Use min to shrink if possible
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  // FIXED: Wrapped in Flexible to handle potential text overflow
                  Flexible(
                    child: Text(
                      description,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.textSoft,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 14),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: onButtonPressed,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: buttonColor.withOpacity(0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              buttonText,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w800,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Icon(Icons.arrow_forward, size: 14, color: Colors.white),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Icon Container
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 34,
                  color: AppTheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// A Meetup information card with downloaded icon.
class _MeetupBanner extends StatelessWidget {
  final VoidCallback onTap;

  const _MeetupBanner({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFE9E0FF),
                Color(0xFFD6C9FF),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF6C63FF).withOpacity(0.2),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Community Meetup",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFF440687),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Join our monthly offline learning exchange. Share experiences, network with peers, and learn together in a collaborative environment.",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF440687),
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today,
                            size: 18, color: Color(0xFF6C63FF)),
                        const SizedBox(width: 8),
                        const Expanded(
                          child: Text(
                            "Monthly Event",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF6C63FF),
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF6C63FF),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF6C63FF).withOpacity(0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Row(
                            children: [
                              Text(
                                "Learn More",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                              SizedBox(width: 6),
                              Icon(Icons.arrow_forward,
                                  size: 16, color: Colors.white),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Center(
                  child: Icon(
                    Icons.group,
                    size: 40,
                    color: Color(0xFF6C63FF),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Event Card Widget
class _EventCard extends StatelessWidget {
  final String title;
  final String date;
  final String location;
  final int participants;
  final VoidCallback onTap;

  const _EventCard({
    required this.title,
    required this.date,
    required this.location,
    required this.participants,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(
                  Icons.event,
                  color: AppTheme.primary,
                  size: 28,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.textDark,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today,
                          size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on,
                          size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          location,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Column(
              children: [
                const Icon(Icons.people, size: 18, color: AppTheme.primary),
                const SizedBox(height: 4),
                Text(
                  '$participants',
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Reusable section title with a "See all" action button.
class SectionTitle extends StatelessWidget {
  final String title;
  final VoidCallback onSeeAll;

  const SectionTitle({
    super.key,
    required this.title,
    required this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w900,
            color: AppTheme.textDark,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onSeeAll,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Row(
                children: [
                  Text(
                    "See all",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.primary,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward,
                      size: 16, color: AppTheme.primary),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// A tile used to display specific learning plan progress.
class _PlanTile extends StatelessWidget {
  final String title;
  final String progress;
  final IconData icon;
  final double progressValue;
  final VoidCallback onTap;

  const _PlanTile({
    required this.title,
    required this.progress,
    required this.icon,
    required this.progressValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppTheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Icon(icon, color: AppTheme.primary, size: 24),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: AppTheme.textDark,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              Container(
                                height: 6,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.grey[200],
                                  borderRadius: BorderRadius.circular(3),
                                ),
                              ),
                              LayoutBuilder(
                                  builder: (context, constraints) {
                                    // FIXED: Clamped value to avoid layout error if progress > 1.0
                                    final safeProgress = progressValue.clamp(0.0, 1.0);
                                    return Container(
                                      height: 6,
                                      width: constraints.maxWidth * safeProgress,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            AppTheme.primary,
                                            AppTheme.primary.withOpacity(0.7),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                    );
                                  }
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          progress,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.chevron_right,
                  color: AppTheme.textSoft, size: 24),
            ],
          ),
        ),
      ),
    );
  }
}