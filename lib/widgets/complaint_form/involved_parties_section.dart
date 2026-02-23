import 'package:flutter/material.dart';
import 'shared_ui.dart';

class InvolvedPartiesSection extends StatelessWidget {
  final List<String> involvedParties;
  final List<String> selectedParties;
  final void Function(bool, String) onPartySelected;

  const InvolvedPartiesSection({
    super.key,
    required this.involvedParties,
    required this.selectedParties,
    required this.onPartySelected,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FormLabel('Who was involved? (Roles/Departments)'),
          Wrap(
              spacing: 8,
              runSpacing: 8,
              children: involvedParties.map((party) {
                final isSelected = selectedParties.contains(party);
                return GestureDetector(
                  onTap: () => onPartySelected(!isSelected, party),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? primaryColor.withOpacity(0.1)
                          : Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(
                        color: isSelected
                            ? primaryColor
                            : primaryColor.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          party,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w500,
                            color: isSelected ? primaryColor : textColor,
                          ),
                        ),
                        if (isSelected) ...[
                          const SizedBox(width: 4),
                          const Icon(Icons.check, size: 14, color: primaryColor),
                        ],
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      
    );
  }
}
