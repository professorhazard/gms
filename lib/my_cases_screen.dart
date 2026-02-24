import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gms/resolution_feedback.dart';
import 'package:gms/widgets/complaint_form/shared_ui.dart';

class MyCasesScreen extends StatelessWidget {
  const MyCasesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background mesh effect
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
                constraints: const BoxConstraints(maxWidth: 430),
                child: Column(
                  children: [
                    // App Bar
                    ClipRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.85),
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.white.withOpacity(0.2),
                              ),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 6,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(width: 40), // Spacer left
                              const Expanded(
                                child: Text(
                                  'My Cases',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: textColor,
                                    letterSpacing: -0.5,
                                  ),
                                ),
                              ),
                              Material(
                                color: Colors.transparent,
                                shape: const CircleBorder(),
                                clipBehavior: Clip.hardEdge,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    alignment: Alignment.center,
                                    child: const Icon(
                                      Icons.filter_list,
                                      size: 24,
                                      color: textColor,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
      
                    // Content
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 16,
                          top: 16,
                          bottom: 96,
                        ),
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            _buildCaseCard(
                              context: context,
                              id: 'GMS-8821',
                              date: 'Nov 20, 2023',
                              status: 'In Review',
                              statusColor: Colors.amber,
                              isExpanded: true,
                              step:
                                  1, // 0: Submission, 1: Investigation, 2: Resolution
                              response:
                                  'Response will appear here once review is done.',
                              isResponseDimmed: true,
                            ),
                            const SizedBox(height: 16),
                            _buildCaseCard(
                              context: context,
                              id: 'GMS-8790',
                              date: 'Nov 14, 2023',
                              status: 'Completed',
                              statusColor: Colors.green,
                              isExpanded: false,
                              step: 3,
                              response:
                                  'The internal investigation has concluded. Remedial actions have been implemented as per company policy section 4.2. Please acknowledge the resolution.',
                              isResponseDimmed: false,
                            ),
                            const SizedBox(height: 16),
                            _buildCaseCard(
                              context: context,
                              id: 'GMS-8902',
                              date: 'Dec 01, 2023',
                              status: 'Pending',
                              statusColor: Colors.blueGrey,
                              isExpanded: false,
                              step: 0,
                              response:
                                  'Case is currently being assigned to an investigator.',
                              isResponseDimmed: true,
                            ),
                            const SizedBox(height: 32),
                            // Footer note
                            Opacity(
                              opacity: 0.4,
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons.lock, size: 14),
                                      SizedBox(width: 6),
                                      Text(
                                        'SECURE & END-TO-END ENCRYPTED',
                                        style: TextStyle(
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.2,
                                          color: textColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  const Text(
                                    'GMS v2.4.0 • Enterprise Edition',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.w500,
                                      color: textColor,
                                    ),
                                  ),
                                ],
                              ),
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
        ],
      ),
    );
  }

  Widget _buildCaseCard({
    required BuildContext context,
    required String id,
    required String date,
    required String status,
    required MaterialColor statusColor,
    required bool isExpanded,
    required int step,
    required String response,
    required bool isResponseDimmed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.6)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          initiallyExpanded: isExpanded,
          childrenPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    id,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: textColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor.shade50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: statusColor.shade200),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    color: statusColor.shade700,
                  ),
                ),
              ),
            ],
          ),
          children: [
            // Progress Bar
            Padding(
              padding: const EdgeInsets.only(top: 8, bottom: 24),
              child: Stack(
                children: [
                  // Connecting lines
                  Positioned(
                    top: 15,
                    left: 40,
                    right: 40,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 2,
                            color: step >= 1
                                ? primaryColor
                                : Colors.grey.shade300,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 2,
                            color: step >= 2
                                ? primaryColor
                                : Colors.grey.shade300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildProgressStep(
                        icon: step > 0 ? Icons.check : Icons.send,
                        label: 'Submission',
                        isActive: true,
                        isCurrent: step == 0,
                      ),
                      _buildProgressStep(
                        icon: step > 1 ? Icons.check : Icons.search,
                        label: 'Investigation',
                        isActive: step >= 1,
                        isCurrent: step == 1,
                      ),
                      _buildProgressStep(
                        icon: step > 2 ? Icons.check : Icons.gavel,
                        label: 'Resolution',
                        isActive: step >= 2,
                        isCurrent: step == 2,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Organization Response Box
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white.withOpacity(0.6)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'ORGANIZATION RESPONSE',
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: textColor.withOpacity(0.4),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    response,
                    style: TextStyle(
                      fontSize: 12,
                      color: isResponseDimmed
                          ? Colors.blueGrey.shade500
                          : textColor,
                      fontStyle: isResponseDimmed
                          ? FontStyle.italic
                          : FontStyle.normal,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Action Button
            ElevatedButton.icon(
              onPressed: step == 3
                  ? () {
                      Navigator.push(context,
                        MaterialPageRoute(
                          builder: (context) => ResolutionFeedbackScreen(
                            caseId: id,
                          ),
                        ),
                      );
                    }
                  : null, // Only enabled if completed
              style: ElevatedButton.styleFrom(
                backgroundColor: step == 3
                    ? primaryColor
                    : Colors.grey.shade200,
                foregroundColor: step == 3
                    ? Colors.white
                    : Colors.grey.shade400,
                disabledBackgroundColor: Colors.grey.shade200,
                disabledForegroundColor: Colors.grey.shade400,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: step == 3 ? 4 : 0,
              ),
              icon: Icon(
                Icons.reply,
                size: 18,
                color: step == 3 ? Colors.white : Colors.grey.shade400,
              ),
              label: const Text(
                'Respond to Review',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStep({
    required IconData icon,
    required String label,
    required bool isActive,
    required bool isCurrent,
  }) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive ? primaryColor : Colors.grey.shade100,
            shape: BoxShape.circle,
            border: isCurrent
                ? Border.all(color: Colors.white, width: 4)
                : const Border.fromBorderSide(BorderSide.none),
            boxShadow: isCurrent
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                    ),
                  ]
                : null,
          ),
          child: Center(
            child: Icon(
              icon,
              size: 16,
              color: isActive ? Colors.white : Colors.grey.shade400,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 9,
            fontWeight: FontWeight.bold,
            color: isCurrent
                ? primaryColor
                : textColor.withOpacity(isActive ? 0.6 : 0.3),
          ),
        ),
      ],
    );
  }
}
