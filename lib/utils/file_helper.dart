import 'dart:io';
import 'package:flutter/material.dart';
import 'constants.dart';

class FileHelper {
  // Get file extension from file path
  static String getFileExtension(String filePath) {
    return filePath.split('.').last.toLowerCase();
  }

  // Check if file type is supported
  static bool isSupportedFileType(String filePath) {
    String extension = getFileExtension(filePath);
    return AppConstants.supportedFileTypes.contains(extension);
  }

  // Get file size in bytes
  static Future<int> getFileSize(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        return await file.length();
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  // Check if file size is within limit
  static Future<bool> isFileSizeValid(String filePath) async {
    int fileSize = await getFileSize(filePath);
    return fileSize <= AppConstants.maxFileSize && fileSize > 0;
  }

  // Format file size for display
  static String formatFileSize(int bytes) {
    if (bytes == 0) return '0 B';
    const suffixes = ['B', 'KB', 'MB', 'GB'];
    int i = 0;
    double size = bytes.toDouble();

    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }

    return '${size.toStringAsFixed(1)} ${suffixes[i]}';
  }

  // Get file name from path
  static String getFileName(String filePath) {
    return filePath.split('/').last;
  }

  // Get file icon based on extension
  static IconData getFileIcon(String filePath) {
    String extension = getFileExtension(filePath);

    switch (extension) {
      case 'pdf':
        return Icons.picture_as_pdf;
      case 'jpg':
      case 'jpeg':
      case 'png':
        return Icons.image;
      case 'txt':
        return Icons.text_snippet;
      case 'doc':
      case 'docx':
        return Icons.description;
      default:
        return Icons.attach_file;
    }
  }

  // Get file type display name
  static String getFileTypeName(String filePath) {
    String extension = getFileExtension(filePath);

    switch (extension) {
      case 'pdf':
        return 'PDF Document';
      case 'jpg':
      case 'jpeg':
        return 'JPEG Image';
      case 'png':
        return 'PNG Image';
      case 'txt':
        return 'Text File';
      case 'doc':
        return 'Word Document';
      case 'docx':
        return 'Word Document';
      default:
        return 'File';
    }
  }

  // Validate file for upload
  static Future<FileValidationResult> validateFile(String filePath) async {
    // Check if file exists
    final file = File(filePath);
    if (!await file.exists()) {
      return FileValidationResult(
        isValid: false,
        errorMessage: 'File does not exist',
      );
    }

    // Check file type
    if (!isSupportedFileType(filePath)) {
      return FileValidationResult(
        isValid: false,
        errorMessage:
            'File type not supported. Supported types: ${AppConstants.supportedFileTypes.join(', ')}',
      );
    }

    // Check file size
    if (!await isFileSizeValid(filePath)) {
      int fileSize = await getFileSize(filePath);
      if (fileSize == 0) {
        return FileValidationResult(
          isValid: false,
          errorMessage: 'File is empty',
        );
      } else {
        return FileValidationResult(
          isValid: false,
          errorMessage:
              'File size exceeds ${formatFileSize(AppConstants.maxFileSize)} limit',
        );
      }
    }

    return FileValidationResult(isValid: true);
  }

  // Get file info for display
  static Future<FileInfo> getFileInfo(String filePath) async {
    final file = File(filePath);
    int size = 0;
    DateTime? lastModified;

    if (await file.exists()) {
      size = await file.length();
      lastModified = await file.lastModified();
    }

    return FileInfo(
      name: getFileName(filePath),
      path: filePath,
      size: size,
      sizeFormatted: formatFileSize(size),
      extension: getFileExtension(filePath),
      icon: getFileIcon(filePath),
      typeName: getFileTypeName(filePath),
      lastModified: lastModified,
    );
  }

  // Create placeholder file path (for simulation)
  static String createPlaceholderPath(String fileName) {
    return '/storage/documents/$fileName';
  }

  // Simulate file selection (for demo purposes)
  static Future<String?> simulateFileSelection() async {
    // This is a simulation - in real app, you'd use file_picker package
    await Future.delayed(Duration(milliseconds: 500));

    // Return a sample file path
    final sampleFiles = [
      'exam_schedule.pdf',
      'holiday_notice.jpg',
      'library_rules.txt',
      'sports_event.docx',
    ];

    final randomIndex = DateTime.now().millisecond % sampleFiles.length;
    return createPlaceholderPath(sampleFiles[randomIndex]);
  }
}

// File validation result class
class FileValidationResult {
  final bool isValid;
  final String? errorMessage;

  FileValidationResult({required this.isValid, this.errorMessage});
}

// File info class
class FileInfo {
  final String name;
  final String path;
  final int size;
  final String sizeFormatted;
  final String extension;
  final IconData icon;
  final String typeName;
  final DateTime? lastModified;

  FileInfo({
    required this.name,
    required this.path,
    required this.size,
    required this.sizeFormatted,
    required this.extension,
    required this.icon,
    required this.typeName,
    this.lastModified,
  });
}
