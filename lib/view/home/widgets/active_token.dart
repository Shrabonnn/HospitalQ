// ── Active Token Card ──────────────────────────────────────────────────────
import 'package:flutter/material.dart';

class ActiveTokenCard extends StatelessWidget {
  final int activeToken;
  final int servingNow;
  final int waitMinutes;
  final String department;
  final String hospitalShort;

  const ActiveTokenCard({
    required this.activeToken,
    required this.servingNow,
    required this.waitMinutes,
    required this.department,
    required this.hospitalShort,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 0),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF3730A3),
              Color(0xFF4F46E5),
              Color(0xFF6366F1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF4F46E5).withOpacity(0.38),
              blurRadius: 22,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'ACTIVE TOKEN',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.3,
                    ),
                  ),
                ),
                const Spacer(),
                const Icon(Icons.local_hospital_outlined,
                    color: Colors.white54, size: 16),
                const SizedBox(width: 5),
                Text(
                  '$department · $hospitalShort',
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Your token number
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Your Token',
                        style: TextStyle(color: Colors.white60, fontSize: 12)),
                    const SizedBox(height: 2),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Text('#',
                              style: TextStyle(
                                  color: Colors.white60,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300)),
                        ),
                        Text(
                          '$activeToken',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 56,
                            fontWeight: FontWeight.w800,
                            height: 1,
                            letterSpacing: -2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                    width: 1,
                    height: 64,
                    margin: const EdgeInsets.only(bottom: 4),
                    color: Colors.white24),
                const Spacer(),
                // Serving now + wait time
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text('Serving now',
                        style: TextStyle(color: Colors.white60, fontSize: 12)),
                    const SizedBox(height: 4),
                    Text(
                      '#$servingNow',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.access_time_rounded,
                              color: Colors.white70, size: 12),
                          const SizedBox(width: 4),
                          Text(
                            '~$waitMinutes min wait',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}