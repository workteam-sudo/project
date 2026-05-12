import 'package:flutter/material.dart';

class ExportPdfScreen extends StatefulWidget {
  const ExportPdfScreen({super.key});

  @override
  _ExportPdfScreenState createState() => _ExportPdfScreenState();
}

class _ExportPdfScreenState extends State<ExportPdfScreen> {
  bool isFullReport = true;
  String selectedQuality = 'High (Print)';

  @override
  Widget build(BuildContext context) {
    // Extract patient data from arguments
    final Map<String, dynamic>? patientData = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final patientName = patientData?['fullName'] ?? patientData?['name'] ?? 'Elena Vance';

    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),

      /// 🔷 APP BAR
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Export PDF",
          style: TextStyle(color: Colors.black),
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                "LUMINA",
                style: TextStyle(
                  color: Color(0xFF12639E),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          )
        ],
      ),

      /// 🔷 BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            /// 🔹 HEADER
            const Text(
              "LIVE PREVIEW",
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 4),
            const Text(
              "Laboratory Report",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            /// 🔹 REPORT CARD
            Container(
              padding: const EdgeInsets.all(16),
              decoration: _card(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Title
                  const Text(
                    "LUMINA DIAGNOSTICS",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF12639E)),
                  ),
                  const SizedBox(height: 8),
                  const Divider(),

                  /// Patient + Doctor
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("PATIENT"),
                          const SizedBox(height: 4),
                          Text(patientName,
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                          const Text("DOB: 05/12/1988"),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const Text("PHYSICIAN"),
                          const SizedBox(height: 4),
                          const Text("Dr. Marcus Thorne",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// Table
                  _tableRow("Glucose", "92 mg/dL", "65 - 99"),
                  _tableRow("Creatinine", "1.3 mg/dL", "0.6 - 1.2",
                      isAlert: true),
                  if (isFullReport) ...[
                    _tableRow("Calcium", "9.4 mg/dL", "8.5 - 10.2"),
                    _tableRow("Sodium", "140 mmol/L", "136 - 145"),
                  ],

                  const SizedBox(height: 16),

                  const Divider(),

                  const Text(
                    "This document is certified medical record.",
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// 🔹 EXPORT SETTINGS
            const Text(
              "Export Settings",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            /// Report Type Toggle
            Container(
              padding: const EdgeInsets.all(12),
              decoration: _card(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Report Content"),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _toggleButton("Full Report", isFullReport, () {
                        setState(() {
                          isFullReport = true;
                        });
                      }),
                      _toggleButton("Summary Only", !isFullReport, () {
                        setState(() {
                          isFullReport = false;
                        });
                      }),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            /// Quality Settings
            Container(
              padding: const EdgeInsets.all(12),
              decoration: _card(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Quality Settings"),
                  const SizedBox(height: 10),
                  _radioTile("High (Print)", selectedQuality == 'High (Print)'),
                  _radioTile("Standard (Digital)", selectedQuality == 'Standard (Digital)'),
                ],
              ),
            ),

            const SizedBox(height: 24),

            /// 🔹 BUTTONS
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12639E),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/pdfready.dart');
                },
                icon: const Icon(Icons.download, color: Colors.white),
                label: const Text("Download PDF", style: TextStyle(color: Colors.white)),
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: OutlinedButton.icon(
                onPressed: () {
                   showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Secure Share"),
                      content: const Text("The report will be encrypted and shared via the secure portal. Do you want to proceed?"),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text("Cancel")),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Report shared successfully")),
                            );
                          },
                          child: const Text("Share"),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.lock),
                label: const Text("Share via Secure Portal"),
              ),
            ),

            const SizedBox(height: 16),

            const Center(
              child: Text(
                "HIPAA COMPLIANT   •   AES-256 ENCRYPTED",
                style: TextStyle(fontSize: 10, color: Colors.grey),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 🔷 TABLE ROW
  Widget _tableRow(String name, String value, String range,
      {bool isAlert = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(
            value,
            style: TextStyle(
              color: isAlert ? Colors.red : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(range, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }

  /// 🔷 TOGGLE BUTTON
  Widget _toggleButton(String text, bool active, VoidCallback onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(right: 8),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: active ? Colors.white : Colors.grey.shade200,
            borderRadius: BorderRadius.circular(10),
            border: active ? Border.all(color: const Color(0xFF12639E)) : null,
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: active ? const Color(0xFF12639E) : Colors.grey,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 🔷 RADIO TILE
  Widget _radioTile(String text, bool selected) {
    return ListTile(
      onTap: () {
        setState(() {
          selectedQuality = text;
        });
      },
      contentPadding: EdgeInsets.zero,
      leading: Icon(Icons.print, color: selected ? const Color(0xFF12639E) : Colors.grey),
      title: Text(text),
      trailing: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_off,
        color: selected ? const Color(0xFF12639E) : Colors.grey,
      ),
    );
  }

  /// 🔷 CARD STYLE
  BoxDecoration _card() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          blurRadius: 10,
          color: Colors.black.withOpacity(0.05),
        )
      ],
    );
  }
}

