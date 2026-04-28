import 'package:flutter/material.dart';



class MedicalRecordsPage extends StatelessWidget {
    MedicalRecordsPage({super.key});
  final Color primary = Color(0xff2D6CDF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff5f7fb),

      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          "Medical Records",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// Diagnosis Summary
            Text("Diagnosis Summary",
                style: TextStyle(fontWeight: FontWeight.bold)),

            SizedBox(height: 10),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Image
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1581595219319-9f8b5c1a1c1f",
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("PRIMARY CONDITION",
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: primary.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text("ACTIVE",
                                  style: TextStyle(
                                      fontSize: 10,
                                      color: primary,
                                      fontWeight: FontWeight.bold)),
                            )
                          ],
                        ),

                        SizedBox(height: 6),

                        Text("Acute Bronchitis",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16)),

                        SizedBox(height: 6),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Diagnosed: Oct 24, 2023",
                                style: TextStyle(fontSize: 12, color: Colors.grey)),

                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primary,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 16),
                              ),
                              onPressed: () {},
                              child: Text("Details"),
                            )
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            SizedBox(height: 20),

            /// Prescribed Medicines
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Prescribed Medicines",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("2 Active", style: TextStyle(color: primary))
              ],
            ),

            SizedBox(height: 10),

            medicineTile(
                "Amoxicillin 500mg",
                "1 capsule • 3x Daily • After Meals",
                "In Stock"),

            medicineTile(
                "Salbutamol Inhaler",
                "2 puffs • As needed for shortness of breath",
                "Current"),

            SizedBox(height: 20),

            /// Lab Test Results
            Text("Lab Test Results",
                style: TextStyle(fontWeight: FontWeight.bold)),

            SizedBox(height: 10),

            labTile("Complete Blood Panel", "Oct 25, 2023 • Normal"),
            labTile("Chest X-Ray", "Oct 24, 2023 • Clear"),

            SizedBox(height: 20),

            /// Treatment History
            Text("Treatment History",
                style: TextStyle(fontWeight: FontWeight.bold)),

            SizedBox(height: 10),

            timelineItem(
                "TODAY 09:30AM",
                "Nebulization Therapy",
                "Administered by Nurse Sarah J."),

            timelineItem(
                "OCT 24, 02:15PM",
                "Initial Physical Examination",
                "Dr. Robert Chen • General Ward"),

            timelineItem(
                "OCT 24, 11:00AM",
                "Patient Admission",
                ""),

            SizedBox(height: 30),

            /// Bottom Button
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {},
                child: Text("View / Download Medical Report"),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Medicine Tile
  Widget medicineTile(String title, String subtitle, String status) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xffe8f0ff),
            child: Icon(Icons.medication, color: Colors.blue),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey))
              ],
            ),
          ),
          Column(
            children: [
              Icon(Icons.circle, color: Colors.green, size: 10),
              Text(status, style: TextStyle(fontSize: 10))
            ],
          )
        ],
      ),
    );
  }

  /// Lab Tile
  Widget labTile(String title, String subtitle) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
                Text(subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey))
              ]),
          Text("View", style: TextStyle(color: primary))
        ],
      ),
    );
  }

  /// Timeline Item
  Widget timelineItem(String time, String title, String subtitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(Icons.circle, size: 10, color: Colors.blue),
            Container(width: 2, height: 40, color: Colors.grey.shade300)
          ],
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(time,
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold)),
              Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
              if (subtitle.isNotEmpty)
                Text(subtitle,
                    style: TextStyle(fontSize: 12, color: Colors.grey)),
              SizedBox(height: 10),
            ],
          ),
        )
      ],
    );
  }
}