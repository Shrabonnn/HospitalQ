// lib/views/screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:hospital_q/model/department_model.dart';
import 'package:hospital_q/view/home/widgets/active_token.dart';
import 'package:hospital_q/view/home/widgets/greeting.dart';
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
              GreetingHeader(
                greeting: vm.greeting,
                userName: vm.userName,
                hasNotification: vm.hasNotification,
                onNotificationTap: vm.clearNotification,
              ),
              ActiveTokenCard(
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
              vm.isLoading ? const Center(
                child: CircularProgressIndicator(),
              ) : _DepartmentList(
                departments: vm.departments,
              ),
            ],
          ),
        ),
      ),
    );
  }
}





// ── Hospital List ──────────────────────────────────────────────────────────
class _DepartmentList extends StatelessWidget {
  final List<DepartmentModel> departments;
  const _DepartmentList({required this.departments});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: departments.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final department = departments[index];
        return _DepartmentCard(
          data: department,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HospitalDepartmentScreen(
                deptName: department.name,
                totalDoctor: department.totalDoctors.toString(),
                departmentId: department.id,
                //openDepts: hospital.departments,
              ),
            ),
          ),
        );
      },
    );
  }
}

// ── Hospital Card ──────────────────────────────────────────────────────────
class _DepartmentCard extends StatelessWidget {
  final DepartmentModel data;
  final VoidCallback onTap;
  const _DepartmentCard({required this.data, required this.onTap});

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

                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.apartment_rounded,
                              size: 12, color: Colors.grey.shade400),
                          const SizedBox(width: 3),
                          Text(
                            '${data.totalDoctors} doctors',
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

