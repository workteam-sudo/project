import 'package:flutter/material.dart';
import 'package:flutter_application_1/patientdash.dart/dashboard.dart';

class BookingConfirmedScreen extends StatelessWidget {
  const BookingConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF007BFF);
    const Color textDark = Color(0xFF333333);
    const Color textGrey = Color(0xFF888888);
    const Color successGreen = Color(0xFF28A745);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const SizedBox(height: 40),

                // 1. Success Icon
                Container(
                  width: 100,
                  height: 100,
                  decoration: const BoxDecoration(
                    color: Color(0xFFE8F5E9),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: successGreen,
                    size: 80,
                  ),
                ),

                const SizedBox(height: 30),

                // 2. Heading
                const Text(
                  "Appointment Successfully\nBooked!",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: textDark,
                    height: 1.4,
                  ),
                ),

                const SizedBox(height: 12),

                // 3. Subtext
                const Text(
                  "A confirmation email and SMS have been\nsent to the patient.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: textGrey, height: 1.5),
                ),

                const SizedBox(height: 40),

                // 4. Summary Card
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: primaryBlue.withOpacity(0.08),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                    border: Border.all(color: Colors.grey[100]!),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.pink[100],
                            child: const Icon(
                              Icons.person,
                              color: Colors.pink,
                              size: 32,
                            ),
                          ),
                          const SizedBox(width: 16),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dr. Sarah Johnson",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: textDark,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Cardiology Specialist",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: textGrey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Divider(color: Colors.grey[200], height: 1),
                      const SizedBox(height: 20),
                      _buildDetailRow(
                        icon: Icons.calendar_today_outlined,
                        label: "Date & Time",
                        value: "Oct 12, 2023 – 09:00 AM",
                      ),
                      const SizedBox(height: 16),
                      _buildDetailRow(
                        icon: Icons.location_on_outlined,
                        label: "Location",
                        value: "Cardiology Dept., Wing B",
                      ),
                      const SizedBox(height: 16),
                      _buildDetailRow(
                        icon: Icons.payment_outlined,
                        label: "Price",
                        value: "\$120.00 (Paid)",
                        valueColor: successGreen,
                      ),
                    ],
                  ),
                ),

                // const SizedBox(height: 50),

                // // 5. Add to Calendar Button
                // SizedBox(
                //   width: double.infinity,
                //   height: 55,
                //   child: ElevatedButton.icon(
                //     onPressed: () {},
                //     icon: const Icon(
                //       Icons.calendar_today,
                //       color: Colors.white,
                //       size: 20,
                //     ),
                //     label: const Text(
                //       "Add to Calendar",
                //       style: TextStyle(
                //         fontSize: 16,
                //         fontWeight: FontWeight.w600,
                //         color: Colors.white,
                //       ),
                //     ),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: primaryBlue,
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(16),
                //       ),
                //       elevation: 0,
                //     ),
                //   ),
                // ),
                const SizedBox(height: 16),

                TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientDashboard(),
                      ),
                      (route) => false,
                    );
                    // Password reset logic would go here
                  },
                  child: const Text(
                    "Go to Dashboard",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: textGrey,
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

  Widget _buildDetailRow({
    required IconData icon,
    required String label,
    required String value,
    Color? valueColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: Colors.grey[400]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey[500],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  color: valueColor ?? const Color(0xFF333333),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
