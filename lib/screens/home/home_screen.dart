import 'package:flutter/material.dart';
import '../../theme/app_theme.dart'; // Import the shared theme

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
                    const SectionTitle(title: "Latest News"),
                    const SizedBox(height: 12),
                    const _NewsBanner(),
                    const SizedBox(height: 18),

                    const SectionTitle(title: "Learning Plan"),
                    const SizedBox(height: 12),
                    const _PlanTile(title: "App Development", progress: "40/48"),
                    const SizedBox(height: 10),
                    const _PlanTile(title: "Web Development", progress: "6/24"),

                    const SizedBox(height: 18),
                    const _MeetupBanner(),
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
              // User Profile Icon
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.person, color: Colors.white, size: 22),
              ),
            ],
          ),
          const SizedBox(height: 18),

          /// Daily Progress Indicator Card
          const _DailyProgressCard(),
        ],
      ),
    );
  }
}

extension on Color {
  withValues({required double alpha}) {}
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
            child: const LinearProgressIndicator(
              value: 46 / 60,
              minHeight: 7,
              backgroundColor: Color(0xFFEFEFEF),
              valueColor: AlwaysStoppedAnimation(Color(0xFFFC7B5A)),
            ),
          )
        ],
      ),
    );
  }
}

/// Promotional or News Banner widget.
class _NewsBanner extends StatelessWidget {
  const _NewsBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFDCEFFF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF7A3D),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Text(
                    "Know More",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(Icons.article_rounded, size: 34, color: AppTheme.primary),
          )
        ],
      ),
    );
  }
}

/// A Meetup information card.
class _MeetupBanner extends StatelessWidget {
  const _MeetupBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFFE9E0FF),
        borderRadius: BorderRadius.circular(18),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Meetup",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: AppTheme.textDark,
            ),
          ),
          SizedBox(height: 6),
          Text(
            "Off-line exchange of learning experience",
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: AppTheme.textSoft,
            ),
          ),
        ],
      ),
    );
  }
}

/// Reusable section title with a "See all" action button.
class SectionTitle extends StatelessWidget {
  final String title;
  const SectionTitle({super.key, required this.title});

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
        const Text(
          "See all",
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: AppTheme.primary,
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

  const _PlanTile({required this.title, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}