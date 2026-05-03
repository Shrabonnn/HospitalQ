import 'package:flutter/material.dart';

class dividerWidget extends StatelessWidget {
  const dividerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(child: Divider(thickness: 1, color: Colors.white70)),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Text("OR", style: TextStyle(fontWeight: FontWeight.w500)),
        ),

        Expanded(child: Divider(thickness: 1, color: Colors.white70)),
      ],
    );
  }
}