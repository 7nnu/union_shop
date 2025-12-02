import 'package:flutter/material.dart';

class CustomFooter extends StatelessWidget {
  final String text;
  const CustomFooter({super.key, this.text = 'Placeholder Footer'});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.grey[50],
      padding: const EdgeInsets.all(24),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
