import 'package:flutter/material.dart';
import '../models/category.dart';
import '../utils/constants.dart';
import '../utils/file_helper.dart';
import '../widgets/file_upload_widget.dart';

class NoticeEntryScreen extends StatefulWidget {
  final Function(String, String, String) onNoticeAdded;

  NoticeEntryScreen({required this.onNoticeAdded});

  @override
  _NoticeEntryScreenState createState() => _NoticeEntryScreenState();
}

class _NoticeEntryScreenState extends State<NoticeEntryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String _selectedCategory = 'General';
  String? _selectedFilePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.addNoticeTitle),
        backgroundColor: AppConstants.primaryColor,
      ),
      body: Padding(
        padding: EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: EdgeInsets.all(AppConstants.defaultPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.noticeInformation,
                        style: TextStyle(
                          fontSize: AppConstants.titleFontSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: AppDimensions.largeSpacing),

                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: AppStrings.titleLabel,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.title),
                        ),
                        maxLength: AppConstants.maxTitleLength,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppConstants.titleRequiredMessage;
                          }
                          if (value.length > AppConstants.maxTitleLength) {
                            return AppConstants.titleTooLongMessage;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: AppDimensions.largeSpacing),

                      TextFormField(
                        controller: _descriptionController,
                        decoration: InputDecoration(
                          labelText: AppStrings.descriptionLabel,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.description),
                          alignLabelWithHint: true,
                        ),
                        maxLines: 4,
                        maxLength: AppConstants.maxDescriptionLength,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppConstants.descriptionRequiredMessage;
                          }
                          if (value.length >
                              AppConstants.maxDescriptionLength) {
                            return AppConstants.descriptionTooLongMessage;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: AppDimensions.largeSpacing),

                      DropdownButtonFormField<String>(
                        value: _selectedCategory,
                        decoration: InputDecoration(
                          labelText: AppStrings.categoryLabel,
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.category),
                        ),
                        items: CategoryHelper.getAllCategories()
                            .map(
                              (category) => DropdownMenuItem(
                                value: category,
                                child: Text(category),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedCategory = value!;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: AppDimensions.largeSpacing),

              FileUploadWidget(
                filePath: _selectedFilePath,
                onFileSelected: (filePath) {
                  setState(() {
                    _selectedFilePath = filePath;
                  });
                },
                label: AppStrings.attachFileLabel,
                isRequired: false,
              ),

              SizedBox(height: AppDimensions.extraLargeSpacing),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          widget.onNoticeAdded(
                            _titleController.text,
                            _descriptionController.text,
                            _selectedCategory,
                          );
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(AppConstants.noticeAddedMessage),
                            ),
                          );
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppConstants.cardPadding,
                        ),
                        child: Text(
                          AppStrings.addButton,
                          style: TextStyle(
                            fontSize: AppConstants.buttonFontSize,
                          ),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppConstants.primaryColor,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: AppDimensions.largeSpacing),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: AppConstants.cardPadding,
                        ),
                        child: Text(
                          AppStrings.cancelButton,
                          style: TextStyle(
                            fontSize: AppConstants.buttonFontSize,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
