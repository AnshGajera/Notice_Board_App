class Notice {
  final int? id;
  final String title;
  final String description;
  final String category;
  final String date;
  final String? filePath;

  Notice({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.date,
    this.filePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'filePath': filePath,
    };
  }

  factory Notice.fromMap(Map<String, dynamic> map) {
    return Notice(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      date: map['date'],
      filePath: map['filePath'],
    );
  }

  Notice copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    String? date,
    String? filePath,
  }) {
    return Notice(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      date: date ?? this.date,
      filePath: filePath ?? this.filePath,
    );
  }
}
