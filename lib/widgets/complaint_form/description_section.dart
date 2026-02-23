import 'package:flutter/material.dart';
import 'shared_ui.dart';

class DescriptionSection extends StatelessWidget {
  final TextEditingController descriptionController;

  const DescriptionSection({super.key, required this.descriptionController});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeader(
            icon: Icons.description,
            title: 'Description',
            trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.05),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                '2500 CHAR LIMIT',
                style: TextStyle(
                  fontSize: 10,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Stack(
            children: [
              Container(
                decoration: inputDecoration,
                child: TextField(
                  controller: descriptionController,
                  maxLines: 8,
                  maxLength: 2500,
                  style: const TextStyle(height: 1.5),
                  buildCounter:
                      (
                        context, {
                        required currentLength,
                        required isFocused,
                        maxLength,
                      }) {
                        return const SizedBox.shrink(); // We build custom counter below
                      },
                  decoration: textFieldDecoration.copyWith(
                    hintText:
                        'Provide a detailed account of what happened. Be as specific as possible while maintaining your anonymity if desired...',
                  ),
                ),
              ),
              Positioned(
                bottom: 12,
                right: 12,
                child: AnimatedBuilder(
                  animation: descriptionController,
                  builder: (context, _) {
                    return Text(
                      '${descriptionController.text.length} / 2500',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
