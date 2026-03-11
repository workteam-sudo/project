import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PrescriptionDetailsScreen(),
    ),
  );
}

class PrescriptionDetailsScreen extends StatelessWidget {
  const PrescriptionDetailsScreen({super.key});

  // Define colors as class-level constants
  static const Color primaryBlue = Color(0xFF0056D2);
  static const Color softBlue = Color(0xFFF0F4FF);
  static const Color statusGreen = Color(0xFF28A745);
  static const Color statusGrey = Color(0xFF808080);
  static const Color textDark = Color(0xFF1A1A1A);
  static const Color textGrey = Color(0xFF666666);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // --- Top Section ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: textDark,
                      ),
                      onPressed: () {},
                    ),
                    const Text(
                      "Prescription Details",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.info_outline, color: textDark),
                      onPressed: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // --- Doctor Information Card ---
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: softBlue,
                        child: const Icon(
                          Icons.person,
                          color: primaryBlue,
                          size: 30,
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Doctor Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Dr. Sarah Jenkins",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: textDark,
                              ),
                            ),
                            const Text(
                              "Cardiology Specialist",
                              style: TextStyle(fontSize: 13, color: textGrey),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              children: [
                                const Icon(
                                  Icons.calendar_today,
                                  size: 14,
                                  color: textGrey,
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  "Oct 24, 2023",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: textGrey,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                const Icon(
                                  Icons.medical_services,
                                  size: 14,
                                  color: textGrey,
                                ),
                                const SizedBox(width: 6),
                                const Text(
                                  "3 Medications",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: textGrey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // --- Section Title ---
                const Text(
                  "PRESCRIBED MEDICATIONS",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: textGrey,
                    letterSpacing: 1.2,
                  ),
                ),
                const SizedBox(height: 20),

                // --- Medication List ---
                _buildMedicationCard(
                  name: "Lisinopril",
                  dosage: "10mg Oral Tablet",
                  status: "ACTIVE",
                  statusColor: statusGreen,
                  frequency: "Once daily",
                  instructions:
                      "Take in the morning with food. Do not skip doses.",
                  frequencyIcon: Icons.schedule,
                ),
                const SizedBox(height: 16),

                _buildMedicationCard(
                  name: "Atorvastatin",
                  dosage: "20mg Capsule",
                  status: null, // No status badge
                  statusColor: Colors.transparent,
                  frequency: "Every evening",
                  instructions: "Take before bed for maximum effectiveness.",
                  frequencyIcon: Icons.nightlight_round,
                ),
                const SizedBox(height: 16),

                _buildMedicationCard(
                  name: "Amoxicillin",
                  dosage: "500mg Capsule",
                  status: "COMPLETED",
                  statusColor: statusGrey,
                  frequency: "Every 8 hours",
                  instructions:
                      "Finish the full course even if you feel better.",
                  frequencyIcon: Icons.timer,
                ),
                const SizedBox(height: 40),

                // --- Bottom Action Button ---
                Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    color: primaryBlue,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: primaryBlue.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      "Request Refill",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper Widget for Medication Card
  Widget _buildMedicationCard({
    required String name,
    required String dosage,
    String? status,
    required Color statusColor, // Changed to non-nullable
    required String frequency,
    required String instructions,
    IconData? frequencyIcon,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Name and Status Badge
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dosage,
                      style: const TextStyle(fontSize: 14, color: textGrey),
                    ),
                  ],
                ),
              ),
              if (status != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    // Fixed: Using withValues instead of withOpacity
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          // Frequency Row
          Row(
            children: [
              Icon(frequencyIcon, size: 16, color: primaryBlue),
              const SizedBox(width: 8),
              Text(
                frequency,
                style: const TextStyle(
                  fontSize: 14,
                  color: textDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Instructions Row
          Row(
            children: [
              const Icon(Icons.notes, size: 16, color: textGrey),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  instructions,
                  style: const TextStyle(
                    fontSize: 13,
                    color: textGrey,
                    height: 1.4,
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
