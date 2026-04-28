import 'package:flutter/material.dart';

void main() {
  runApp(const LuminaApp());
}

class LuminaApp extends StatelessWidget {
  const LuminaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lumina Health',
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Inter',
        primaryColor: const Color(0xFF12639e),
      ),
      home: const AdmissionConfirmedScreen(),
    );
  }
}

class AdmissionConfirmedScreen extends StatelessWidget {
  const AdmissionConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    _buildSuccessSection(),
                    const SizedBox(height: 40),
                    _buildGrid(),
                    const SizedBox(height: 40),
                    _buildActions(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- APP BAR ----------------
  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xFF12639e)),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
          const Text(
            "Admission Confirmed",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF12639e),
            ),
          ),
          const Spacer(),
          const CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1607746882042-944635dfe10e"),
          )
        ],
      ),
    );
  }

  // ---------------- SUCCESS ----------------
  Widget _buildSuccessSection() {
    return Column(
      children: [
        Container(
          height: 120,
          width: 120,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [Color(0xFF12639e), Color(0xFF7FBDFF)],
            ),
          ),
          child: const Icon(Icons.check, color: Colors.white, size: 60),
        ),
        const SizedBox(height: 20),
        const Text(
          "Admission Complete",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        const Text(
          "Patient successfully transferred to Ward A.",
          textAlign: TextAlign.center,
        )
      ],
    );
  }

  // ---------------- GRID ----------------
  Widget _buildGrid() {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isMobile = constraints.maxWidth < 800;

        return isMobile
            ? Column(
                children: [
                  _patientCard(),
                  const SizedBox(height: 20),
                  _stepsCard(),
                ],
              )
            : Row(
                children: [
                  Expanded(child: _patientCard()),
                  const SizedBox(width: 20),
                  Expanded(child: _stepsCard()),
                ],
              );
      },
    );
  }

  // ---------------- PATIENT CARD ----------------
  Widget _patientCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardStyle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Patient Summary",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF12639e))),
          const SizedBox(height: 10),
          const Text("John Doe",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children: const [
              Chip(label: Text("ID: #LH-99203")),
              Chip(label: Text("DOB: 12/05/1978")),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(child: _infoBox(Icons.bed, "Rm 402 / Bed B")),
              const SizedBox(width: 10),
              Expanded(child: _infoBox(Icons.local_hospital, "Ward A")),
            ],
          )
        ],
      ),
    );
  }

  Widget _infoBox(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF4FF),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFF12639e)),
          const SizedBox(width: 8),
          Expanded(child: Text(text))
        ],
      ),
    );
  }

  // ---------------- STEPS ----------------
  Widget _stepsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: _cardStyle(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Next Steps",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _step(Icons.sync, "Vitals sync active", "Monitoring started"),
          _step(Icons.description, "Handover notes shared", "Staff notified"),
          _step(Icons.medication, "Pharmacy notified", "Medications queued"),
        ],
      ),
    );
  }

  Widget _step(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(icon, color: const Color(0xFF12639e)),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
              Text(subtitle, style: const TextStyle(fontSize: 12)),
            ],
          )
        ],
      ),
    );
  }

  // ---------------- ACTIONS ----------------
  Widget _buildActions() {
    return Column(
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF12639e),
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 40),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
          onPressed: () {},
          child: const Text("Finish & Go to Patient List"),
        ),
        TextButton(
          onPressed: () {},
          child: const Text("Print Admission Tags"),
        )
      ],
    );
  }

  // ---------------- DRAWER ----------------
  Widget _buildDrawer() {
    return Drawer(
      child: Column(
        children: const [
          DrawerHeader(
            child: Text("Dr. Julian Vance"),
          ),
          ListTile(title: Text("Dashboard")),
          ListTile(title: Text("Patient Records")),
          ListTile(title: Text("Admissions")),
          ListTile(title: Text("Schedule")),
          ListTile(title: Text("Settings")),
        ],
      ),
    );
  }

  // ---------------- COMMON STYLE ----------------
  BoxDecoration _cardStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 20,
        )
      ],
    );
  }
}