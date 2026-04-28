import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clinical Sanctuary',
      theme: ThemeData(
        fontFamily: 'Inter',
        scaffoldBackgroundColor: Color(0xfff8f9fa),
      ),
      home: ICUDashboard(),
    );
  }
}

class ICUDashboard extends StatelessWidget {
  final Color primary = Color(0xff12639e);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer(),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Clinical Sanctuary",
          style: TextStyle(
              color: Color(0xff5B85AA),
              fontWeight: FontWeight.bold),
        ),
        iconTheme: IconThemeData(color: Color(0xff5B85AA)),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://lh3.googleusercontent.com/aida-public/AB6AXuDEBFJ5w3bqmOv4S7kHNVYdDOoTGyxkuMvQj8B2dmq3MP2kpCFczeuSItUEtdnMcFiAGF5vSKoYSdxVqom4Ne2J1xkBSTnSK1NQ106CS3ucbFTCgI_WmuAv1LUXHHZd4lB3tBrAnFEAydWNEUhuAuoTIHB3E0hYdDNRT8vYw5WuJWYtm7iMBWEZF0jOYvo6DaeBLH-L3OXfrHYVv9gEB6uvN0K_QW6eDDJAdimnBOBpZzoziZsg5Je5Mjm2Ra0OC5MNSCxuorr2P5M"),
            ),
          )
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Active ICU Census",
                style: TextStyle(
                    fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text("24 Patients • 4 Critical • 2 Beds Available",
                style: TextStyle(color: Colors.grey)),

            SizedBox(height: 20),

            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 0.8,
                children: [
                  patientCard(
                      name: "Elena Rodriguez",
                      id: "#882-990-21",
                      bed: "B12",
                      status: "Critical",
                      hr: "118",
                      spo2: "89%",
                      bp: "92/58",
                      statusColor: Colors.red),

                  patientCard(
                      name: "Samuel Thompson",
                      id: "#441-209-11",
                      bed: "B08",
                      status: "Monitoring",
                      hr: "78",
                      spo2: "97%",
                      bp: "122/80",
                      statusColor: Colors.blue),

                  patientCard(
                      name: "Clarissa Mendez",
                      id: "#993-412-00",
                      bed: "B15",
                      status: "Stable",
                      hr: "62",
                      spo2: "99%",
                      bp: "118/76",
                      statusColor: Colors.grey),

                  patientCard(
                      name: "Jonathan Pryce",
                      id: "#112-990-88",
                      bed: "B02",
                      status: "Critical",
                      hr: "142",
                      spo2: "82%",
                      bp: "88/42",
                      statusColor: Colors.red),
                ],
              ),
            ),

            SizedBox(height: 10),

            statsSection()
          ],
        ),
      ),
    );
  }

  Widget drawer() {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            child: Text("Dashboard",
                style: TextStyle(fontSize: 20)),
          ),
          drawerItem(Icons.dashboard, "ICU Overview", true),
          drawerItem(Icons.monitor_heart, "Patient Analytics", false),
          drawerItem(Icons.calendar_today, "Staff Schedule", false),
          drawerItem(Icons.notifications, "Alerts", false),
        ],
      ),
    );
  }

  Widget drawerItem(IconData icon, String title, bool active) {
    return ListTile(
      leading: Icon(icon, color: active ? primary : Colors.grey),
      title: Text(title),
      tileColor: active ? Colors.blue.shade50 : null,
    );
  }

  Widget patientCard({
    required String name,
    required String id,
    required String bed,
    required String status,
    required String hr,
    required String spo2,
    required String bp,
    required Color statusColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: statusColor.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(status,
                  style: TextStyle(
                      color: statusColor,
                      fontSize: 10,
                      fontWeight: FontWeight.bold)),
            ),
          ),

          SizedBox(height: 10),

          Row(
            children: [
              CircleAvatar(child: Text(bed)),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold)),
                    Text(id,
                        style: TextStyle(
                            fontSize: 12, color: Colors.grey)),
                  ],
                ),
              )
            ],
          ),

          Divider(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              metric("HR", hr, statusColor),
              metric("SpO2", spo2, Colors.black),
              metric("BP", bp, Colors.black),
            ],
          ),
        ],
      ),
    );
  }

  Widget metric(String label, String value, Color color) {
    return Column(
      children: [
        Text(label,
            style: TextStyle(fontSize: 10, color: Colors.grey)),
        SizedBox(height: 4),
        Text(value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: color)),
      ],
    );
  }

  Widget statsSection() {
    return Row(
      children: [
        statBox("Ward Occupancy", "92%"),
        SizedBox(width: 10),
        statBox("Staff Ratio", "1:2"),
        SizedBox(width: 10),
        statBox("Critical Alerts", "04", color: Colors.red),
      ],
    );
  }

  Widget statBox(String title, String value, {Color? color}) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 10, color: Colors.grey)),
            SizedBox(height: 8),
            Text(value,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color ?? Colors.black)),
          ],
        ),
      ),
    );
  }
}