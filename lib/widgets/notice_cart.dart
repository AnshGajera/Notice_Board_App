import 'package:flutter/material.dart';
import '../models/notice.dart';
import '../models/category.dart';
import '../utils/constants.dart';

class NoticeCard extends StatelessWidget {
  final Notice notice;
  final VoidCallback? onTap;
  final bool showFullContent;

  const NoticeCard({
    Key? key,
    required this.notice,
    this.onTap,
    this.showFullContent = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppDimensions.smallSpacing,
      ),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        onTap:
            onTap ??
            () {
              // Navigate to detail screen - placeholder for now
              print('Notice tapped: ${notice.title}');
            },
        child: Padding(
          padding: EdgeInsets.all(AppConstants.cardPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: AppDimensions.mediumSpacing),
              _buildTitle(),
              SizedBox(height: AppDimensions.smallSpacing),
              _buildDescription(),
              if (notice.filePath != null) ...[
                SizedBox(height: AppDimensions.mediumSpacing),
                _buildAttachmentIndicator(),
              ],
              SizedBox(height: AppDimensions.mediumSpacing),
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [_buildCategoryBadge(), _buildDateText()],
    );
  }

  Widget _buildCategoryBadge() {
    final categoryColor = CategoryHelper.getCategoryColor(notice.category);
    final categoryIcon = CategoryHelper.getCategoryIcon(notice.category);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.smallSpacing,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: categoryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        border: Border.all(color: categoryColor.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(categoryIcon, size: 16, color: categoryColor),
          SizedBox(width: 4),
          Text(
            notice.category,
            style: TextStyle(
              color: categoryColor,
              fontSize: AppConstants.captionFontSize,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDateText() {
    return Text(
      notice.date,
      style: TextStyle(
        color: Colors.grey[600],
        fontSize: AppConstants.captionFontSize,
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      notice.title,
      style: TextStyle(
        fontSize: AppConstants.titleFontSize,
        fontWeight: FontWeight.bold,
        color: AppConstants.textColor,
      ),
      maxLines: showFullContent ? null : 2,
      overflow: showFullContent ? null : TextOverflow.ellipsis,
    );
  }

  Widget _buildDescription() {
    return Text(
      notice.description,
      style: TextStyle(
        fontSize: AppConstants.bodyFontSize,
        color: Colors.grey[700],
        height: 1.4,
      ),
      maxLines: showFullContent ? null : 3,
      overflow: showFullContent ? null : TextOverflow.ellipsis,
    );
  }

  Widget _buildAttachmentIndicator() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppDimensions.smallSpacing,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppConstants.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.attach_file, size: 16, color: AppConstants.primaryColor),
          SizedBox(width: 4),
          Text(
            'Attachment',
            style: TextStyle(
              color: AppConstants.primaryColor,
              fontSize: AppConstants.captionFontSize,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'ID: ${notice.id}',
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: AppConstants.captionFontSize,
          ),
        ),
        Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
      ],
    );
  }
}

class CompactNoticeCard extends StatelessWidget {
  final Notice notice;
  final VoidCallback? onTap;

  const CompactNoticeCard({Key? key, required this.notice, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: 4,
      ),
      elevation: 1,
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(
          horizontal: AppConstants.cardPadding,
          vertical: 8,
        ),
        onTap:
            onTap ??
            () {
              // Navigate to detail screen - placeholder for now
              print('Notice tapped: ${notice.title}');
            },
        leading: CircleAvatar(
          backgroundColor: CategoryHelper.getCategoryColor(
            notice.category,
          ).withOpacity(0.1),
          child: Icon(
            CategoryHelper.getCategoryIcon(notice.category),
            color: CategoryHelper.getCategoryColor(notice.category),
            size: 20,
          ),
        ),
        title: Text(
          notice.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: AppConstants.bodyFontSize,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notice.description,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: AppConstants.captionFontSize),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  notice.category,
                  style: TextStyle(
                    color: CategoryHelper.getCategoryColor(notice.category),
                    fontSize: AppConstants.captionFontSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(' • ', style: TextStyle(color: Colors.grey[400])),
                Text(
                  notice.date,
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: AppConstants.captionFontSize,
                  ),
                ),
              ],
            ),
          ],
        ),
        trailing: notice.filePath != null
            ? Icon(
                Icons.attach_file,
                color: AppConstants.primaryColor,
                size: 16,
              )
            : Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
      ),
    );
  }
}

class NoticeListCard extends StatelessWidget {
  final Notice notice;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool showActions;

  const NoticeListCard({
    Key? key,
    required this.notice,
    this.onTap,
    this.onEdit,
    this.onDelete,
    this.showActions = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(
        horizontal: AppConstants.defaultPadding,
        vertical: AppDimensions.smallSpacing,
      ),
      elevation: 1,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.all(AppConstants.cardPadding),
          child: Row(
            children: [
              _buildLeadingIcon(),
              SizedBox(width: AppDimensions.mediumSpacing),
              Expanded(child: _buildContent()),
              if (showActions) _buildActionButtons(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLeadingIcon() {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: CategoryHelper.getCategoryColor(
          notice.category,
        ).withOpacity(0.1),
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
      ),
      child: Icon(
        CategoryHelper.getCategoryIcon(notice.category),
        color: CategoryHelper.getCategoryColor(notice.category),
        size: 24,
      ),
    );
  }

  Widget _buildContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          notice.title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: AppConstants.bodyFontSize,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4),
        Text(
          notice.description,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: AppConstants.captionFontSize,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 8),
        Row(
          children: [
            _buildCategoryChip(),
            SizedBox(width: 8),
            Text(
              notice.date,
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: AppConstants.captionFontSize,
              ),
            ),
            if (notice.filePath != null) ...[
              SizedBox(width: 8),
              Icon(
                Icons.attach_file,
                size: 14,
                color: AppConstants.primaryColor,
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryChip() {
    final color = CategoryHelper.getCategoryColor(notice.category);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        notice.category,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (onEdit != null)
          IconButton(
            icon: Icon(Icons.edit, size: 20),
            onPressed: onEdit,
            tooltip: 'Edit',
          ),
        if (onDelete != null)
          IconButton(
            icon: Icon(Icons.delete, size: 20, color: AppConstants.errorColor),
            onPressed: onDelete,
            tooltip: 'Delete',
          ),
      ],
    );
  }
}
