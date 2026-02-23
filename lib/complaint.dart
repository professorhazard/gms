import 'package:flutter/material.dart';
import 'dart:ui';
import 'widgets/complaint_form/shared_ui.dart';
import 'widgets/complaint_form/classification_section.dart';
import 'widgets/complaint_form/incident_details_section.dart';
import 'widgets/complaint_form/involved_parties_section.dart';
import 'widgets/complaint_form/description_section.dart';
import 'widgets/complaint_form/evidence_upload_section.dart';
import 'widgets/complaint_form/complaint_bottom_actions.dart';

class Complaints extends StatefulWidget {
  const Complaints({super.key});

  @override
  State<Complaints> createState() => _ComplaintsState();
}

class _ComplaintsState extends State<Complaints> {
  // Form field values
  String? selectedCategory;
  String selectedSeriousness = 'two'; // Default to medium
  DateTime selectedDate = DateTime.parse('2023-11-20');
  TimeOfDay selectedTime = const TimeOfDay(hour: 14, minute: 30);
  TextEditingController locationController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  
  // Chips selection
  final List<String> involvedParties = [
    'Management',
    'HR Department',
    'Peer/Colleague',
    'External Client',
    'Subcontractor'
  ];
  final List<String> selectedParties = ['Management', 'Peer/Colleague'];
  
  // Evidence files
  final List<Map<String, dynamic>> uploadedFiles = [
    {
      'name': 'screenshot_incident.jpg',
      'size': '1.2 MB',
      'icon': Icons.image_outlined
    }
  ];
  
  @override
  void initState() {
    super.initState();
    locationController.addListener(() => setState(() {}));
    descriptionController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    locationController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  // Progress value
  double get progressValue {
    int totalFields = 5;
    int filledFields = 0;
    
    if (selectedCategory != null && selectedCategory!.isNotEmpty) filledFields++;
    if (locationController.text.trim().isNotEmpty) filledFields++;
    if (descriptionController.text.trim().isNotEmpty) filledFields++;
    if (selectedParties.isNotEmpty) filledFields++;
    if (uploadedFiles.isNotEmpty) filledFields++;
    
    return filledFields / totalFields;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      body: Stack(
        children: [
          // Background mesh effect (simulated with gradient)
          Positioned(
            top: -150,
            left: -150,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [primaryColor.withOpacity(0.15), Colors.transparent],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: -150,
            right: -150,
            child: Container(
              width: 500,
              height: 500,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [primaryColor.withOpacity(0.1), Colors.transparent],
                  stops: const [0.0, 1.0],
                ),
              ),
            ),
          ),
          
          SafeArea(
            bottom: false,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 448),
                child: Column(
                  children: [
                    // Top Navigation Bar (Sticky Glass Card)
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.7),
                            border: Border(
                              bottom: BorderSide(color: Colors.white.withOpacity(0.2)),
                            ),
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: textColor),
                                      visualDensity: VisualDensity.compact,
                                      style: IconButton.styleFrom(
                                        backgroundColor: Colors.black.withOpacity(0.05),
                                      ),
                                    ),
                                    const Expanded(
                                      child: Text(
                                        'New Grievance',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
                                      ),
                                    ),
                                    const SizedBox(width: 40), // Spacer for symmetry
                                  ],
                                ),
                              ),
                              // Progress Bar
                              Padding(
                                padding: const EdgeInsets.only(left: 24, right: 24, bottom: 16),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Submission Progress',
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: textColor.withOpacity(0.7)),
                                        ),
                                        Text(
                                          '${(progressValue * 100).toInt()}%',
                                          style: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: LinearProgressIndicator(
                                        value: progressValue,
                                        backgroundColor: primaryColor.withOpacity(0.2),
                                        valueColor: const AlwaysStoppedAnimation<Color>(primaryColor),
                                        minHeight: 6,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    // Scrollable Form Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 160),
                        child: Column(
                          children: [
                            ClassificationSection(
                              selectedCategory: selectedCategory,
                              onCategoryChanged: (value) {
                                setState(() {
                                  selectedCategory = value;
                                });
                              },
                              selectedSeriousness: selectedSeriousness,
                              onSeriousnessChanged: (value) {
                                if (value != null) {
                                  setState(() {
                                    selectedSeriousness = value;
                                  });
                                }
                              },
                            ),
                            
                            const SizedBox(height: 16),
                            
                            IncidentDetailsSection(
                              selectedDate: selectedDate,
                              onDateChanged: (value) {
                                setState(() {
                                  selectedDate = value;
                                });
                              },
                              selectedTime: selectedTime,
                              onTimeChanged: (value) {
                                setState(() {
                                  selectedTime = value;
                                });
                              },
                              locationController: locationController,
                            ),
                            
                            const SizedBox(height: 16),
                            
                            InvolvedPartiesSection(
                              involvedParties: involvedParties,
                              selectedParties: selectedParties,
                              onPartySelected: (selected, party) {
                                setState(() {
                                  if (selected) {
                                    selectedParties.add(party);
                                  } else {
                                    selectedParties.remove(party);
                                  }
                                });
                              },
                            ),
                            
                            const SizedBox(height: 16),
                            
                            DescriptionSection(
                              descriptionController: descriptionController,
                            ),
                            
                            const SizedBox(height: 16),
                            
                            EvidenceUploadSection(
                              uploadedFiles: uploadedFiles,
                              onUploadPressed: () {
                                // Handle file upload
                              },
                              onRemoveFile: (file) {
                                // Handle file removal
                              },
                            ),
                            
                            const SizedBox(height: 16),
                            
                            // Security Footer
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.lock_outline, size: 14, color: textColor.withOpacity(0.6)),
                                const SizedBox(width: 6),
                                Text(
                                  'SECURE & END-TO-END ENCRYPTED',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 1.2,
                                    color: textColor.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Fixed Bottom Actions
          ComplaintBottomActions(
            onSubmitAnonymously: () {
              // Handle anonymous submission
            },
            onSaveDraft: () {
              // Handle save draft
            },
          ),
        ],
      ),
    );
  }
}