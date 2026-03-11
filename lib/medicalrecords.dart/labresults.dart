import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LabResultsScreen extends StatelessWidget {
  const LabResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F8),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF007AFF),
        elevation: 4,
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: Colors.black87,
                    ),
                  ),
                  const Text(
                    "Medical Records",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1D1D1F),
                    ),
                  ),
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.search,
                      size: 20,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),

            // Tab Navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  _buildTab("Visits", isActive: false),
                  const SizedBox(width: 24),
                  _buildTab("Lab Results", isActive: true),
                  const SizedBox(width: 24),
                  _buildTab("Vaccines", isActive: false),
                ],
              ),
            ),

            // Content List
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
                children: const [
                  LabResultCard(
                    date: "NOV 02, 2023",
                    testName: "Complete Blood Count",
                    labName: "City Central Laboratory",
                    status: LabStatus.normal,
                  ),
                  LabResultCard(
                    date: "OCT 28, 2023",
                    testName: "Lipid Panel",
                    labName: "Metro Health Diagnostics",
                    status: LabStatus.actionRequired,
                  ),
                  LabResultCard(
                    date: "OCT 15, 2023",
                    testName: "Thyroid Stimulating Hormone",
                    labName: "City Central Laboratory",
                    status: LabStatus.normal,
                  ),
                  LabResultCard(
                    date: "SEP 30, 2023",
                    testName: "Vitamin D Test",
                    labName: "Premier Pathology Lab",
                    status: LabStatus.normal,
                  ),
                  SizedBox(height: 80),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTab(String text, {required bool isActive}) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
        color: isActive ? const Color(0xFF007AFF) : const Color(0xFF8E8E93),
      ),
    );
  }
}

enum LabStatus { normal, actionRequired }

class LabResultCard extends StatelessWidget {
  final String date;
  final String testName;
  final String labName;
  final LabStatus status;

  const LabResultCard({
    super.key,
    required this.date,
    required this.testName,
    required this.labName,
    required this.status,
  });

  Color getStatusColor() {
    switch (status) {
      case LabStatus.normal:
        return const Color(0xFF34C759);
      case LabStatus.actionRequired:
        return const Color(0xFFFF9500);
    }
  }

  String getStatusText() {
    switch (status) {
      case LabStatus.normal:
        return "Normal";
      case LabStatus.actionRequired:
        return "Action Required";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date and Status Row
            Row(
              children: [
                Text(
                  date,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF8E8E93),
                    letterSpacing: 0.5,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: getStatusColor().withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    getStatusText(),
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: getStatusColor(),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Test Name
            Text(
              testName,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1D1D1F),
              ),
            ),

            const SizedBox(height: 4),

            // Lab Name
            Text(
              labName,
              style: const TextStyle(fontSize: 14, color: Color(0xFF8E8E93)),
            ),

            const SizedBox(height: 16),

            // Action Buttons Row
            Row(
              children: [
                // View PDF Button
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF007AFF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.picture_as_pdf, size: 18, color: Colors.white),
                      SizedBox(width: 8),
                      Text(
                        "View PDF",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                // Details Text Button
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Details",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF007AFF),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
