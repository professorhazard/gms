import 'package:flutter/material.dart';
import 'package:gms/auth.dart';
import 'package:gms/home_dashboard.dart';
import 'package:gms/auth_success.dart';
import 'package:gms/complaint.dart';
import 'package:gms/my_cases_screen.dart';
import 'package:gms/resolution_feedback.dart';
import 'package:gms/submission_confirmation.dart';
import 'package:rive/rive.dart';


Future<void> main()   async { 
  WidgetsFlutterBinding.ensureInitialized();
  
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
      initialRoute: '/auth',
      routes: {
        '/auth': (context) => const HomePage(), // Auth screen
        '/dashboard': (context) => const SecureHomeDashboard(),
        '/auth_success': (context) => const AuthSuccessScreen(),
        '/complaint': (context) => const Complaints(),
        '/confirmation': (context) => const SubmissionConfirmationScreen(),
        '/feedback': (context) => const ResolutionFeedbackScreen(caseId: 'GX-1024',),
        '/cases': (context) => const MyCasesScreen(),
      },
    );
  }
}
