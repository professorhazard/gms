import 'package:flutter/material.dart';
import 'shared_ui.dart';

class ClassificationSection extends StatelessWidget {
  final String? selectedCategory;
  final ValueChanged<String?> onCategoryChanged;
  final String selectedSeriousness;
  final ValueChanged<String?> onSeriousnessChanged;

  const ClassificationSection({
    super.key,
    required this.selectedCategory,
    required this.onCategoryChanged,
    required this.selectedSeriousness,
    required this.onSeriousnessChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(icon: Icons.category, title: 'Classification'),
          const FormLabel('Grievance Category'),
          Container(
            decoration: inputDecoration,
            child: DropdownButtonFormField<String>(
              value: selectedCategory,
              hint: const Text('Select category'),
              isExpanded: true,
              icon: const Icon(Icons.unfold_more, color: primaryColor),
              decoration: textFieldDecoration,
              items: const [
                DropdownMenuItem(
                  value: 'harassment',
                  child: Text('Harassment / Bullying'),
                ),
                DropdownMenuItem(
                  value: 'safety',
                  child: Text('Workplace Safety'),
                ),
                DropdownMenuItem(
                  value: 'policy',
                  child: Text('Policy Violation'),
                ),
                DropdownMenuItem(
                  value: 'discrimination',
                  child: Text('Discrimination'),
                ),
                DropdownMenuItem(value: 'other', child: Text('Other')),
              ],
              onChanged: onCategoryChanged,
            ),
          ),
          const SizedBox(height: 16),
          const FormLabel('Seriousness Level'),
          Container(
            decoration: inputDecoration,
            child: DropdownButtonFormField<String>(
              value: selectedSeriousness,
              isExpanded: true,
              icon: const Icon(Icons.unfold_more, color: primaryColor),
              decoration: textFieldDecoration,
              items: const [
                DropdownMenuItem(
                  value: 'one',
                  child: Text('Low - Minor concern'),
                ),
                DropdownMenuItem(
                  value: 'two',
                  child: Text('Medium - Significant issue'),
                ),
                DropdownMenuItem(
                  value: 'three',
                  child: Text('High - Immediate action required'),
                ),
              ],
              onChanged: onSeriousnessChanged,
            ),
          ),
        ],
      ),
    );
  }
}
