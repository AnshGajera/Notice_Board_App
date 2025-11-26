import 'package:flutter/material.dart';
import '../models/category.dart';
import '../utils/constants.dart';

class CategoryFilter extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;
  final List<String> categories;

  const CategoryFilter({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
    required this.categories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.filterChipHeight + 10,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return _buildFilterChip(category);
        },
      ),
    );
  }

  Widget _buildFilterChip(String category) {
    final isSelected = selectedCategory == category;
    return Container(
      margin: EdgeInsets.only(right: AppDimensions.filterChipSpacing),
      child: FilterChip(
        label: Text(category),
        selected: isSelected,
        onSelected: (selected) {
          onCategorySelected(category);
        },
        backgroundColor: Colors.grey[200],
        selectedColor: _getCategoryColor(category),
        labelStyle: TextStyle(
          color: isSelected ? Colors.white : AppConstants.textColor,
          fontSize: AppConstants.bodyFontSize,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: AppConstants.cardPadding,
          vertical: AppDimensions.smallSpacing,
        ),
        elevation: isSelected ? 2 : 0,
        pressElevation: 1,
      ),
    );
  }

  Color _getCategoryColor(String category) {
    if (category == 'All') {
      return AppConstants.primaryColor;
    }
    return CategoryHelper.getCategoryColor(category);
  }
}

class CategoryFilterHorizontal extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryFilterHorizontal({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoryFilter(
      selectedCategory: selectedCategory,
      onCategorySelected: onCategorySelected,
      categories: AppConstants.categories,
    );
  }
}

class CategoryFilterGrid extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryFilterGrid({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppDimensions.mediumSpacing,
      runSpacing: AppDimensions.mediumSpacing,
      children: AppConstants.categories.map((category) {
        final isSelected = selectedCategory == category;
        return FilterChip(
          label: Text(category),
          selected: isSelected,
          onSelected: (selected) {
            onCategorySelected(category);
          },
          backgroundColor: Colors.grey[200],
          selectedColor: _getCategoryColor(category),
          labelStyle: TextStyle(
            color: isSelected ? Colors.white : AppConstants.textColor,
            fontSize: AppConstants.bodyFontSize,
          ),
        );
      }).toList(),
    );
  }

  Color _getCategoryColor(String category) {
    if (category == 'All') {
      return AppConstants.primaryColor;
    }
    return CategoryHelper.getCategoryColor(category);
  }
}
