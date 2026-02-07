import 'package:flutter/material.dart';
import 'package:gms/homepage.dart';

void main (){
  runApp(gms());
}
class gms extends StatefulWidget {
  const gms({super.key});

  @override
  State<gms> createState() => _gmsState();
}

class _gmsState extends State<gms> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}