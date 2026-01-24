import 'package:flutter/material.dart';
import '../models/program.dart';
import '../theme/app_theme.dart';

class ProgramDetailsScreen extends StatelessWidget {
  final Program program;

  const ProgramDetailsScreen({super.key, required this.program});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(
        title: const Text(
          "Program Details",
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main Program Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: 30,
                      offset: Offset(0, 16),
                      color: Color(0x14000000),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      program.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 10),

                    // Provider
                    Row(
                      children: [
                        const Icon(Icons.person_outline,
                            color: AppTheme.textSoft, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          program.provider,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textSoft,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),

                    // Duration
                    Row(
                      children: [
                        const Icon(Icons.schedule_rounded,
                            color: AppTheme.textSoft, size: 18),
                        const SizedBox(width: 6),
                        Text(
                          program.duration,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w800,
                            color: AppTheme.textSoft,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),

                    // Stats Row
                    Row(
                      children: [
                        // Enrolled Count
                        _buildStatItem(
                          icon: Icons.people_alt,
                          value: "${program.enrolled}",
                          label: "Enrolled",
                        ),
                        const SizedBox(width: 20),

                        // Rating
                        _buildStatItem(
                          icon: Icons.star,
                          value: "${program.rating}",
                          label: "Rating",
                          iconColor: Colors.amber,
                        ),
                        const SizedBox(width: 20),

                        // Level
                        _buildStatItem(
                          icon: Icons.trending_up,
                          value: program.level,
                          label: "Level",
                        ),
                      ],
                    ),

                    const SizedBox(height: 18),

                    // About Section
                    const Text(
                      "About this program",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      program.description.isNotEmpty
                          ? program.description
                          : "This comprehensive course is designed to help you master the skills needed for success. Through hands-on projects and real-world examples, you'll gain practical experience that you can immediately apply in your career.",
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        fontWeight: FontWeight.w600,
                        color: AppTheme.textSoft,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Curriculum Section
                    const Text(
                      "Curriculum",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        color: AppTheme.textDark,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _buildCurriculumItem("Module 1: Introduction", "2 hours"),
                    _buildCurriculumItem("Module 2: Core Concepts", "4 hours"),
                    _buildCurriculumItem(
                        "Module 3: Advanced Topics", "6 hours"),
                    _buildCurriculumItem("Module 4: Final Project", "4 hours"),

                    const SizedBox(height: 25),

                    // ENROLL NOW BUTTON - UPDATED FOR WEEK 3
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        onPressed: () {
                          // Navigate to registration form with program data
                          Navigator.pushNamed(
                            context,
                            '/registration',
                            arguments: program, // Pass the program object
                          );
                        },
                        child: const Text(
                          "Enroll Now",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // Alternative Action Buttons
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Add to wishlist
                              _showSnackBar(context, "Added to wishlist");
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: BorderSide(color: AppTheme.primary),
                            ),
                            icon: const Icon(Icons.bookmark_border,
                                color: AppTheme.primary),
                            label: const Text(
                              "Save for Later",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: AppTheme.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              // Share program
                              _showSnackBar(
                                  context, "Share feature coming soon");
                            },
                            style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              side: const BorderSide(color: Colors.grey),
                            ),
                            icon: const Icon(Icons.share, color: Colors.grey),
                            label: const Text(
                              "Share",
                              style: TextStyle(
                                fontWeight: FontWeight.w800,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Additional Information
              const SizedBox(height: 20),
              _buildAdditionalInfoCard(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String value,
    required String label,
    Color iconColor = AppTheme.textSoft,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: iconColor),
              const SizedBox(width: 6),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.textDark,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSoft,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCurriculumItem(String title, String duration) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppTheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child:
                const Icon(Icons.play_arrow, color: AppTheme.primary, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppTheme.textDark,
              ),
            ),
          ),
          Text(
            duration,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSoft,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            blurRadius: 30,
            offset: Offset(0, 16),
            color: Color(0x08000000),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Program Information",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w900,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 12),
          _buildInfoRow("Certificate", "Yes, upon completion"),
          _buildInfoRow("Language", "English"),
          _buildInfoRow("Access", "Lifetime access"),
          _buildInfoRow("Support", "24/7 community support"),
          _buildInfoRow("Prerequisites", "Basic computer knowledge"),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: AppTheme.textDark,
              ),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppTheme.textSoft,
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
