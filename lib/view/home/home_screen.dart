// lib/views/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../model/hospital_model.dart';
import '../../view_model/home_view_model.dart';
import '../departments/hospital_department_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<HomeViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _GreetingHeader(
                greeting: vm.greeting,
                userName: vm.userName,
                hasNotification: vm.hasNotification,
                onNotificationTap: vm.clearNotification,
              ),
              _ActiveTokenCard(
                activeToken: vm.activeToken,
                servingNow: vm.servingNow,
                waitMinutes: vm.waitMinutes,
                department: vm.activeDepartment,
                hospitalShort: vm.activeHospitalShort,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(20, 26, 20, 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Hospitals nearby',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A2E4A),
                        letterSpacing: -0.3,
                      ),
                    ),
                    Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4F46E5),
                      ),
                    ),
                  ],
                ),
              ),
              _HospitalList(hospitals: vm.hospitals),
            ],
          ),
        ),
      ),
    );
  }
}

// ── Greeting Header ────────────────────────────────────────────────────────
class _GreetingHeader extends StatelessWidget {
  final String greeting;
  final String userName;
  final bool hasNotification;
  final VoidCallback onNotificationTap;

  const _GreetingHeader({
    required this.greeting,
    required this.userName,
    required this.hasNotification,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
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
        ],
      ),
    );
  }
}

// ── Active Token Card ──────────────────────────────────────────────────────
class _ActiveTokenCard extends StatelessWidget {
  final int activeToken;
  final int servingNow;
  final int waitMinutes;
  final String department;
  final String hospitalShort;

  const _ActiveTokenCard({
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

// ── Hospital List ──────────────────────────────────────────────────────────
class _HospitalList extends StatelessWidget {
  final List<HospitalModel> hospitals;
  const _HospitalList({required this.hospitals});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: hospitals.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final hospital = hospitals[index];
        return _HospitalCard(
          data: hospital,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HospitalDepartmentScreen(
                hospitalName: hospital.name,
                openDepts: hospital.departments,
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Hospital Card ──────────────────────────────────────────────────────────
class _HospitalCard extends StatelessWidget {
  final HospitalModel data;
  final VoidCallback onTap;
  const _HospitalCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: data.isOpen
                        ? const Color(0xFFEEF2FF)
                        : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    Icons.local_hospital_rounded,
                    color: data.isOpen
                        ? const Color(0xFF4F46E5)
                        : const Color(0xFF94A3B8),
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(data.name,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF1A2E4A),
                          )),
                      const SizedBox(height: 3),
                      Text(
                        '${data.address} · ${data.distance}',
                        style:
                        TextStyle(fontSize: 12, color: Colors.grey.shade400),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          _StatusBadge(isOpen: data.isOpen),
                          const SizedBox(width: 10),
                          Icon(Icons.apartment_rounded,
                              size: 12, color: Colors.grey.shade400),
                          const SizedBox(width: 3),
                          Text(
                            '${data.departments} departments',
                            style: TextStyle(
                                fontSize: 12, color: Colors.grey.shade400),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right_rounded,
                    color: Color(0xFFCBD5E1), size: 22),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Status Badge ───────────────────────────────────────────────────────────
class _StatusBadge extends StatelessWidget {
  final bool isOpen;
  const _StatusBadge({required this.isOpen});

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