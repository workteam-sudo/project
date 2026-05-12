import 'package:flutter/material.dart';

class ClinicalTimelineDashboard extends StatelessWidget {
  const ClinicalTimelineDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    // Extract patient data from arguments
    final Map<String, dynamic>? patientData = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    
    final name = patientData?['fullName'] ?? patientData?['name'] ?? 'Unknown Patient';
    final age = patientData?['age']?.toString() ?? 'N/A';
    final gender = patientData?['gender'] ?? 'Not specified';
    final pid = patientData?['id']?.toString().substring(0, 8) ?? 'Unknown';
    final bloodType = patientData?['bloodType'] ?? 'Unknown';
    final conditions = patientData?['conditions'] ?? 'No known conditions';

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: AppBar(
        title: const Text(
          "Patient History",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF2C3E50),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF2C3E50), size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF95A5A6)),
            onPressed: () => Navigator.pushNamed(context, '/notifications'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Breadcrumb
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "Patients > $name",
                style: const TextStyle(
                  fontSize: 14,
                  color: Color(0xFF95A5A6),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Patient Overview
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Patient Picture
                CircleAvatar(
                  radius: 40,
                  backgroundColor: const Color(0xFF3A7BFF).withOpacity(0.1),
                  backgroundImage: patientData?['image'] != null ? NetworkImage(patientData!['image']) : null,
                  child: patientData?['image'] == null
                      ? Text(
                          name.toString().isNotEmpty ? name.toString()[0].toUpperCase() : 'P',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF3A7BFF),
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF2C3E50),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE9F2FB),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              "PID: #${pid.toUpperCase()}",
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF3A7BFF),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "$age • $gender • $bloodType",
                            style: const TextStyle(
                              fontSize: 14,
                              color: Color(0xFF95A5A6),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFEF2F2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.warning_amber, color: Color(0xFFE74C3C), size: 16),
                            const SizedBox(width: 6),
                            Flexible(
                              child: Text(
                                conditions,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFE74C3C),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Action Buttons
                Column(
                  children: [
                    OutlinedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/export.dart', arguments: patientData);
                      },
                      icon: const Icon(Icons.download, size: 16),
                      label: const Text("Export"),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        side: BorderSide(color: Colors.grey[400]!),
                      ),
                    ),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushNamed(context, '/clinicnewentry.dart', arguments: patientData);
                      },
                      icon: const Icon(Icons.add, size: 16),
                      label: const Text("New Entry"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3A7BFF),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 40),

            // Clinical Timeline Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Clinical Timeline",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => Navigator.pushNamed(context, '/drmedicalrecords.dart'),
                  icon: const Icon(Icons.filter_list, size: 18),
                  label: const Text("Filter"),
                ),
              ],
            ),
            const SizedBox(height: 24),
            _buildTimeline(context),

            const SizedBox(height: 40),

            // Vitality Summary
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 24,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Vitality Summary",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF2C3E50),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(child: _buildVitalCard("BP (mmHg)", "122/78", const Color(0xFF3A7BFF))),
                      const SizedBox(width: 24),
                      Expanded(child: _buildVitalCard("HR (BPM)", "72", const Color(0xFF28A745))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),

            // Quick Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Quick Actions",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/drmedicalrecords.dart'),
                  child: const Text("View All", style: TextStyle(color: Color(0xFF3A7BFF))),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildQuickAction(Icons.note_alt, "Note", () => Navigator.pushNamed(context, '/clinicnewentry.dart', arguments: patientData))),
                const SizedBox(width: 16),
                Expanded(child: _buildQuickAction(Icons.science, "Lab", () => Navigator.pushNamed(context, '/labtestview.dart', arguments: patientData))),
                const SizedBox(width: 16),
                Expanded(child: _buildQuickAction(Icons.picture_as_pdf, "PDF", () => Navigator.pushNamed(context, '/exportpdf.dart', arguments: patientData))),
                const SizedBox(width: 16),
                Expanded(child: _buildQuickAction(Icons.calendar_today, "Visit", () => Navigator.pushNamed(context, '/visdetail', arguments: patientData))),
              ],
            ),
            const SizedBox(height: 40),

            // Files Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Files",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF2C3E50),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(context, '/drmedicalrecords.dart'),
                  child: const Text("View All", style: TextStyle(color: Color(0xFF3A7BFF))),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: _buildFileCard("Lab_Report_Oct23.pdf", "Oct 24", Icons.picture_as_pdf, () => Navigator.pushNamed(context, '/pdfready.dart'))),
                const SizedBox(width: 16),
                Expanded(child: _buildFileCard("Chest_XRay_Aug.jpg", "Aug 12", Icons.image, () => Navigator.pushNamed(context, '/drmedicalrecords.dart'))), // Linked to medical records
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline(BuildContext context) {
    return Column(
      children: [
        _buildTimelineEntry(context, "OCT 24, 2023", "Quarterly Cardiovascular Review", "ROUTINE", "DIAGNOSIS", "View Full Notes"),
        const SizedBox(height: 24),
        _buildTimelineEntry(context, "AUG 12, 2023", "Acute Respiratory Infection", "URGENT", "Rx Benzonatate 100mg", ""),
        const SizedBox(height: 24),
        _buildTimelineEntry(context, "MAY 05, 2023", "Annual Physical Examination", "SCREENING", "View Results (8)", ""),
      ],
    );
  }

  Widget _buildTimelineEntry(BuildContext context, String date, String title, String status, String footer, String link) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 20,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FA),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF6C757D),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: status == "ROUTINE" 
                        ? Colors.grey[100] 
                        : status == "URGENT" 
                          ? const Color(0xFFFEE2E2) 
                          : Colors.blue[50],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: status == "ROUTINE" 
                          ? Colors.grey[600] 
                          : status == "URGENT" 
                            ? const Color(0xFFE74C3C) 
                            : const Color(0xFF3A7BFF),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF2C3E50),
                ),
              ),
              const SizedBox(height: 12),
              Text(
                "Patient stable at 122/78. Reports minor fatigue during high-intensity training. Heart sounds normal. Continue current regimen.",
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF6C757D),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    footer,
                    style: TextStyle(
                      fontSize: 13,
                      color: const Color(0xFF3A7BFF),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  if (link.isNotEmpty)
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/visdetail'),
                      child: Text(link, style: const TextStyle(color: Color(0xFF3A7BFF))),
                    ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 32,
          top: 60,
          bottom: 0,
          child: Container(
            width: 2,
            color: Colors.grey[300],
          ),
        ),
        Positioned(
          left: 24,
          top: 48,
          child: Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFF3A7BFF), width: 2),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF3A7BFF).withOpacity(0.3),
                  blurRadius: 8,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVitalCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2C3E50),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              widthFactor: 0.75,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAction(IconData icon, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, color: const Color(0xFF3A7BFF), size: 28),
            const SizedBox(height: 12),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2C3E50),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileCard(String name, String date, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FA),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: const Color(0xFF6C757D), size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF2C3E50),
                      ),
                    ),
                    Text(
                      date,
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFF95A5A6),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}
