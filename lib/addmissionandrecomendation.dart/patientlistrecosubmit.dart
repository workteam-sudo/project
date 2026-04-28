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
      title: "Lumina Health",
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: "Inter",
        primaryColor: const Color(0xFF12639e),
      ),
      home: const PatientRegistryScreen(),
    );
  }
}

class PatientRegistryScreen extends StatelessWidget {
  const PatientRegistryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF12639e),
        onPressed: () {},
        child: const Icon(Icons.person_add),
      ),
      body: Row(
        children: [
          // Sidebar (Desktop-like)
          MediaQuery.of(context).size.width > 900
              ? SizedBox(width: 250, child: _buildDrawer())
              : const SizedBox(),

          // Main Content
          Expanded(
            child: Column(
              children: [
                _buildAppBar(context),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildSearch(),
                        const SizedBox(height: 20),
                        _buildFilters(),
                        const SizedBox(height: 20),
                        _buildStats(),
                        const SizedBox(height: 20),
                        _buildPatientList(),
                        const SizedBox(height: 30),
                        _buildFooter(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= APP BAR =================
  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      color: const Color(0xFFF8F9FA),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          const Text(
            "Patient Registry",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xFF12639e),
            ),
          ),
          const Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: const [
              Text("Dr. Julian Vance",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Text("Cardiology Unit",
                  style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(width: 10),
          const CircleAvatar(
            backgroundImage: NetworkImage(
                "https://images.unsplash.com/photo-1537368910025-700350fe46c7"),
          )
        ],
      ),
    );
  }

  // ================= DRAWER =================
  Widget _buildDrawer() {
    return Container(
      color: const Color(0xFFF1F4F5),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text("Menu",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),
          _drawerItem(Icons.group, "Patient List", true),
          _drawerItem(Icons.assignment_turned_in, "Clinical Tasks", false),
          _drawerItem(Icons.mail, "Messages", false),
          _drawerItem(Icons.settings, "Settings", false),
          const SizedBox(height: 40),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              "Active Shift\n14 patients under supervision",
              style: TextStyle(fontSize: 12),
            ),
          )
        ],
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, bool active) {
    return ListTile(
      leading: Icon(icon,
          color: active ? const Color(0xFF12639e) : Colors.grey),
      title: Text(title),
      tileColor:
          active ? const Color(0xFF12639e).withOpacity(0.1) : Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }

  // ================= SEARCH =================
  Widget _buildSearch() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Search patients...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: const Color(0xFFE5E9EB),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // ================= FILTERS =================
  Widget _buildFilters() {
    final filters = [
      "All Patients",
      "ICU",
      "Cardiology",
      "Neurology",
      "Pediatrics"
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters
            .map((e) => Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Chip(
                    label: Text(e),
                    backgroundColor: e == "All Patients"
                        ? const Color(0xFF12639e)
                        : Colors.grey[200],
                    labelStyle: TextStyle(
                        color:
                            e == "All Patients" ? Colors.white : Colors.black),
                  ),
                ))
            .toList(),
      ),
    );
  }

  // ================= STATS =================
  Widget _buildStats() {
    return Row(
      children: [
        Expanded(
          child: _statCard("Total", "42 Patients"),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _statCard("New", "+8 (24h)"),
        ),
      ],
    );
  }

  Widget _statCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 8),
          Text(value,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // ================= PATIENT LIST =================
  Widget _buildPatientList() {
    final patients = [
      ["Elena Belova", "Cardiology • 402-A", "Critical"],
      ["Jonathan Smith", "ICU • 102-B", "Stable"],
      ["Marcus Webb", "Neurology • 311", "Review"],
      ["Sarah Rogers", "Cardiology • 405", "Critical"],
      ["David Bowman", "Oncology • 512", "Stable"],
    ];

    return Column(
      children: patients
          .map((p) => _patientCard(p[0], p[1], p[2]))
          .toList(),
    );
  }

  Widget _patientCard(String name, String location, String status) {
    Color color;
    if (status == "Critical") {
      color = Colors.red;
    } else if (status == "Stable") {
      color = Colors.blue;
    } else {
      color = Colors.orange;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          CircleAvatar(child: Text(name[0])),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(fontWeight: FontWeight.bold)),
                Text(location,
                    style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(status, style: TextStyle(color: color)),
          )
        ],
      ),
    );
  }

  // ================= FOOTER =================
  Widget _buildFooter() {
    return Column(
      children: const [
        Divider(),
        Text("Capacity: 75%"),
        SizedBox(height: 5),
        Text("Last updated: 14:32",
            style: TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}