import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late AnimationController _scanController;

  final errorController = StreamController<ErrorAnimationType>.broadcast();

  bool _showFingerprint = true;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _scanController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true); // smooth back-and-forth scan

    _animationController.addStatusListener((status) {
      if (!mounted) return;

      if (status == AnimationStatus.completed) {
        setState(() {
          _showFingerprint = !_showFingerprint;
        });
        _animationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        setState(() => _isAnimating = false);
        _startPauseTimer();
      }
    });

    _startPauseTimer();
  }

  void _startPauseTimer() {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (mounted && !_isAnimating) {
        setState(() => _isAnimating = true);
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _scanController.dispose();
    errorController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 6, 177, 224),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(25),
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(255, 255, 255, 0.8),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 2, color: Colors.white30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(
                                    255,
                                    10,
                                    207,
                                    233,
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.asset(
                                    'lib/images/shield.png',
                                    height: 36,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              const Text(
                                'Authentication Required',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Text(
                                'Scan your employee QR code or enter the 6-digit token from your authenticator app.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(12, 26, 29, 0.7),
                                ),
                              ),
                              const SizedBox(height: 25),

                              // ─── SCANNER CONTAINER WITH SCAN LINE + CORNERS ───
                              Container(
                                constraints: const BoxConstraints(
                                  maxHeight: 200,
                                  maxWidth: 200,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                    width: 1,
                                    color: const Color.fromARGB(
                                      255,
                                      10,
                                      207,
                                      233,
                                    ),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Stack(
                                    children: [
                                      // Scanning line (moves top to bottom)
                                      AnimatedBuilder(
                                        animation: _scanController,
                                        builder: (context, child) {
                                          return Positioned(
                                            top:
                                                _scanController.value * 170 +
                                                15,
                                            left: 10,
                                            right: 10,
                                            child: Container(
                                              height: 4,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.cyan.withOpacity(
                                                      0.9,
                                                    ),
                                                    Colors.cyanAccent
                                                        .withOpacity(0.9),
                                                    Colors.cyan.withOpacity(
                                                      0.9,
                                                    ),
                                                    Colors.transparent,
                                                  ],
                                                  stops: const [
                                                    0.0,
                                                    0.2,
                                                    0.5,
                                                    0.8,
                                                    1.0,
                                                  ],
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.cyan
                                                        .withOpacity(0.5),
                                                    blurRadius: 10,
                                                    spreadRadius: 3,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),

                                      // Your original sliding icon
                                      AnimatedBuilder(
                                        animation: _animationController,
                                        builder: (context, child) {
                                          double offset = 0;

                                          if (_isAnimating) {
                                            if (_showFingerprint) {
                                              offset =
                                                  -200 *
                                                  _animationController.value;
                                            } else {
                                              offset =
                                                  200 *
                                                  _animationController.value;
                                            }
                                          }

                                          return Transform.translate(
                                            offset: Offset(offset, 0),
                                            child: SizedBox(
                                              width: 200,
                                              height: 200,
                                              child: Center(
                                                child: Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration:
                                                      const BoxDecoration(),
                                                  child: Icon(
                                                    _showFingerprint
                                                        ? Icons.fingerprint
                                                        : Icons.face,
                                                    size: 100,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),

                                      // Corner accents
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color: Color.fromARGB(
                                                  255,
                                                  10,
                                                  207,
                                                  233,
                                                ),
                                                width: 4,
                                              ),
                                              left: BorderSide(
                                                color: Color.fromARGB(
                                                  255,
                                                  10,
                                                  207,
                                                  233,
                                                ),
                                                width: 4,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color: Color.fromARGB(
                                                  255,
                                                  10,
                                                  207,
                                                  233,
                                                ),
                                                width: 4,
                                              ),
                                              right: BorderSide(
                                                color: Color.fromARGB(
                                                  255,
                                                  10,
                                                  207,
                                                  233,
                                                ),
                                                width: 4,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        left: 0,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Color.fromARGB(
                                                  255,
                                                  10,
                                                  207,
                                                  233,
                                                ),
                                                width: 4,
                                              ),
                                              left: BorderSide(
                                                color: Color.fromARGB(
                                                  255,
                                                  10,
                                                  207,
                                                  233,
                                                ),
                                                width: 4,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          width: 30,
                                          height: 30,
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Color.fromARGB(
                                                  255,
                                                  10,
                                                  207,
                                                  233,
                                                ),
                                                width: 4,
                                              ),
                                              right: BorderSide(
                                                color: Color.fromARGB(
                                                  255,
                                                  10,
                                                  207,
                                                  233,
                                                ),
                                                width: 4,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              const SizedBox(height: 25),
                              const Text(
                                'ENTER 6-DIGIT TOKEN',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Color.fromRGBO(12, 26, 29, 0.7),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 25),
                              PinCodeTextField(
                                appContext: context,
                                length: 6,
                                keyboardType: TextInputType.visiblePassword,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(r'[A-Z0-9]'),
                                  ),
                                ],
                                errorAnimationController: errorController,
                                onCompleted: (value) {
                                  if (value != "123456") {
                                    errorController.add(
                                      ErrorAnimationType.shake,
                                    );
                                  } else {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      '/auth_success',
                                    );
                                  }
                                },
                                cursorColor: Colors.blue,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.box,
                                  borderRadius: BorderRadius.circular(8),
                                  activeFillColor: Colors.white,
                                  inactiveFillColor: Colors.white.withOpacity(
                                    0.8,
                                  ),
                                  selectedFillColor: Colors.white,
                                  activeColor: Colors.cyan,
                                  selectedColor: Colors.cyan,
                                  inactiveColor: const Color.fromARGB(
                                    255,
                                    147,
                                    236,
                                    248,
                                  ),
                                ),
                                enableActiveFill: true,
                              ),
                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
