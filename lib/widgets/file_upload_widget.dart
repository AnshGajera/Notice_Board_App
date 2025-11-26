import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../utils/file_helper.dart';

class FileUploadWidget extends StatelessWidget {
  final String? filePath;
  final Function(String?) onFileSelected;
  final String label;
  final bool isRequired;

  const FileUploadWidget({
    Key? key,
    required this.filePath,
    required this.onFileSelected,
    this.label = 'Select File',
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: AppConstants.bodyFontSize,
                fontWeight: FontWeight.w500,
                color: AppConstants.textColor,
              ),
            ),
            if (isRequired)
              Text(
                ' *',
                style: TextStyle(
                  color: AppConstants.errorColor,
                  fontSize: AppConstants.bodyFontSize,
                ),
              ),
          ],
        ),
        SizedBox(height: AppDimensions.smallSpacing),
        _buildFileUploadSection(context),
        if (filePath != null) SizedBox(height: AppDimensions.smallSpacing),
        if (filePath != null) _buildFileInfoSection(),
      ],
    );
  }

  Widget _buildFileUploadSection(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: filePath != null
              ? AppConstants.primaryColor
              : Colors.grey[300]!,
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        color: filePath != null
            ? AppConstants.primaryColor.withOpacity(0.05)
            : Colors.grey[50],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          onTap: () => _pickFile(context),
          child: Padding(
            padding: EdgeInsets.all(AppConstants.defaultPadding),
            child: Column(
              children: [
                Icon(
                  filePath != null ? Icons.check_circle : Icons.upload_file,
                  size: 48,
                  color: filePath != null
                      ? AppConstants.primaryColor
                      : Colors.grey[400],
                ),
                SizedBox(height: AppDimensions.smallSpacing),
                Text(
                  filePath != null ? 'File Selected' : 'Tap to select file',
                  style: TextStyle(
                    color: filePath != null
                        ? AppConstants.primaryColor
                        : Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontSize: AppConstants.bodyFontSize,
                  ),
                ),
                if (filePath == null)
                  Text(
                    'Supported: PDF, DOC, DOCX, TXT',
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: AppConstants.captionFontSize,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFileInfoSection() {
    if (filePath == null) return SizedBox.shrink();

    return FutureBuilder<FileInfo>(
      future: FileHelper.getFileInfo(filePath!),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container(
            padding: EdgeInsets.all(AppConstants.cardPadding),
            child: Row(
              children: [
                SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
                SizedBox(width: AppDimensions.mediumSpacing),
                Text('Loading file info...'),
              ],
            ),
          );
        }

        final fileInfo = snapshot.data!;
        return Container(
          padding: EdgeInsets.all(AppConstants.cardPadding),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              Icon(fileInfo.icon, color: AppConstants.primaryColor, size: 24),
              SizedBox(width: AppDimensions.mediumSpacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      fileInfo.name,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: AppConstants.bodyFontSize,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${fileInfo.sizeFormatted} • ${fileInfo.extension.toUpperCase()}',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: AppConstants.captionFontSize,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () => onFileSelected(null),
                icon: Icon(
                  Icons.close,
                  color: AppConstants.errorColor,
                  size: 20,
                ),
                tooltip: 'Remove file',
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickFile(BuildContext context) async {
    try {
      // Use FileHelper simulation for file selection
      final selectedFile = await FileHelper.simulateFileSelection();
      if (selectedFile != null) {
        final validationResult = await FileHelper.validateFile(selectedFile);
        if (validationResult.isValid) {
          onFileSelected(selectedFile);
        } else {
          _showErrorDialog(
            context,
            validationResult.errorMessage ?? 'Invalid file selected.',
          );
        }
      }
    } catch (e) {
      _showErrorDialog(context, 'Error selecting file: $e');
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }
}

class SimpleFileUploadWidget extends StatelessWidget {
  final String? filePath;
  final Function(String?) onFileSelected;

  const SimpleFileUploadWidget({
    Key? key,
    required this.filePath,
    required this.onFileSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FileUploadWidget(
      filePath: filePath,
      onFileSelected: onFileSelected,
      label: 'Attachment',
      isRequired: false,
    );
  }
}
