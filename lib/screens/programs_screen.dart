// lib/screens/programs_screen.dart
import 'package:flutter/material.dart';
import '../models/program.dart';
import '../services/program_service.dart';
import '../theme/app_theme.dart';
import '../widgets/category_chip.dart';
import '../widgets/program_card.dart';
import '../widgets/search_field.dart';
import 'program_details_screen.dart';

class ProgramsScreen extends StatefulWidget {
  const ProgramsScreen({super.key});

  @override
  State<ProgramsScreen> createState() => _ProgramsScreenState();
}

class _ProgramsScreenState extends State<ProgramsScreen> {
  int selectedIndex = 0;
  List<Program> programs = [];
  bool isLoading = true;
  String? errorMessage;

  final categories = const ["All", "Popular", "New"];

  @override
  void initState() {
    super.initState();
    _loadPrograms();
  }

  Future<void> _loadPrograms() async {
    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final fetchedPrograms = await ProgramService.getProgramsFromJson();
      setState(() {
        programs = fetchedPrograms;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to load programs. Please try again.';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final selected = categories[selectedIndex];

    final filtered = selected == "All"
        ? programs
        : programs.where((p) => p.category == selected).toList();

    return SafeArea(
      // FIXED: Wrapped in SingleChildScrollView to prevent "Bottom Overflow" errors
      // when screen height is small or content expands (like keyboard opening)
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(18, 18, 18, 18), // Added bottom padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    "Programs",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w900,
                      color: AppTheme.textDark,
                    ),
                  ),
                  const Spacer(),
                  // Add refresh button
                  IconButton(
                    onPressed: _loadPrograms,
                    icon: const Icon(Icons.refresh, color: AppTheme.primary),
                    tooltip: 'Refresh programs',
                  ),
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFEFF4FF),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Icon(Icons.person, color: AppTheme.primary),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              const SearchField(hint: "Find Course"),
              const SizedBox(height: 14),
              const Row(
                children: [
                  Expanded(
                    child: _MiniBanner(
                      title: "Coding",
                      icon: Icons.code_rounded,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _MiniBanner(
                      title: "App Dev",
                      icon: Icons.phone_iphone_rounded,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              const Text(
                "Choose your course",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  color: AppTheme.textSoft,
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 44,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (_, i) => CategoryChip(
                    label: categories[i],
                    selected: selectedIndex == i,
                    onTap: () => setState(() => selectedIndex = i),
                  ),
                  separatorBuilder: (_, __) => const SizedBox(width: 10),
                  itemCount: categories.length,
                ),
              ),
              const SizedBox(height: 14),

              // Loading and Error States
              if (isLoading)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(40.0),
                    child: CircularProgressIndicator(
                      color: AppTheme.primary,
                    ),
                  ),
                )
              else if (errorMessage != null)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.error_outline,
                          size: 48, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(
                        errorMessage!,
                        style: const TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: _loadPrograms,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                        ),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                )
              else if (filtered.isEmpty)
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(40.0),
                      child: Text(
                        'No programs available',
                        style: TextStyle(
                          fontSize: 16,
                          color: AppTheme.textSoft,
                        ),
                      ),
                    ),
                  )
                else
                // FIXED: Used shrinkWrap and NeverScrollableScrollPhysics to work inside SingleChildScrollView
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filtered.length,
                    itemBuilder: (_, i) {
                      final item = filtered[i];
                      return ProgramCard(
                        program: item,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ProgramDetailsScreen(program: item),
                            ),
                          );
                        },
                      );
                    },
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MiniBanner extends StatelessWidget {
  final String title;
  final IconData icon;

  const _MiniBanner({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 72,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFFDCEFFF),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w900,
                  color: AppTheme.primary,
                ),
              ),
            ),
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(icon, color: AppTheme.primary),
            )
          ],
        ));
  }
}