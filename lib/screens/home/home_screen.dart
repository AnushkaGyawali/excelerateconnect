import 'package:flutter/material.dart';
import '../../theme/app_theme.dart'; // Import the shared theme

// Import ProfileScreen
import 'package:excelerateconnect/main.dart';

/// [HomeScreen] serves as the main dashboard for the user after a successful login.
/// It displays the user's progress, news, and learning plans.
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // The Scaffold provides the top-level container for this screen
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// Top Profile and Progress Header Section
              const _HomeHeader(),

              const SizedBox(height: 18),

              /// Main Dashboard Content
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 12),

                    /// Horizontal News Slider
                    SizedBox(
                      height: 160,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          const SizedBox(width: 10),
                          _NewsBanner(
                            title: "Latest News",
                            description: "UI/UX Design workshop this weekend",
                            buttonText: "Know More",
                            color: const Color(0xFFCEECFE),
                            buttonColor: const Color(0xFFFF7A3D),
                            iconPath: '/icons/news-icon.png',
                            onButtonPressed: () {
                              _onNewsBannerPressed(context, "Workshop Alert");
                            },
                          ),
                          const SizedBox(width: 10),
                          _NewsBanner(
                            title: "New Course Launch",
                            description: "Learn advanced Flutter techniques",
                            buttonText: "Explore",
                            color: const Color(0xFFDCEFFF),
                            buttonColor: const Color(0xFFFF7A3D),
                            iconPath: '/icons/news-icon.png',
                            onButtonPressed: () {
                              _onNewsBannerPressed(
                                  context, "New Course Launch");
                            },
                          ),
                          const SizedBox(width: 10),
                          _NewsBanner(
                            title: "Workshop Alert",
                            description: "UI/UX Design workshop this weekend",
                            buttonText: "Register",
                            color: const Color(0xFFE9E0FF),
                            buttonColor: const Color(0xFF6C63FF),
                            icon: Icons.event,
                            onButtonPressed: () {
                              _onNewsBannerPressed(context, "Workshop Alert");
                            },
                          ),
                          const SizedBox(width: 10),
                          _NewsBanner(
                            title: "Hackathon 2024",
                            description:
                                "Annual coding competition registration open",
                            buttonText: "Join Now",
                            color: const Color(0xFFFFF0E6),
                            buttonColor: const Color(0xFF4CAF50),
                            icon: Icons.code,
                            onButtonPressed: () {
                              _onNewsBannerPressed(context, "Hackathon 2024");
                            },
                          ),
                          const SizedBox(width: 10),
                          _NewsBanner(
                            title: "Mobile Development",
                            description: "Learn iOS & Android development",
                            buttonText: "Start Now",
                            color: const Color(0xFFFFF0E6),
                            buttonColor: const Color(0xFF9C27B0),
                            iconPath: '/icons/news-icon.png',
                            onButtonPressed: () {
                              _onNewsBannerPressed(
                                  context, "Mobile Development");
                            },
                          ),
                          const SizedBox(width: 2),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    SectionTitle(
                      title: "Learning Plan",
                      onSeeAll: () {
                        _onSeeAllLearningPlansPressed(context);
                      },
                    ),
                    const SizedBox(height: 12),
                    _PlanTile(
                      title: "App Development",
                      progress: "40/48",
                      onTap: () {
                        _onPlanTilePressed(context, "App Development");
                      },
                    ),
                    const SizedBox(height: 10),
                    _PlanTile(
                      title: "Web Development",
                      progress: "6/24",
                      onTap: () {
                        _onPlanTilePressed(context, "Web Development");
                      },
                    ),

                    const SizedBox(height: 18),
                    _MeetupBanner(
                      onTap: () {
                        _onMeetupBannerPressed(context);
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

  // Navigation/Button Press Handlers
  void _onNewsBannerPressed(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening: $title'),
        duration: const Duration(seconds: 1),
      ),
    );
    // Add your navigation logic here
    // Navigator.push(context, MaterialPageRoute(builder: (context) => NextScreen()));
  }

  void _onSeeAllNewsPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening All News'),
        duration: Duration(seconds: 1),
      ),
    );
    // Add your navigation logic here
  }

  void _onSeeAllLearningPlansPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening All Learning Plans'),
        duration: Duration(seconds: 1),
      ),
    );
    // Add your navigation logic here
  }

  void _onPlanTilePressed(BuildContext context, String title) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening Learning Plan: $title'),
        duration: const Duration(seconds: 1),
      ),
    );
    // Add your navigation logic here
  }

  void _onMeetupBannerPressed(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Opening Meetup Details'),
        duration: Duration(seconds: 1),
      ),
    );
    // Add your navigation logic here
  }
}

/// The Header section containing the Blue background, Greeting, and Progress Card.
class _HomeHeader extends StatelessWidget {
  const _HomeHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(18, 22, 18, 22),
      decoration: const BoxDecoration(
        color: AppTheme.primary,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(26),
          bottomRight: Radius.circular(26),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Hi, Aabid",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 6),
                  Text(
                    "Welcome to Excelerate Connect",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFD6DEFF),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // UPDATED: User Profile Icon with navigation to Profile Screen
              GestureDetector(
                onTap: () {
                  // Navigate to Profile Screen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ProfileScreen(),
                    ),
                  );
                },
                child: Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child:
                      const Icon(Icons.person, color: Colors.white, size: 22),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),

          /// Daily Progress Indicator Card with tap functionality
          GestureDetector(
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Opening My Programs'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
            child: const _DailyProgressCard(),
          ),
        ],
      ),
    );
  }
}

/// A nested card within the header showing time spent learning today.
class _DailyProgressCard extends StatelessWidget {
  const _DailyProgressCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text(
                "Learned today",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.textSoft,
                ),
              ),
              Spacer(),
              Text(
                "My Programs",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          const Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "46min",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.textDark,
                ),
              ),
              SizedBox(width: 6),
              Padding(
                padding: EdgeInsets.only(bottom: 2),
                child: Text(
                  "/ 60min",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textSoft,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: 46 / 60,
              minHeight: 7,
              backgroundColor: const Color(0xFFEFEFEF),
              valueColor: const AlwaysStoppedAnimation(Color(0xFFFC7B5A)),
            ),
          )
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
  final IconData? icon; // Material icon
  final String? iconPath; // Path to custom icon image
  final Widget? customIcon; // Custom icon widget
  final VoidCallback onButtonPressed;

  const _NewsBanner({
    required this.title,
    required this.description,
    required this.buttonText,
    required this.color,
    required this.buttonColor,
    this.icon,
    this.iconPath,
    this.customIcon,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    Widget iconWidget;

    // Determine which icon to show
    if (customIcon != null) {
      iconWidget = customIcon!;
    } else if (iconPath != null) {
      // Use Image.asset for custom icons
      iconWidget = Image.asset(
        iconPath!,
        width: 34,
        height: 34,
        color: AppTheme.primary,
        errorBuilder: (context, error, stackTrace) {
          // Fallback to a default icon if image fails to load
          return Icon(
            Icons.image_not_supported,
            size: 34,
            color: AppTheme.primary,
          );
        },
      );
    } else {
      // Fallback to Material icon
      iconWidget = Icon(
        icon ?? Icons.info, // Default icon if none provided
        size: 34,
        color: AppTheme.primary,
      );
    }

    return GestureDetector(
      onTap: onButtonPressed,
      child: Container(
        width: 280, // Fixed width for each slider item
        height: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.textSoft,
                    ),
                  ),
                  const SizedBox(height: 12),
                  MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: GestureDetector(
                      onTap: onButtonPressed,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 14, vertical: 8),
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          buttonText,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(width: 12),
            // Image/Icon Container
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(child: iconWidget),
            )
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
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: const Color(0xFFE9E0FF),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Meetup",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Color(0xFFE42929),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Off-line exchange of learning experience",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF440687),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Image.asset(
                    '/icons/meetup-icon.png',
                    width: 32,
                    height: 32,
                    color: AppTheme.primary,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.group,
                        size: 32,
                        color: AppTheme.primary,
                      );
                    },
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
            fontSize: 18,
            fontWeight: FontWeight.w900,
            color: AppTheme.textDark,
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: onSeeAll,
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Text(
                "See all",
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.primary,
                ),
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
  final VoidCallback onTap;

  const _PlanTile({
    required this.title,
    required this.progress,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: const [
              BoxShadow(
                blurRadius: 24,
                offset: Offset(0, 12),
                color: Color(0x10000000),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.timelapse_rounded, color: AppTheme.textSoft),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w900,
                    color: AppTheme.textDark,
                  ),
                ),
              ),
              Text(
                progress,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.textSoft,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
