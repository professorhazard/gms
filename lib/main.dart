import 'package:flutter/material.dart';
import 'package:gms/homepage.dart';
import 'package:gms/secure_home_dashboard.dart';
import 'package:gms/auth_success.dart';
import 'package:gms/complaint.dart';
import 'package:gms/submission_confirmation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TechCorp GMS',
      theme: ThemeData(
        fontFamily: 'Inter',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00B2D6)),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(), // Auth screen
        '/dashboard': (context) => const SecureHomeDashboard(),
        '/auth_success': (context) => const AuthSuccessScreen(),
        '/complaint': (context) => const Complaints(),
        '/confirmation': (context) => const SubmissionConfirmationScreen(),
      },
    );
  }
}
