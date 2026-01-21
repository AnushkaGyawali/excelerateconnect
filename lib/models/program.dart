class Program {
  final String title;
  final String provider;
  final String duration;
  final String category;

  const Program({
    required this.title,
    required this.provider,
    required this.duration,
    required this.category,
  });
   factory Program.fromJson(Map<String, dynamic> json) {
      return Program(
        title: json['title'],
        provider: json['provider'],
        duration: json['duration'],
        category: json['category'],
      );
      }
}
