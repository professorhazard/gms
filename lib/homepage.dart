import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showFirst = true;

  @override
  void initState() {
    super.initState();
    // Switch icon every 2 seconds
    Future.delayed(const Duration(seconds: 2), _switchIcon);
  }

  void _switchIcon() {
    setState(() {
      _showFirst = !_showFirst;
    });
    Future.delayed(const Duration(seconds: 2), _switchIcon);
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
                padding: EdgeInsets.all(25),
                child: Center(
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                      child: Container(
                        
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 255, 255, 0.8),
                          borderRadius: BorderRadius.circular(15),
                          border: Border.all(width: 2, color: Colors.white30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Column(
                            children: [
                              SizedBox(height: 10),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color.fromARGB(255, 10, 207, 233),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Image.asset(
                                    'lib/images/shield.png',
                                    height: 36,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Authentication Required',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Scan your employee QR code or enter the 6-digit token from your authenticstor app.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromRGBO(12, 26, 29, 0.7),
                                ),
                              ),
                              SizedBox(height: 25),
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: 200,
                                  maxWidth: 200,
                                ),
                                //add qr cod scanner here
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
                                  child: AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    transitionBuilder: (child, animation) {
                                      // Determine if child is the incoming or outgoing
                                      final isIncoming =
                                          child.key == ValueKey(_showFirst);
                            
                                      // Slide from right for incoming, slide left for outgoing
                                      final offsetAnimation = Tween<Offset>(
                                        begin: isIncoming
                                            ? const Offset(1, 0)
                                            : Offset.zero,
                                        end: isIncoming
                                            ? Offset.zero
                                            : const Offset(-1, 0),
                                      ).animate(animation);
                            
                                      return SlideTransition(
                                        position: offsetAnimation,
                                        child: child,
                                      );
                                    },
                                    child: Center(
                                      key: ValueKey(_showFirst),
                                      child: _showFirst
                                          ? const Icon(
                                              Icons.fingerprint,
                                              size: 60,
                                              color: Colors.blue,
                                            )
                                          : const Icon(
                                              Icons.check_circle,
                                              size: 60,
                                              color: Colors.green,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 25,),
                              Text('ENTER 6-DIGIT TOKEN',style: TextStyle(
                                 fontSize: 12,
                                  color: Color.fromRGBO(12, 26, 29, 0.7),
                                  fontWeight: FontWeight.bold
                              ),),
                              SizedBox(height: 25,),
                               Pinput(
                                length: 6,
                               ),
                               SizedBox(height: 25,),
                               ElevatedButton(onPressed: (){}, child: Text('Verfiy Identity'))
                            
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
