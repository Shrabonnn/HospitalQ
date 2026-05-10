import 'package:flutter/material.dart';
import 'package:hospital_q/model/doctor_model.dart';
import 'package:hospital_q/view_model/doctor_view_model.dart';
import 'package:provider/provider.dart';

// ── Data Model ─────────────────────────────────────────────────────────────

enum DeptStatus { open, paused, closed }


// ── Screen ─────────────────────────────────────────────────────────────────

class HospitalDepartmentScreen extends StatefulWidget {
  final String deptName;
  final String totalDoctor;
  final String departmentId;

  const HospitalDepartmentScreen({
    super.key, required this.deptName, required this.totalDoctor, required this.departmentId,
  });

  @override
  State<HospitalDepartmentScreen> createState() => _HospitalDepartmentScreenState();
}

class _HospitalDepartmentScreenState extends State<HospitalDepartmentScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask((){
      context.read<DoctorViewModel>().fetchDoctorsByDepartment(widget.departmentId);
    });
  }
  @override
  Widget build(BuildContext context) {


    final dvm = context.watch<DoctorViewModel>();
    dvm.fetchDoctorsByDepartment(widget.departmentId);


    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Top Bar ───────────────────────────────────────────────
            _buildTopBar(context),

            // ── Department List ───────────────────────────────────────
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(14, 14, 14, 30),
                physics: const BouncingScrollPhysics(),
                itemCount: dvm.doctors.length ,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  if (index == dvm.doctors.length) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                    );
                  }
                  return _DeptCard(dept: dvm.doctors[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(4, 10, 16, 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Back arrow
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              size: 18,
              color: Color(0xFF1A2E4A),
            ),
          ),

          // Title block
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hospital name (large, wraps to 2 lines like screenshot)
                  Expanded(
                    child: Text(
                      widget.deptName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF1A2E4A),
                        height: 1.15,
                        letterSpacing: -0.3,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // "X depts open today" on the right
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      '${widget.totalDoctor} doctors \non duty',
                      textAlign: TextAlign.right,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF94A3B8),
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Department Card ────────────────────────────────────────────────────────

class _DeptCard extends StatelessWidget {
  final DoctorModel dept;
  const _DeptCard({required this.dept});

  @override
  Widget build(BuildContext context) {
    final bool isOpen = dept.isAvailable == true;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.045),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isOpen ? () {} : null,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 14, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Name row ───────────────────────────────────────
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: dept.name,
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                                color: isOpen ? const Color(0xFF1A2E4A) : const Color(0xFFB0B8C1),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                    //_StatusBadge(status: dept.status),
                  ],
                ),

                const SizedBox(height: 3),

                // ── Doctor ─────────────────────────────────────────
                Text(
                  'Experience  · ${dept.experience} years'  ,
                  style: TextStyle(
                    fontSize: 12,
                    color: dept.isAvailable == false ? const Color(0xFFD97706) : const Color(0xFF94A3B8),
                    fontStyle: !isOpen ? FontStyle.italic : FontStyle.normal,
                  ),
                ),

                // ── Stats row (open only) ──────────────────────────
                if (isOpen) ...[
                  const SizedBox(height: 10),
                  const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _StatCol(label: 'Queue:', value: '${dept.totalPatientsToday}'),

                      const Spacer(),
                      _GetTokenButton(onTap: () {}),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Stat Column ────────────────────────────────────────────────────────────

class _StatCol extends StatelessWidget {
  final String label;
  final String value;
  const _StatCol({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
        ),
        const SizedBox(height: 1),
        Text(
          value,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A2E4A),
          ),
        ),
      ],
    );
  }
}

// ── Get Token Button ───────────────────────────────────────────────────────

class _GetTokenButton extends StatelessWidget {
  final VoidCallback onTap;
  const _GetTokenButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
        decoration: BoxDecoration(
          color: const Color(0xFF4F46E5),
          borderRadius: BorderRadius.circular(11),
        ),
        child: const Text(
          'Get token',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
    );
  }
}

// ── Status Badge ───────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final DeptStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (String label, Color bg, Color fg) = switch (status) {
      DeptStatus.open => (
      'Open',
      const Color(0xFFDCFCE7),
      const Color(0xFF16A34A),
      ),
      DeptStatus.paused => (
      'Paused',
      const Color(0xFFFFF7ED),
      const Color(0xFFD97706),
      ),
      DeptStatus.closed => (
      'Closed',
      const Color(0xFFF1F5F9),
      const Color(0xFF94A3B8),
      ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: fg,
        ),
      ),
    );
  }
}