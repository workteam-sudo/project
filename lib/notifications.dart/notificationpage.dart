import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () {},
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text(
              "Mark all as read",
              style: TextStyle(
                color: Color(0xFF007AFF),
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // NEW Section
              const Text(
                "NEW",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),

              // Notification 1: Prescription Ready
              _buildNotificationCard(
                icon: Icons.medication,
                iconColor: const Color(0xFF007AFF),
                title: "Prescription Ready",
                subtitle: "Patient: Jane Doe | 2m ago",
                isUnread: true,
              ),
              const SizedBox(height: 12),

              // Notification 2: Critical Lab Result
              _buildNotificationCard(
                icon: Icons.warning,
                iconColor: Colors.red,
                title: "Critical Lab Result",
                subtitle: "Patient ID: #8829 | 15m ago",
                isUnread: true,
              ),
              const SizedBox(height: 24),

              // EARLIER Section
              const Text(
                "EARLIER",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),

              // Notification 3: Appointment Reminder
              _buildNotificationCard(
                icon: Icons.calendar_today,
                iconColor: const Color(0xFF007AFF),
                title: "Appointment Reminder",
                subtitle: "Dr. Smith with Patient #102 | 2h ago",
                isUnread: false,
              ),
              const SizedBox(height: 12),

              // Notification 4: Payment Received
              _buildNotificationCard(
                icon: Icons.payment,
                iconColor: const Color(0xFF007AFF),
                title: "Payment Received",
                subtitle: "Invoice #INV-0921 | 4h ago",
                isUnread: false,
              ),
              const SizedBox(height: 12),

              // Notification 5: System Maintenance
              _buildNotificationCard(
                icon: Icons.settings,
                iconColor: const Color(0xFF007AFF),
                title: "System Maintenance",
                subtitle: "Scheduled for 02:00 AM",
                isUnread: false,
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    required bool isUnread,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 2,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey[100]!, width: 1),
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          const SizedBox(width: 16),

          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isUnread ? Colors.black87 : Colors.black54,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                ),
              ],
            ),
          ),

          // Unread Indicator
          if (isUnread)
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: const Color(0xFF007AFF),
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
