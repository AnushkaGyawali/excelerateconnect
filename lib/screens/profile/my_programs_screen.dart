import 'package:flutter/material.dart';
import '../../models/program.dart';
import '../../services/enrollment_service.dart';
import '../../theme/app_theme.dart';
import '../program_details_screen.dart';

class MyProgramsScreen extends StatefulWidget {
  const MyProgramsScreen({super.key});

  @override
  State<MyProgramsScreen> createState() => _MyProgramsScreenState();
}

class _MyProgramsScreenState extends State<MyProgramsScreen> {
  final EnrollmentService _enrollmentService = EnrollmentService();
  final Map<String, double> _programProgress =
      {}; // Track progress for each program

  @override
  void initState() {
    super.initState();
    // Initialize progress for all enrolled programs
    _initializeProgress();
    _enrollmentService.addListener(_onEnrollmentChanged);
  }

  void _initializeProgress() {
    final programs = _enrollmentService.getEnrolledPrograms();
    for (var program in programs) {
      if (!_programProgress.containsKey(program.id)) {
        _programProgress[program.id] = 0.0; // Start at 0% progress
      }
    }
  }

  void _onEnrollmentChanged() {
    if (mounted) {
      setState(() {
        _initializeProgress();
      });
    }
  }

  void _updateProgress(String programId, double progress) {
    setState(() {
      _programProgress[programId] = progress.clamp(0.0, 1.0);
    });
  }

  @override
  void dispose() {
    _enrollmentService.removeListener(_onEnrollmentChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final enrolledPrograms = _enrollmentService.getEnrolledPrograms();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Programs',
          style: TextStyle(fontWeight: FontWeight.w900),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to previous screen
          },
        ),
        actions: [
          if (enrolledPrograms.isNotEmpty)
            IconButton(
              onPressed: () => _showClearAllDialog(),
              icon: const Icon(Icons.delete_outline),
              tooltip: 'Clear all',
            ),
        ],
      ),
      body: enrolledPrograms.isEmpty
          ? _buildEmptyState()
          : _buildProgramsList(enrolledPrograms),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.school_outlined,
            size: 80,
            color: AppTheme.primary,
          ),
          const SizedBox(height: 20),
          const Text(
            'No Programs Enrolled',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w900,
              color: AppTheme.textDark,
            ),
          ),
          const SizedBox(height: 10),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              'Browse programs and enroll to see them here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppTheme.textSoft,
              ),
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // Go back to browse programs
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Browse Programs'),
          ),
        ],
      ),
    );
  }

  Widget _buildProgramsList(List<Program> programs) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: programs.length,
      itemBuilder: (context, index) {
        final program = programs[index];
        final progress = _programProgress[program.id] ?? 0.0;
        final progressPercentage = (progress * 100).toInt();

        return Card(
          margin: const EdgeInsets.only(bottom: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ProgramDetailsScreen(program: program),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Progress Circle
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withOpacity(0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              value: progress,
                              strokeWidth: 4,
                              backgroundColor: Colors.grey[200],
                              valueColor: AlwaysStoppedAnimation<Color>(
                                progress >= 1.0
                                    ? Colors.green
                                    : AppTheme.primary,
                              ),
                            ),
                            Text(
                              '$progressPercentage%',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              program.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              program.provider,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              program.duration,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'start',
                            child: Row(
                              children: [
                                Icon(Icons.play_arrow,
                                    size: 18, color: Colors.green),
                                SizedBox(width: 8),
                                Text('Start Learning'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'view',
                            child: Row(
                              children: [
                                Icon(Icons.visibility, size: 18),
                                SizedBox(width: 8),
                                Text('View Details'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'mark_complete',
                            child: Row(
                              children: [
                                Icon(Icons.check_circle,
                                    size: 18, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('Mark Complete'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'unenroll',
                            child: Row(
                              children: [
                                Icon(Icons.cancel, size: 18, color: Colors.red),
                                SizedBox(width: 8),
                                Text('Unenroll'),
                              ],
                            ),
                          ),
                        ],
                        onSelected: (value) {
                          if (value == 'start') {
                            _updateProgress(program.id, progress + 0.25);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Starting ${program.title}'),
                              ),
                            );
                          } else if (value == 'view') {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    ProgramDetailsScreen(program: program),
                              ),
                            );
                          } else if (value == 'mark_complete') {
                            _updateProgress(program.id, 1.0);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    '${program.title} marked as complete!'),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } else if (value == 'unenroll') {
                            _enrollmentService.unenrollFromProgram(program.id);
                            setState(() {});
                          }
                        },
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // Progress Bar
                  LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[200],
                    color: progress >= 1.0 ? Colors.green : AppTheme.primary,
                    minHeight: 6,
                    borderRadius: BorderRadius.circular(3),
                  ),

                  const SizedBox(height: 8),

                  // Progress Text
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          progress >= 1.0
                              ? '✅ Completed'
                              : 'Progress: $progressPercentage%',
                          style: TextStyle(
                            fontSize: 12,
                            color: progress >= 1.0
                                ? Colors.green
                                : Colors.grey[600],
                            fontWeight: progress >= 1.0
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                      if (progress < 1.0)
                        ElevatedButton(
                          onPressed: () {
                            _updateProgress(program.id, progress + 0.25);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.primary,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            minimumSize: const Size(0, 0),
                          ),
                          child: const Text(
                            'Continue',
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear All Programs?'),
        content: const Text(
            'This will remove all your enrolled programs and progress.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _enrollmentService.clearEnrollments();
              _programProgress.clear();
              setState(() {});
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Clear All'),
          ),
        ],
      ),
    );
  }
}
