import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 10, 207, 233),
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 15,sigmaY: 15),
                child: Container(
             constraints: BoxConstraints.expand(
              width:350,
              height: 500,
             ),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 255,255, 0.7),
                    borderRadius:BorderRadius.circular(15),
                    border: Border.all(width: 2,color:Colors.white30)
                     
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Column(
                          children: [
                            SizedBox(height: 10,),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color.fromARGB(255, 10, 207, 233)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Image.asset('lib/images/shield.png',height: 36,),
                              ),
                            ),
                            SizedBox(height: 10,),
                            Text('Authentication Required',style: TextStyle(
                              fontSize: 24,fontWeight:FontWeight.bold,
                            ),),
                            Text('Scan your employee QR code or enter the 6-digit token from your authenticstor app.',
                            textAlign: TextAlign.center,style: TextStyle(fontSize: 14, color: Color.fromRGBO(12,26,29,0.7)),
                            ),
                            SizedBox(height: 25,),
                            Container(
                              constraints: BoxConstraints(
                                maxHeight: 200,
                                maxWidth: 200,
                              ),
                              //add qr cod scanner here
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(width: 1,color:const Color.fromARGB(255, 10, 207, 233), )
                              ),
                              child:MobileScanner(
                                onDetect: (results){
                                  print(results.barcodes.first.rawValue);
                                },
                              ),
                            
                            )
                          ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}