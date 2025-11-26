import '../models/notice.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static List<Notice> _notices = [];
  static int _nextId = 1;

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  Future<int> insertNotice(Notice notice) async {
    final newNotice = notice.copyWith(id: _nextId++);
    _notices.add(newNotice);
    return newNotice.id!;
  }

  Future<List<Notice>> getAllNotices() async {
    return List.from(_notices.reversed);
  }

  Future<List<Notice>> getNoticesByCategory(String category) async {
    return _notices
        .where((notice) => notice.category == category)
        .toList()
        .reversed
        .toList();
  }

  Future<int> updateNotice(Notice notice) async {
    final index = _notices.indexWhere((n) => n.id == notice.id);
    if (index != -1) {
      _notices[index] = notice;
      return 1;
    }
    return 0;
  }

  Future<int> deleteNotice(int id) async {
    final index = _notices.indexWhere((notice) => notice.id == id);
    if (index != -1) {
      _notices.removeAt(index);
      return 1;
    }
    return 0;
  }

  Future<List<Notice>> searchNotices(String query) async {
    final lowerQuery = query.toLowerCase();
    return _notices
        .where(
          (notice) =>
              notice.title.toLowerCase().contains(lowerQuery) ||
              notice.description.toLowerCase().contains(lowerQuery),
        )
        .toList()
        .reversed
        .toList();
  }
}
