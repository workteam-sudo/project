import 'package:flutter/material.dart';

class PrescriptionsPage extends StatelessWidget {
  const PrescriptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Prescriptions",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.search, color: Colors.grey[400], size: 20),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        "Search by doctor or date",
                        style: TextStyle(color: Colors.grey[500], fontSize: 14),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Section Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "RECENT PRESCRIPTIONS",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Sort by Date",
                      style: TextStyle(
                        color: Color(0xFF4A90E2), // Soft Blue
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // List of Prescriptions
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3, // Showing 3 cards for demo
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  return PrescriptionCard(
                    doctorName: index == 0
                        ? "Dr. Sarah Jenkins"
                        : (index == 1 ? "Dr. Mark Thompson" : "Dr. Emily Chen"),
                    specialization: index == 0
                        ? "Cardiology Specialist"
                        : (index == 1
                              ? "General Practitioner"
                              : "Dermatologist"),
                    date: index == 0
                        ? "Oct 24, 2023"
                        : (index == 1 ? "Oct 20, 2023" : "Oct 15, 2023"),
                    medCount: index == 0 ? 3 : (index == 1 ? 1 : 5),
                    imageUrl: "https://i.pravatar.cc/150?img=${index + 1}",
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Custom Card Widget

class PrescriptionCard extends StatelessWidget {
  final String doctorName;
  final String specialization;
  final String date;
  final int medCount;
  final String imageUrl;

  const PrescriptionCard({
    super.key,
    required this.doctorName,
    required this.specialization,
    required this.date,
    required this.medCount,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
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
      ),
      child: Row(
        children: [
          // Doctor Profile Image
          CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(imageUrl),
            backgroundColor: Colors.grey[100],
          ),
          const SizedBox(width: 16),

          // Doctor Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doctorName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),

                Text(
                  specialization,
                  style: TextStyle(fontSize: 13, color: Colors.grey[500]),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      size: 14,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(width: 6),
                    Text(
                      date,
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        "$medCount Meds",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.blue[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // View Details Button
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/prescdetail');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4A90E2), // Soft Blue
              foregroundColor: Colors.white,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            ),
            child: const Text(
              "View Details",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}
