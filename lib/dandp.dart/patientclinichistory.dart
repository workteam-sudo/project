import 'package:flutter/material.dart';

class PatientClinicalTimelineScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            elevation: 2,
            pinned: true,
            titleSpacing: 0,
            title: _buildTopNavigation(),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: _buildBreadcrumb(),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildPatientHeader(),
                _buildClinicalTimelineSection(),
                _buildVitalitySummary(),
                _buildFilesSection(),
                SizedBox(height: 100),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopNavigation() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Icon(Icons.menu, color: Colors.grey[700]),
          SizedBox(width: 16),
          Text(
            'Clinical Sanctuary',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.black87,
            ),
          ),
          Spacer(),
          Icon(Icons.notifications_outlined, color: Colors.grey[600]),
          SizedBox(width: 12),
          CircleAvatar(
            radius: 18,
            backgroundColor: Color(0xFF3A7BFF),
            child: Icon(Icons.person, color: Colors.white, size: 20),
          ),
        ],
      ),
    );
  }

  Widget _buildBreadcrumb() {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 12, 20, 20),
      child: Text(
        'Patients > Elena Vance',
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[600],
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPatientHeader() {
    return Container(
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Elena Vance',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(width: 16),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            'PID: 9021-X',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Text('34y • A+', style: TextStyle(fontSize: 16, color: Colors.grey[600])),
                        SizedBox(width: 24),
                        Row(
                          children: [
                            Icon(Icons.warning_amber_rounded, color: Colors.red, size: 20),
                            SizedBox(width: 4),
                            Text(
                              'Penicillin Allergy',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.red[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  _buildActionButton('Export', Colors.grey[300]!, Colors.grey[700]!),
                  SizedBox(height: 12),
                  _buildActionButton('New Entry', Color(0xFF3A7BFF), Colors.white),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(String label, Color bgColor, Color textColor) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Text(
              label,
              style: TextStyle(
                color: textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClinicalTimelineSection() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Text(
      'Clinical Timeline',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black87,
      ),
    ),
    Icon(Icons.tune_outlined, color: Color(0xFF3A7BFF)),
  ],  // ✅ Add these
),
SizedBox(height: 24),  // ✅ Now properly placed
          SizedBox(height: 24),
          _buildTimelineCard(
            date: 'OCT 24, 2023',
            title: 'Quarterly Cardiovascular Review',
            status: 'ROUTINE',
            statusColor: Colors.grey[600]!,
            description: 'Patient stable at 122/78. Reports minor fatigue during high-intensity training. Heart sounds…',
            footer: 'DIAGNOSIS – Managed Hypertension',
            footerColor: Color(0xFF3A7BFF),
          ),
          SizedBox(height: 20),
          _buildTimelineCard(
            date: 'AUG 12, 2023',
            title: 'Acute Respiratory Infection',
            status: 'URGENT',
            statusColor: Colors.red,
            description: 'Persistent dry cough and low-grade fever. Chest X-ray clear. Rapid strep negative…',
            footer: 'Rx Benzonatate 100mg',
            footerColor: Colors.green[600]!,
          ),
          SizedBox(height: 20),
          _buildTimelineCard(
            date: 'MAY 05, 2023',
            title: 'Annual Physical Examination',
            status: 'SCREENING',
            statusColor: Color(0xFF3A7BFF),
            description: 'Comprehensive wellness exam. All vitals within normal limits. BMI 23.4…',
            footer: 'View Results (8)',
            footerColor: Color(0xFF3A7BFF),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard({
    required String date,
    required String title,
    required String status,
    required Color statusColor,
    required String description,
    required String footer,
    required Color footerColor,
  }) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(32, 24, 24, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                    height: 1.4,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Text(
                      footer,
                      style: TextStyle(
                        color: footerColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios, size: 14, color: footerColor),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            left: 12,
            top: 24,
            bottom: 24,
            child: Container(
              width: 2,
              color: Colors.grey[300],
            ),
          ),
          Positioned(
            left: 6,
            top: 24,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: Color(0xFF3A7BFF),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF3A7BFF).withOpacity(0.3),
                    blurRadius: 8,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            top: 20,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildVitalitySummary() {
    return Container(
      margin: EdgeInsets.fromLTRB(20, 0, 20, 24),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Vitality Summary',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(child: _buildVitalCard('BP (mmHg)', '122/78', Colors.blue[300]!)),
              SizedBox(width: 16),
              Expanded(child: _buildVitalCard('HR (BPM)', '72', Colors.green[300]!)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVitalCard(String title, String value, Color color) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(title, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
          SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Colors.grey[300],
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

  Widget _buildFilesSection() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Files',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF3A7BFF),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _buildFileItem(
            icon: Icons.picture_as_pdf_outlined,
            iconColor: Colors.red[400]!,
            name: 'Lab_Report_Oct23.pdf',
            date: 'Oct 24',
          ),
          SizedBox(height: 12),
          _buildFileItem(
            icon: Icons.image_outlined,
            iconColor: Colors.blue[400]!,
            name: 'Chest_XRay_Aug.jpg',
            date: 'Aug 12',
          ),
        ],
      ),
    );
  }

  Widget _buildFileItem({
    required IconData icon,
    required Color iconColor,
    required String name,
    required String date,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  date,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400]),
        ],
      ),
    );
  }
}