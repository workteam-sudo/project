import 'package:flutter/material.dart';

class LabResultsScreen extends StatelessWidget {
  const LabResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),

      // 🔷 App Bar
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF12639E)),
          onPressed: () {},
        ),
        title: const Text(
          "Lab Results",
          style: TextStyle(
            color: Color(0xFF12639E),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          const CircleAvatar(
            backgroundImage: NetworkImage(
              "https://lh3.googleusercontent.com/aida-public/AB6AXuAy7dAvlCtBvMelD11T8lfFei0jaNnQP6WtiAOB5gjnFwGKdkEyHC-qXnuArHvHZrt297klq8eHHugVVAk3zvYjpxtxfx3kVb3E7EWY06RowrJsE4CyjbEkDK6OzmaB7EG9FcLF8TwMLrvgF3MR0b-RZgj4sxFHk-dQJaoUc4ZtPTF-1wZyPGWJunZZh4x1uvTBpCD2aeITjbwTTQFGQ-KssFjkpIu7KYWp6Din41G26J3TwYTm2n1StvtajC5M4bbwLCjzCTWk19M",
            ),
          ),
          const SizedBox(width: 12)
        ],
      ),

      // 🔷 Body
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [

            /// 🔹 Patient Summary
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardStyle(),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      "https://lh3.googleusercontent.com/aida-public/AB6AXuB5rdlUig5sVgbAcTCgJ6znRDbOYhRVtVfhHSGt9fE6bb3Uf6XtMIF8gOUZzPBRUyKv6wGvi0MyVBNFDmOvt2iQLKatjbFOyjTflXW4In58D7nO1aBSf7sJgJJ2Uq9gnXoGNKTgOoeBd-H8grozjfjjh-2O2W47G3btelzmXRGpGGcixH44KmI0P4zGL7SYhOe8W2msOsc-pdIqXBQWA8HFbywyR0x9JbLqKkwvVyo_Da1zJTksGVfvJkGFdaO8qncRCm8tL1hxGz4",
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Elena Vance",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text("ID: PX-8842"),
                      Text("DOB: 12/04/1988"),
                    ],
                  )
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 🔹 Lab Table Card
            Container(
              decoration: _cardStyle(),
              child: Column(
                children: [
                  _tableHeader(),
                  _tableRow(
                      "Glucose", "112", "mg/dL", "High", Colors.red),
                  _tableRow(
                      "Sodium", "140", "mmol/L", "Normal", Colors.green),
                  _tableRow(
                      "Potassium", "3.2", "mmol/L", "Low", Colors.orange),
                  _tableRow(
                      "Creatinine", "0.82", "mg/dL", "Normal", Colors.green),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 🔹 Clinical Interpretation
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardStyle(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Row(
                    children: [
                      Icon(Icons.note_alt, color: Color(0xFF12639E)),
                      SizedBox(width: 8),
                      Text(
                        "Clinical Interpretation",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    "Serum glucose is slightly elevated. Potassium levels are low. "
                    "Recommend follow-up fasting glucose test and dietary adjustment.",
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// 🔹 Doctor Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _cardStyle(),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                        "https://lh3.googleusercontent.com/aida-public/AB6AXuDoVBftBpRluBZagZldTqwMbG7rt_xcrElHAnUFwmrtGe6EOR-6qBO-0A5yjSLHhf1IF1hX-PNlB5Yy4jE0PtFQYZedJTubryrs8EhJEzAOu85ZOfvy1iiJu2KFKPk4ERMTwZQYFxAiTW0n77omq1_x9ev12AQCmEsC3cfuSAq0ZNLfRNs4ChhnNoB6wU27tUe2Cc3MikFo4-NoW_JTvAVCZh3xvMSk8Q7dqd3Fs837R0hBJZ1JL6JxPH6a3yaiJD5D7-Z4oxLJYfM"),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text("Dr. Julian Thorne",
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      Text("Senior Pathologist"),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 🔷 Table Header
  Widget _tableHeader() {
    return Container(
      padding: const EdgeInsets.all(12),
      color: Colors.grey.shade200,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Test"),
          Text("Value"),
          Text("Status"),
        ],
      ),
    );
  }

  /// 🔷 Table Row
  Widget _tableRow(
      String name, String value, String unit, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text("$value $unit"),
          Text(
            status,
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  /// 🔷 Card Style
  BoxDecoration _cardStyle() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
        )
      ],
    );
  }
}