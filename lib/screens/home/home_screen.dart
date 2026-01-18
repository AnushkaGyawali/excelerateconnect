import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top greeting row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        "Hi, Aabid",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Welcome to Excelerate Connect",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  const CircleAvatar(
                    radius: 22,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, color: Colors.white),
                  )
                ],
              ),

              const SizedBox(height: 24),

              // Learned today card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          "Learned today",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "My Programs",
                          style: TextStyle(
                            color: Color(0xFF4361EE),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text("46min / 60min"),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: 0.75,
                        minHeight: 8,
                        backgroundColor: Colors.grey.shade300,
                        color: const Color(0xFF4361EE),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // News cards
              Row(
                children: [
                  Expanded(child: _newsCard("Latest News")),
                  const SizedBox(width: 12),
                  Expanded(child: _newsCard("")),
                ],
              ),

              const SizedBox(height: 24),

              // Learning plan
              const Text(
                "Learning Plan",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),

              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: const [
                    _planRow("App Development", "40/48"),
                    SizedBox(height: 12),
                    _planRow("Web Development", "6/24"),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Meetup card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Meetup",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Off-line exchange of...",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                    Icon(Icons.groups, size: 40, color: Colors.grey),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),

      // Bottom navigation (wireframe)
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF4361EE),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book), label: "Course"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: "Message"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Account"),
        ],
      ),
    );
  }
}

// ---------- Helper Widgets ----------

Widget _newsCard(String title) {
  return Container(
    height: 140,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        const Spacer(),
        const Icon(Icons.image, size: 40, color: Colors.grey),
        const Spacer(),
        if (title.isNotEmpty)
          const Text(
            "Know More",
            style: TextStyle(color: Color(0xFF4361EE)),
          ),
      ],
    ),
  );
}

class _planRow extends StatelessWidget {
  final String title;
  final String progress;

  const _planRow(this.title, this.progress);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.radio_button_checked, size: 18),
        const SizedBox(width: 10),
        Expanded(child: Text(title)),
        Text(progress),
      ],
    );
  }
}
