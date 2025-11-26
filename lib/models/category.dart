import 'package:flutter/material.dart';

enum NoticeCategory { exam, event, academic, general }

extension NoticeCategoryExtension on NoticeCategory {
  String get name {
    switch (this) {
      case NoticeCategory.exam:
        return 'Exam';
      case NoticeCategory.event:
        return 'Event';
      case NoticeCategory.academic:
        return 'Academic';
      case NoticeCategory.general:
        return 'General';
    }
  }

  Color get color {
    switch (this) {
      case NoticeCategory.exam:
        return Colors.red;
      case NoticeCategory.event:
        return Colors.green;
      case NoticeCategory.academic:
        return Colors.blue;
      case NoticeCategory.general:
        return Colors.orange;
    }
  }

  IconData get icon {
    switch (this) {
      case NoticeCategory.exam:
        return Icons.school;
      case NoticeCategory.event:
        return Icons.event;
      case NoticeCategory.academic:
        return Icons.book;
      case NoticeCategory.general:
        return Icons.info;
    }
  }

  static NoticeCategory fromString(String category) {
    switch (category.toLowerCase()) {
      case 'exam':
        return NoticeCategory.exam;
      case 'event':
        return NoticeCategory.event;
      case 'academic':
        return NoticeCategory.academic;
      case 'general':
        return NoticeCategory.general;
      default:
        return NoticeCategory.general;
    }
  }
}

class CategoryHelper {
  static List<String> getAllCategories() {
    return NoticeCategory.values.map((category) => category.name).toList();
  }

  static Color getCategoryColor(String category) {
    return NoticeCategoryExtension.fromString(category).color;
  }

  static IconData getCategoryIcon(String category) {
    return NoticeCategoryExtension.fromString(category).icon;
  }
}
