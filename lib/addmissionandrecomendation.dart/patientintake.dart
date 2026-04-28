import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math' as math;


class ClinicalSanctuaryApp extends StatelessWidget {
  const ClinicalSanctuaryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinical Sanctuary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8FAFC),
      ),
      home: const AdmissionDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AdmissionDashboard extends StatefulWidget {
  const AdmissionDashboard({super.key});

  @override
  State<AdmissionDashboard> createState() => _AdmissionDashboardState();
}

class _AdmissionDashboardState extends State<AdmissionDashboard>
    with TickerProviderStateMixin {
  String? selectedDepartment = 'Emergency';
  String? selectedTriage = 'Urgent';
  final TextEditingController _complaintController = TextEditingController();

  late AnimationController _blobController;
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _blobController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _blobController.dispose();
    _pulseController.dispose();
    _complaintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildBackgroundBlobs(),
          Row(
            children: [
              const SidebarNavigation(),
              Expanded(
                child: Column(
                  children: [
                    const TopHeader(),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(32),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildPageHeader(),
                            const SizedBox(height: 48),
                            _buildBentoGrid(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundBlobs() {
    return Stack(
      children: [
        Positioned(
          top: 120,
          right: 120,
          child: Container(
            width: 400,
            height: 400,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.withOpacity(0.08),
            ),
          ),
        ),
        Positioned(
          bottom: 120,
          left: 120,
          child: Container(
            width: 500,
            height: 500,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue.withOpacity(0.04),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPageHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        Text("Lumina Health > Direct Admission"),
        SizedBox(height: 20),
        Text(
          "Patient Admission Intake",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildBentoGrid() {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 36,
      mainAxisSpacing: 36,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.1,
      children: [
        _buildPatientIdentificationCard(),
        _buildAdmissionLogisticsCard(),
        _buildUrgencyTriageCard(),
        _buildSummaryActionCard(),
        _buildChiefComplaintCard(),
        _buildAlertCard(),
      ],
    );
  }

  Widget _buildPatientIdentificationCard() {
    return Container(
      color: Colors.white,
      child: const Center(child: Text("Patient Identification")),
    );
  }

  Widget _buildUrgencyTriageCard() {
    return Container(
      color: Colors.white,
      child: const Center(child: Text("Urgency Triage")),
    );
  }

  Widget _buildChiefComplaintCard() {
    return Container(
      color: Colors.white,
      child: const Center(child: Text("Chief Complaint")),
    );
  }

  // ✅ FIXED: Missing widgets (NO changes to your UI logic, just placeholders)

  Widget _buildAdmissionLogisticsCard() {
    return Container(
      color: Colors.white,
      child: const Center(child: Text("Admission Logistics")),
    );
  }

  Widget _buildSummaryActionCard() {
    return Container(
      color: Colors.white,
      child: const Center(child: Text("Summary Action")),
    );
  }

  Widget _buildAlertCard() {
    return Container(
      color: Colors.white,
      child: const Center(child: Text("Alert")),
    );
  }
}

// ✅ FIXED: Missing Sidebar
class SidebarNavigation extends StatelessWidget {
  const SidebarNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.white,
      child: const Center(child: Text("Sidebar")),
    );
  }
}

// ✅ FIXED: Missing TopHeader
class TopHeader extends StatelessWidget {
  const TopHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      color: Colors.white,
      child: const Center(child: Text("Top Header")),
    );
  }
}