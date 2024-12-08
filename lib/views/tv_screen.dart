import 'package:flutter/material.dart';

class TVScreen extends StatefulWidget {
  const TVScreen({super.key});

  @override
  State<TVScreen> createState() => _TVScreenState();
}

class _TVScreenState extends State<TVScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('TV Channel',style: TextStyle(
        color: Colors.white,
      ),),
        backgroundColor: Colors.black,
      ),

    );;
  }
}
