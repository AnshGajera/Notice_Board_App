import 'package:flutter/material.dart';

class AppConstants {
  // App Information
  static const String appName = 'University Notice Board';
  static const String appVersion = '1.0.0';

  // Database
  static const String databaseName = 'notices.db';
  static const String noticesTable = 'notices';
  static const int databaseVersion = 1;

  // UI Constants
  static const double defaultPadding = 16.0;
  static const double cardPadding = 12.0;
  static const double cardMargin = 8.0;
  static const double borderRadius = 12.0;
  static const double buttonHeight = 48.0;

  // Font Sizes
  static const double titleFontSize = 22.0;
  static const double subtitleFontSize = 16.0;
  static const double bodyFontSize = 14.0;
  static const double captionFontSize = 12.0;
  static const double buttonFontSize = 16.0;

  // Colors
  static const Color primaryColor = Colors.blue;
  static const Color secondaryColor = Colors.blueAccent;
  static const Color backgroundColor = Colors.white;
  static const Color errorColor = Colors.red;
  static const Color successColor = Colors.green;
  static const Color warningColor = Colors.orange;
  static const Color textColor = Colors.black87;
  static const Color subtitleTextColor = Colors.grey;

  // Category Colors
  static const Color examColor = Colors.red;
  static const Color eventColor = Colors.green;
  static const Color academicColor = Colors.blue;
  static const Color generalColor = Colors.orange;

  // File Upload
  static const List<String> supportedFileTypes = [
    'pdf',
    'jpg',
    'jpeg',
    'png',
    'txt',
    'doc',
    'docx',
  ];
  static const int maxFileSize = 10 * 1024 * 1024; // 10MB

  // Messages
  static const String noNoticesMessage = 'No notices available';
  static const String noNoticesFoundMessage = 'No notices found';
  static const String addFirstNoticeMessage = 'Tap + to add your first notice';
  static const String noticeAddedMessage = 'Notice added successfully!';
  static const String noticeDeletedMessage = 'Notice deleted successfully!';
  static const String noticeUpdatedMessage = 'Notice updated successfully!';
  static const String fileUploadComingSoon = 'File upload feature coming soon';
  static const String noAttachmentMessage = 'No attachment available';

  // Form Validation
  static const String titleRequiredMessage = 'Please enter a title';
  static const String descriptionRequiredMessage = 'Please enter a description';
  static const String titleTooLongMessage = 'Title is too long';
  static const String descriptionTooLongMessage = 'Description is too long';

  // Limits
  static const int maxTitleLength = 100;
  static const int maxDescriptionLength = 1000;
  static const int previewTextLength = 60;

  // Search
  static const String searchHint = 'Search notices...';

  // Categories
  static const List<String> categories = [
    'All',
    'Exam',
    'Event',
    'Academic',
    'General',
  ];

  // Date Format
  static const String dateFormat = 'yyyy-MM-dd';
  static const String displayDateFormat = 'MMM dd, yyyy';
}

class AppStrings {
  // Screen Titles
  static const String homeTitle = 'University Notices';
  static const String addNoticeTitle = 'Add Notice';
  static const String noticeDetailsTitle = 'Notice Details';

  // Form Labels
  static const String titleLabel = 'Notice Title';
  static const String descriptionLabel = 'Description';
  static const String categoryLabel = 'Category';
  static const String attachFileLabel = 'Attach File';

  // Buttons
  static const String addButton = 'Add Notice';
  static const String cancelButton = 'Cancel';
  static const String saveButton = 'Save';
  static const String deleteButton = 'Delete';
  static const String editButton = 'Edit';
  static const String backButton = 'Back';

  // Sections
  static const String noticeInformation = 'Notice Information';
  static const String descriptionSection = 'Description';
  static const String attachmentSection = 'Attachment';

  // File Status
  static const String noFileSelected = 'No file selected';
  static const String fileSelected = 'File selected';
  static const String noFilesAttached = 'No files attached';
}

class AppDimensions {
  // Card Dimensions
  static const double cardElevation = 3.0;
  static const double listItemHeight = 120.0;

  // Icon Sizes
  static const double smallIconSize = 16.0;
  static const double mediumIconSize = 24.0;
  static const double largeIconSize = 32.0;
  static const double extraLargeIconSize = 64.0;

  // Spacing
  static const double smallSpacing = 4.0;
  static const double mediumSpacing = 8.0;
  static const double largeSpacing = 16.0;
  static const double extraLargeSpacing = 24.0;

  // Filter Chip
  static const double filterChipHeight = 40.0;
  static const double filterChipSpacing = 8.0;
}
