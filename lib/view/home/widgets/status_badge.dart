// ── Status Badge ───────────────────────────────────────────────────────────
import 'package:flutter/material.dart';

class StatusBadge extends StatelessWidget {
  final bool isOpen;
  const StatusBadge({required this.isOpen});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
      decoration: BoxDecoration(
        color: isOpen ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        isOpen ? 'Open' : 'Closed today',
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: isOpen ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
        ),
      ),
    );
  }
}