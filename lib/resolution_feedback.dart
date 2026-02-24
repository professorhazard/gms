import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:gms/widgets/complaint_form/shared_ui.dart';

class ResolutionFeedbackScreen extends StatefulWidget {
  final String caseId;

  const ResolutionFeedbackScreen({
    super.key,
    required this.caseId,
  });

  @override
  State<ResolutionFeedbackScreen> createState() =>
      _ResolutionFeedbackScreenState();
}

class _ResolutionFeedbackScreenState
    extends State<ResolutionFeedbackScreen> {
  int rating = 4;
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundLight,
      // keep content within a constrained width for large screens
      body: Stack(
        children: [
          // background gradient similar to design
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFF7FAFC), Color(0xFFEDF2F7)],
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 430),
                child: Column(
                  children: [
                              _buildHeader(context),
                    Expanded(child: _buildContent(context)),
                  ],
                ),
              ),
            ),
          ),
          // send response button pinned
          Positioned(
            left: 0,
            right: 0,
            bottom: 92,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 6,
                  ),
                  onPressed: () {
                    // for now just pop with feedback
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Feedback sent')),
                    );
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text('Send Response', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(width: 8),
                      Icon(Icons.send, size: 18)
                    ],
                  ),
                ),
              ),
            ),
          ),
          // bottom navigation bar (reused from home_dashboard)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                border: Border(top: BorderSide(color: Colors.black.withOpacity(0.05))),
              ),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _navItem(context, Icons.home, 'Home', false),
                      _navItem(context, Icons.add_circle_outline, 'New Report', false),
                      _navItem(context, Icons.folder_shared_outlined, 'My Cases', true),
                      _navItem(context, Icons.help_center_outlined, 'Support', false),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(BuildContext context, IconData icon, String label, bool selected) {
    final color = selected ? primaryColor : Colors.black45;
    return Expanded(
      child: InkWell(
        onTap: () {
          switch (label) {
            case 'Home':
              Navigator.pushNamedAndRemoveUntil(context, '/dashboard', (r) => false);
              break;
            case 'New Report':
              Navigator.pushNamed(context, '/complaint');
              break;
            case 'My Cases':
              // already here, maybe just pop until current
              Navigator.popUntil(context, (route) => route.isFirst);
              break;
            case 'Support':
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Support coming soon')));
              break;
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 32, child: Center(child: Icon(icon, color: color, size: 24))),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.05))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          InkWell(
            onTap: () => Navigator.pop(context),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(Icons.arrow_back_ios, size: 20, color: Colors.grey),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Resolution Feedback',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  'Case ID: ${widget.caseId}',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: primaryColor),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_horiz, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Case resolution section
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Case Resolution'.toUpperCase(),
                style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey[600], letterSpacing: 0.5),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // verdict card
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.lock, size: 14, color: Colors.grey),
                        SizedBox(width: 4),
                        Text('Read Only', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.grey)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Final Verdict Decision',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'The HR committee has concluded the review of your resource allocation grievance. We have approved an immediate 15% budget increase and authorized two additional headcounts for your department effective next quarter.',
                  style: TextStyle(fontSize: 14, height: 1.4, color: Colors.black87),
                ),
                const SizedBox(height: 12),
                Divider(color: Colors.grey[200]),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.attachment, size: 18, color: primaryColor),
                      label: const Text('View Official Document', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: primaryColor)),
                    ),
                    Text('Oct 24, 10:42 AM', style: TextStyle(fontSize: 10, color: Colors.grey[500])),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Feedback form
          GlassCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Your Feedback', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                const Text('Please share your perspective on the resolution provided by the committee.',
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
                const SizedBox(height: 16),
                // quality label and current
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Resolution Quality', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey[600])),
                    Text(_qualityLabel(), style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: primaryColor)),
                  ],
                ),
                const SizedBox(height: 8),
                // stars
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(5, (index) {
                    final filled = index < rating;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          rating = index + 1;
                        });
                      },
                      child: Icon(
                        Icons.star,
                        size: 40,
                        color: filled ? primaryColor : Colors.grey[300],
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 4),
                // labels
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text('Poor', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    Text('Excellent', style: TextStyle(fontSize: 10, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 16),
                // comments
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Detailed Comments', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey[600])),
                    const Text('Optional', style: TextStyle(fontSize: 10, fontStyle: FontStyle.italic, color: Colors.grey)),
                  ],
                ),
                const SizedBox(height: 4),
                Stack(
                  children: [
                    TextField(
                      controller: controller,
                      maxLines: 5,
                      maxLength: 1000,
                      decoration: InputDecoration(
                        hintText: 'Tell us more about what you liked or what could be improved...',
                        filled: true,
                        fillColor: Colors.grey[50],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.all(16),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 16,
                      child: Text(
                        '${controller.text.length}/1000',
                        style: const TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your input helps us refine the grievance process. Be as specific as possible.',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // encryption notice
          Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.green[50],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.green[100]!),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(Icons.lock, size: 14, color: Colors.green),
                        SizedBox(width: 4),
                        Text('End-to-End Encrypted', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.green)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Your identity remains anonymous and this feedback is stored securely.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 11, color: Colors.grey),
              ),
            ],
          ),
          const SizedBox(height: 120), // space for button
        ],
      ),
    );
  }

  String _qualityLabel() {
    switch (rating) {
      case 1:
        return 'Very Dissatisfied';
      case 2:
        return 'Dissatisfied';
      case 3:
        return 'Neutral';
      case 4:
        return 'Very Satisfied';
      case 5:
        return 'Excellent';
      default:
        return '';
    }
  }
}