import 'package:flutter/material.dart';

class BoldText extends StatelessWidget {
  final String title;
  const BoldText({
    super.key, required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Text(title,
      style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 20,
          color: Colors.white
      ),
    );
  }
}