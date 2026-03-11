import 'package:flutter/material.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBlue = Color(0xFF007BFF);
    const Color secondaryBlue = Color(0xFFE3F2FD);
    const Color textDark = Color(0xFF333333);
    const Color textGrey = Color(0xFF888888);
    const Color successGreen = Color(0xFFE8F5E9);
    const Color successTextGreen = Color(0xFF2E7D32);

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.grey[700],
                        size: 20,
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      "My Appointments",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 20),
                  ],
                ),

                const SizedBox(height: 25),

                // Tabs
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Upcoming",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: primaryBlue,
                            ),
                          ),
                          Container(
                            height: 3,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 8),
                            decoration: BoxDecoration(
                              color: primaryBlue,
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Past",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: textGrey,
                            ),
                          ),
                          Container(
                            height: 3,
                            width: double.infinity,
                            margin: const EdgeInsets.only(top: 8),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                const Text(
                  "NEXT APPOINTMENT",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textGrey,
                    letterSpacing: 1.0,
                  ),
                ),

                const SizedBox(height: 12),

                _buildAppointmentCard(
                  profileColor: Colors.pink[100]!,
                  profileIconColor: Colors.pink,
                  name: "Dr. Jane Smith",
                  specialty: "Cardiology",
                  date: "Oct 15, 2023",
                  time: "10:00 AM",
                  statusText: "Confirmed",
                  statusColor: successGreen,
                  statusTextColor: successTextGreen,
                ),

                const SizedBox(height: 15),

                _buildAppointmentCard(
                  profileColor: Colors.blue[100]!,
                  profileIconColor: Colors.blue,
                  name: "Dr. Michael Chen",
                  specialty: "General Practice",
                  date: "Dec 05, 2023",
                  time: "2:30 PM",
                  statusText: "Pending",
                  statusColor: secondaryBlue,
                  statusTextColor: primaryBlue,
                ),

                const SizedBox(height: 25),

                const Text(
                  "DECEMBER",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: textGrey,
                    letterSpacing: 1.0,
                  ),
                ),

                const SizedBox(height: 12),

                _buildAppointmentCard(
                  profileColor: Colors.orange[100]!,
                  profileIconColor: Colors.orange,
                  name: "Dr. Sarah Johnson",
                  specialty: "Dermatology",
                  date: "Dec 20, 2023",
                  time: "11:30 AM",
                  statusText: "Completed",
                  statusColor: const Color(0xFFF5F5F5),
                  statusTextColor: textGrey,
                ),

                const SizedBox(height: 25),

                // Nearest Clinic
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.grey[200]!),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          Icons.map_outlined,
                          color: Colors.red[400],
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Nearest Clinic",
                            style: TextStyle(
                              fontSize: 11,
                              color: textGrey,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            "City Health Hospital",
                            style: TextStyle(
                              fontSize: 14,
                              color: textDark,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Colors.grey,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),

                // Button
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/bookappoint');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      "Book New Appointment",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
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

  static Widget _buildAppointmentCard({
    required Color profileColor,
    required Color profileIconColor,
    required String name,
    required String specialty,
    required String date,
    required String time,
    required String statusText,
    required Color statusColor,
    required Color statusTextColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF007BFF).withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 26,
                backgroundColor: profileColor,
                child: Icon(Icons.person, color: profileIconColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF333333),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      specialty,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Divider(color: Colors.grey[200], height: 1),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        date,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF555555),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(Icons.access_time, size: 14, color: Colors.grey),
                      const SizedBox(width: 6),
                      Text(
                        time,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Color(0xFF555555),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    fontSize: 12,
                    color: statusTextColor,
                    fontWeight: FontWeight.w600,
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
