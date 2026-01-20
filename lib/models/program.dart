class Program {
  final String id;
  final String title;
  final String provider;
  final String duration;
  final String category;
  final List<String> tags;
  final double rating;
  final int enrolled;
  final String price;
  final String description;
  final String level;
  final int hours;
  final bool isPopular;
  final bool isNew;

  const Program({
    required this.id,
    required this.title,
    required this.provider,
    required this.duration,
    required this.category,
    this.tags = const [],
    this.rating = 0.0,
    this.enrolled = 0,
    this.price = 'Free',
    this.description = '',
    this.level = 'Beginner',
    required this.hours,
    this.isPopular = false,
    this.isNew = false,
  });

  factory Program.fromJson(Map<String, dynamic> json) {
    return Program(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      provider: json['provider'] ?? '',
      duration: json['duration'] ?? '',
      category: json['category'] ?? 'All',
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      enrolled: (json['enrolled'] as num?)?.toInt() ?? 0,
      price: json['price'] ?? 'Free',
      description: json['description'] ?? '',
      level: json['level'] ?? 'Beginner',
      hours: (json['hours'] as num?)?.toInt() ?? 0,
      isPopular: json['isPopular'] ?? false,
      isNew: json['isNew'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'provider': provider,
      'duration': duration,
      'category': category,
      'tags': tags,
      'rating': rating,
      'enrolled': enrolled,
      'price': price,
      'description': description,
      'level': level,
      'hours': hours,
      'isPopular': isPopular,
      'isNew': isNew,
    };
  }
}
