import 'package:flutter/material.dart';
import 'shared_ui.dart';

class EvidenceUploadSection extends StatelessWidget {
  final List<Map<String, dynamic>> uploadedFiles;
  final VoidCallback onUploadPressed;
  final void Function(Map<String, dynamic>) onRemoveFile;

  const EvidenceUploadSection({
    super.key,
    required this.uploadedFiles,
    required this.onUploadPressed,
    required this.onRemoveFile,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeader(
            icon: Icons.attachment,
            title: 'Evidence / Attachments',
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryColor.withOpacity(0.3),
                width: 2,
              ), // Dash border workaround typically requires custom painter, using solid for now to stay fast
              borderRadius: BorderRadius.circular(12),
              color: primaryColor.withOpacity(0.05),
            ),
            padding: const EdgeInsets.all(32),
            width: double.infinity,
            child: Column(
              children: [
                const Icon(Icons.cloud_upload, size: 40, color: primaryColor),
                const SizedBox(height: 8),
                const Text(
                  'Upload files or photos',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  'Supports PDF, JPG, PNG (Max 10MB each)',
                  style: TextStyle(
                    fontSize: 10,
                    color: textColor.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: onUploadPressed,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor.withOpacity(0.2),
                    foregroundColor: primaryColor,
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 8,
                    ),
                    elevation: 0,
                  ),
                  child: const Text(
                    'SELECT FILES',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          if (uploadedFiles.isNotEmpty) const SizedBox(height: 16),
          ...uploadedFiles.map(
            (file) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.white.withOpacity(0.4)),
              ),
              child: Row(
                children: [
                  Icon(file['icon'], color: primaryColor, size: 24),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          file['name'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                        Text(
                          file['size'],
                          style: TextStyle(
                            fontSize: 10,
                            color: textColor.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => onRemoveFile(file),
                    icon: const Icon(
                      Icons.close,
                      size: 14,
                      color: Colors.redAccent,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
