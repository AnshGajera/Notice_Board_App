import 'package:flutter/material.dart';
import '../models/category.dart';
import '../utils/constants.dart';

class NoticeDetailScreen extends StatelessWidget {
  final String title;
  final String description;
  final String category;
  final String date;

  NoticeDetailScreen({
    required this.title,
    required this.description,
    required this.category,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.noticeDetailsTitle),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstants.defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              child: Padding(
                padding: EdgeInsets.all(AppConstants.defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.notifications,
                          color: AppConstants.primaryColor,
                        ),
                        SizedBox(width: AppDimensions.mediumSpacing),
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: AppConstants.titleFontSize,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppDimensions.largeSpacing),

                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.cardPadding,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: CategoryHelper.getCategoryColor(category),
                        borderRadius: BorderRadius.circular(
                          AppConstants.borderRadius + 4,
                        ),
                      ),
                      child: Text(
                        category,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: AppConstants.captionFontSize,
                        ),
                      ),
                    ),

                    SizedBox(height: AppDimensions.largeSpacing),

                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today,
                          size: 16,
                          color: Colors.grey,
                        ),
                        SizedBox(width: 4),
                        Text(
                          date,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      description,
                      style: TextStyle(fontSize: 16, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 16),

            Card(
              child: ListTile(
                leading: Icon(Icons.attach_file, color: Colors.blue),
                title: Text('Attachment'),
                subtitle: Text('No files attached'),
                trailing: Icon(Icons.download),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('No attachment available')),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
