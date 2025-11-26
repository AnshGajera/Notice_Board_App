import 'package:flutter/material.dart';
import '../models/notice.dart';
import '../database/database_helper.dart';
import '../utils/constants.dart';
import '../widgets/category_filter.dart';
import '../widgets/notice_cart.dart';
import 'notice_detail_screen.dart';
import 'notice_entry_screen.dart';

class NoticeListScreen extends StatefulWidget {
  @override
  _NoticeListScreenState createState() => _NoticeListScreenState();
}

class _NoticeListScreenState extends State<NoticeListScreen> {
  String _selectedFilter = 'All';
  String _searchQuery = '';
  List<Notice> notices = [];
  final DatabaseHelper _databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    _loadNotices();
  }

  Future<void> _loadNotices() async {
    final loadedNotices = await _databaseHelper.getAllNotices();
    setState(() {
      notices = loadedNotices;
    });
  }

  List<Notice> get filteredNotices {
    List<Notice> filtered = notices;

    if (_selectedFilter != 'All') {
      filtered = filtered
          .where((notice) => notice.category == _selectedFilter)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where(
            (notice) =>
                notice.title.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ) ||
                notice.description.toLowerCase().contains(
                  _searchQuery.toLowerCase(),
                ),
          )
          .toList();
    }

    return filtered;
  }

  Future<void> _addNotice(
    String title,
    String description,
    String category,
  ) async {
    final notice = Notice(
      title: title,
      description: description,
      category: category,
      date: DateTime.now().toString().substring(0, 10),
    );

    await _databaseHelper.insertNotice(notice);
    await _loadNotices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.homeTitle),
        backgroundColor: AppConstants.primaryColor,
      ),

      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(AppConstants.defaultPadding),
            child: TextField(
              decoration: InputDecoration(
                hintText: AppConstants.searchHint,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppConstants.borderRadius * 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding,
                  vertical: AppConstants.cardPadding,
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),

          CategoryFilterHorizontal(
            selectedCategory: _selectedFilter,
            onCategorySelected: (category) {
              setState(() {
                _selectedFilter = category;
              });
            },
          ),

          Expanded(
            child: filteredNotices.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: AppDimensions.extraLargeIconSize,
                          color: AppConstants.subtitleTextColor,
                        ),
                        SizedBox(height: AppDimensions.largeSpacing),
                        Text(
                          notices.isEmpty
                              ? AppConstants.noNoticesMessage
                              : AppConstants.noNoticesFoundMessage,
                          style: TextStyle(
                            fontSize: AppConstants.subtitleFontSize,
                            color: AppConstants.subtitleTextColor,
                          ),
                        ),
                        if (notices.isEmpty)
                          Padding(
                            padding: EdgeInsets.only(
                              top: AppDimensions.mediumSpacing,
                            ),
                            child: Text(
                              AppConstants.addFirstNoticeMessage,
                              style: TextStyle(
                                fontSize: AppConstants.bodyFontSize,
                                color: AppConstants.subtitleTextColor,
                              ),
                            ),
                          ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    itemCount: filteredNotices.length,
                    itemBuilder: (context, index) {
                      final notice = filteredNotices[index];
                      return NoticeCard(
                        notice: notice,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NoticeDetailScreen(
                                title: notice.title,
                                description: notice.description,
                                category: notice.category,
                                date: notice.date,
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  NoticeEntryScreen(onNoticeAdded: _addNotice),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
    );
  }
}
