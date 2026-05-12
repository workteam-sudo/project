import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/appointments.dart/appointment_service.dart';
import 'package:flutter_application_1/authentication.dart/logout_helper.dart';
import 'package:flutter_application_1/widgets/drawer_profile_header.dart';

class DoctorDashboard extends StatelessWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F6FB),
      drawer: const DoctorSidebarMenu(),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              const SizedBox(height: 20),
              _buildWelcomeCard(context),
              const SizedBox(height: 25),
              _buildStatsRow(context),
              const SizedBox(height: 30),
              _buildTodayAppointments(context),
              const SizedBox(height: 30),
              _buildQuickActions(context),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Builder(
          builder: (context) => GestureDetector(
            onTap: () => Scaffold.of(context).openDrawer(),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.menu, color: Color(0xFF2E75B6)),
            ),
          ),
        ),
        const Text(
          "Doctor Dashboard",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => Navigator.pushNamed(context, '/notifications'),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: const Icon(Icons.notifications_none, color: Color(0xFF2C3E50)),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWelcomeCard(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: uid == null
          ? const Text('Not signed in')
          : StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(uid)
                  .snapshots(),
              builder: (context, snap) {
                final name = snap.data?.data()?['fullName'] as String? ?? 'Doctor';
                final shortId = uid.length > 6 ? uid.substring(0, 6) : uid;
                final displayName =
                    name.toLowerCase().startsWith('dr') ? name : 'Dr. $name';
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 35,
                      backgroundColor: const Color(0xFFE9F2FB),
                      child: Text(
                        name.isNotEmpty ? name[0].toUpperCase() : 'D',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2E75B6),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome, $displayName',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2C3E50),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'ID: #$shortId',
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF95A5A6),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFF27AE60).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "●",
                                  style: TextStyle(
                                    color: Color(0xFF27AE60),
                                    fontSize: 10,
                                  ),
                                ),
                                SizedBox(width: 5),
                                Text(
                                  "ONLINE",
                                  style: TextStyle(
                                    color: Color(0xFF27AE60),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) {
      return const SizedBox.shrink();
    }
    final svc = AppointmentService();
    return StreamBuilder<List<Appointment>>(
      stream: svc.watchDoctorAppointments(uid),
      builder: (context, snap) {
        final list = snap.data ?? const <Appointment>[];
        final today = AppointmentService.todayCountForDoctor(list, uid);
        final pending = AppointmentService.pendingCountForDoctor(list, uid);
        final week = list
            .where(
              (a) =>
                  a.doctorId == uid &&
                  a.scheduledAt.isAfter(
                    DateTime.now().subtract(const Duration(days: 7)),
                  ),
            )
            .length;
        return Row(
          children: [
            _buildStatCard(
              Icons.people,
              snap.hasData ? '$today' : '—',
              "Today's Patients",
              const Color(0xFF2E75B6),
            ),
            _buildStatCard(
              Icons.schedule,
              snap.hasData ? '$pending' : '—',
              "Pending Appointments",
              const Color(0xFFE74C3C),
            ),
            _buildStatCard(
              Icons.assignment,
              snap.hasData ? '$week' : '—',
              "Active (7 days)",
              const Color(0xFF27AE60),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard(
    IconData icon,
    String value,
    String label,
    Color color,
  ) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 10),
            Text(
              value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Color(0xFF2C3E50),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 11, color: Color(0xFF95A5A6)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTodayAppointments(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return const SizedBox.shrink();

    final svc = AppointmentService();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Today's Appointments",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF2C3E50),
              ),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.pushNamed(context, '/doctorappointments'),
              child: const Text('Manage all'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () =>
                Navigator.pushNamed(context, '/doctorappointments'),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: StreamBuilder<List<Appointment>>(
                stream: svc.watchDoctorAppointments(uid),
                builder: (context, snap) {
                  if (snap.hasError) {
                    return Text(
                      'Could not load: ${snap.error}',
                      style: const TextStyle(color: Colors.red, fontSize: 13),
                    );
                  }
                  if (!snap.hasData) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  final today = AppointmentService.todayForDoctor(
                    snap.data!,
                    uid,
                  );
                  if (today.isEmpty) {
                    return const Text(
                      'No appointments today. Tap to add or manage.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF95A5A6),
                      ),
                    );
                  }
                  return Column(
                    children: [
                      for (var i = 0; i < today.length; i++) ...[
                        if (i > 0) const Divider(height: 30),
                        _buildAppointmentRow(today[i]),
                      ],
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAppointmentRow(Appointment a) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF2E75B6).withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.schedule, color: Color(0xFF2E75B6), size: 20),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                a.patientName,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 15,
                  color: Color(0xFF2C3E50),
                ),
              ),
              Text(
                '${a.timeLabel} · ${a.status}',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF95A5A6),
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: const Color(0xFFE9F2FB),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            a.type,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF2E75B6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2C3E50),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                Icons.people,
                "Patient List",
                const Color(0xFF2E75B6),
                '/patientlist',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                context,
                Icons.medical_information,
                "Diagnosis",
                const Color(0xFF3498DB),
                '/diagnosis',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildActionCard(
                context,
                Icons.medication,
                "Prescription",
                const Color(0xFF27AE60),
                '/script.dart',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildActionCard(
                context,
                Icons.bedtime,
                "Admission",
                const Color(0xFFE74C3C),
                '/admissionrecommendation',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildActionCard(
    BuildContext context,
    IconData icon,
    String title,
    Color color,
    String route,
  ) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Color(0xFF2C3E50),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class DoctorSidebarMenu extends StatelessWidget {
  const DoctorSidebarMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 280,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
            decoration: const BoxDecoration(
              color: Color(0xFFF3F6FB),
              borderRadius: BorderRadius.only(topRight: Radius.circular(20)),
            ),
            child: const DrawerProfileHeader(roleLabel: 'Doctor'),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              children: [
                _buildMenuItem(
                  context,
                  Icons.event_note,
                  "Appointments",
                  '/doctorappointments',
                  isSelected: false,
                ),
                _buildMenuItem(
                  context,
                  Icons.people,
                  "Patient List",
                  '/patientlist',
                  isSelected: false,
                ),
                _buildMenuItem(
                  context,
                  Icons.medical_information,
                  "Diagnosis & Prescription",
                  '/diagnosis',
                ),
                _buildMenuItem(
                  context,
                  Icons.bedtime,
                  "Admission Recommendation",
                  '/admissionrecommendation',
                ),
                _buildMenuItem(
                  context,
                  Icons.analytics,
                  "Medical Records",
                  '/drmedicalrecords.dart',
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildMenuItem(
                  context,
                  Icons.settings,
                  "Settings",
                  '/settings',
                ),
                _buildMenuItem(
                  context,
                  Icons.logout,
                  "Logout",
                  '/logout',
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    IconData icon,
    String title,
    String route, {
    bool isSelected = false,
    Color? color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Material(
        color: isSelected ? const Color(0xFFE9F2FB) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pop(context);
            if (route == '/logout') {
              confirmAndSignOut(context);
            } else {
              Navigator.pushNamed(context, route);
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: isSelected
                      ? const Color(0xFF2E75B6)
                      : const Color(0xFF95A5A6),
                  size: 22,
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                      color: isSelected
                          ? const Color(0xFF2E75B6)
                          : (color ?? const Color(0xFF2C3E50)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
