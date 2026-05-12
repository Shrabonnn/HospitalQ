// ── Greeting Header ────────────────────────────────────────────────────────
import 'package:flutter/material.dart';
import 'package:hospital_q/data/services/auth_repository.dart';

import '../../../utils/routes/routes_name.dart';

class GreetingHeader extends StatelessWidget {
  final String greeting;
  final String userName;
  final bool hasNotification;
  final VoidCallback onNotificationTap;

  const GreetingHeader({
    required this.greeting,
    required this.userName,
    required this.hasNotification,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    final repository = AuthRepository();
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                greeting,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                userName,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A2E4A),
                  letterSpacing: -0.4,
                ),
              ),
            ],
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F0FF),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: IconButton(
                      onPressed: onNotificationTap,
                      icon: const Icon(
                        Icons.notifications_none,
                        size: 24,
                        color: Color(0xFF4F46E5),
                      ),
                    ),
                  ),
                  // Red dot — only shows when hasNotification is true
                  if (hasNotification)
                    Positioned(
                      top: 7,
                      right: 8,
                      child: Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFFEF4444),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 10,),
              IconButton(
                  onPressed: () async {
                  await repository.logout();
                  if(context.mounted){
                    Navigator.pushNamedAndRemoveUntil(
                        context,
                        RoutesName.splash_screen, // or your login route
                            (route) => false,);
                        }
              }, icon: Icon(Icons.logout))
            ],
          ),
        ],
      ),
    );
  }
}