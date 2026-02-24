import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:gms/complaint.dart';
import 'package:gms/secure_dashcontent.dart';
import 'package:gms/my_cases_screen.dart';
import 'widgets/complaint_form/shared_ui.dart';

class SecureHomeDashboard extends StatefulWidget {
  const SecureHomeDashboard({super.key});

  @override
  State<SecureHomeDashboard> createState() => _SecureHomeDashboardState();
}

class _SecureHomeDashboardState extends State<SecureHomeDashboard> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    final pages = [
      const SecureDashcontent(),
      Complaints(
        onBack: () {
          setState(() {
            selected = 0;
          });
        },
      ),
      const MyCasesScreen(),
      Container(), // For Support (placeholder to avoid range error)
    ];

    return Scaffold(
      backgroundColor: backgroundLight,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          pages[selected],
          // Bottom Navigation
          Align(
            alignment: Alignment.bottomCenter,
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 430),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  border: Border(
                    top: BorderSide(color: Colors.black.withOpacity(0.05)),
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8, bottom: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildNavItem(Icons.home, 'Home', selected==0?true:false,0),
                        _buildNavItem(
                          Icons.add_circle_outline,
                          'New Report',
                          selected==1?true:false,1
                        ),
                        _buildNavItem(
                          Icons.folder_shared_outlined,
                          'My Cases',
                          selected==2?true:false,2
                        ),
                        _buildNavItem(
                          Icons.help_center_outlined,
                          'Support',
                          selected==3?true:false,3
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, bool isSelected, int id) {
    final color = isSelected ? primaryColor : Colors.black45;
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            setState(() {
              selected = id;
            });
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 32,
                child: Center(child: Icon(icon, color: color, size: 24)),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  color: color,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
