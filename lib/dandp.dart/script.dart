import 'package:flutter/material.dart';

class ScriptsDashboardScreen extends StatefulWidget {
  @override
  _ScriptsDashboardScreenState createState() => _ScriptsDashboardScreenState();
}

class _ScriptsDashboardScreenState extends State<ScriptsDashboardScreen> {
  int selectedTab = 0; // 0: Active, 1: Past

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        titleSpacing: 0,
        title: _buildTopNavigation(),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(height: 1, color: Colors.grey[300]),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderSection(),
            SizedBox(height: 24),
            _buildSearchBar(),
            SizedBox(height: 24),
            _buildTabs(),
            SizedBox(height: 24),
            _buildMedicationList(),
            SizedBox(height: 32),
            _buildSummaryCards(),
            SizedBox(height: 100),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildTopNavigation() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Color(0xFF3A7BFF),
            child: Icon(Icons.person, color: Colors.white, size: 22),
          ),
          SizedBox(width: 16),
          Text(
            'Hospital System',
            style: TextStyle(
              color: Color(0xFF3A7BFF),
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Spacer(),
          Icon(Icons.notifications_outlined, color: Colors.grey[600]),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Scripts',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF3A7BFF), Color(0xFF5A9BFF)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF3A7BFF).withOpacity(0.3),
                  blurRadius: 15,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  child: Text(
                    '+ New Script',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
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
            Icon(Icons.search, color: Colors.grey[500], size: 22),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                'Search medications…',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[500],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => selectedTab = 0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: selectedTab == 0 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: selectedTab == 0
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    'Active',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: selectedTab == 0 ? Color(0xFF3A7BFF) : Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 8),
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => selectedTab = 1),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                  decoration: BoxDecoration(
                    color: selectedTab == 1 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: selectedTab == 1
                        ? [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    'Past',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: selectedTab == 1 ? Color(0xFF3A7BFF) : Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicationList() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          _buildMedicationCard(
            icon: Icons.medication,
            iconColor: Color(0xFFE3F2FD),
            title: 'Lisinopril',
            status: 'ACTIVE',
            statusColor: Color(0xFF3A7BFF),
            subtitle: '10mg • Twice daily',
            label: 'REFILLS',
            value: '3 Left',
          ),
          SizedBox(height: 16),
          _buildMedicationCard(
            icon: Icons.warning_amber_rounded,
            iconColor: Color(0xFFFFE0E0),
            title: 'Metformin',
            status: 'EXPIRING SOON',
            statusColor: Colors.red[400]!,
            subtitle: '500mg • Once daily (Evening)',
            label: 'URGENT',
            value: '2 Days',
            isUrgent: true,
          ),
          SizedBox(height: 16),
          _buildMedicationCard(
            icon: Icons.inventory_2_outlined,
            iconColor: Color(0xFFF3E5F5),
            title: 'Atorvastatin',
            status: 'ACTIVE',
            statusColor: Color(0xFF3A7BFF),
            subtitle: '20mg • Bedtime',
            label: 'Refills',
            value: '5 Left',
          ),
          SizedBox(height: 16),
          _buildMedicationCard(
            icon: Icons.water_drop_outlined,
            iconColor: Color(0xFFE1F5FE),
            title: 'Amlodipine',
            status: 'ACTIVE',
            statusColor: Color(0xFF3A7BFF),
            subtitle: '5mg • Daily',
            label: 'Refills',
            value: '1 Left',
          ),
          SizedBox(height: 16),
          _buildMedicationCard(
            icon: Icons.history,
            iconColor: Colors.grey[200]!,
            title: 'Amoxicillin',
            status: 'COMPLETED',
            statusColor: Colors.grey[500]!,
            subtitle: '500mg • Three times daily',
            label: 'ENDED',
            value: 'Oct 12',
            isCompleted: true,
          ),
        ],
      ),
    );
  }

  Widget _buildMedicationCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String status,
    required Color statusColor,
    required String subtitle,
    required String label,
    required String value,
    bool isUrgent = false,
    bool isCompleted = false,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isCompleted ? Colors.grey[50] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: isCompleted ? Colors.transparent : Colors.black.withOpacity(0.08),
            blurRadius: 20,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: iconColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: isCompleted ? Colors.grey[500]! : Color(0xFF3A7BFF), size: 24),
          ),
          SizedBox(width: 16),
          Expanded(
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
                          color: isCompleted ? Colors.grey[600]! : Colors.black87,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                        color: statusColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        status,
                        style: TextStyle(
                          color: statusColor,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 15,
                    color: isCompleted ? Colors.grey[500]! : Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: isUrgent ? Colors.red[600]! : Colors.grey[600],
                ),
              ),
              SizedBox(height: 2),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: isUrgent ? Colors.red[600]! : Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCards() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          Expanded(
            child: _buildSummaryCard('08', 'TOTAL ACTIVE', Color(0xFFE3F2FD), Color(0xFF3A7BFF)),
          ),
          SizedBox(width: 16),
          Expanded(
            child: _buildSummaryCard('02', 'PENDING AUTH', Color(0xFFF3E5F5), Color(0xFF7B1FA2)),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(String value, String label, Color bgColor, Color accentColor) {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: accentColor,
            ),
          ),
          SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: accentColor.withOpacity(0.8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.transparent,
        elevation: 0,
        selectedItemColor: Color(0xFF3A7BFF),
        unselectedItemColor: Colors.grey[500],
        currentIndex: 2,  // Scripts active
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            activeIcon: Icon(Icons.people),
            label: 'Patients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history_outlined),
            activeIcon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color(0xFF3A7BFF),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.medication, color: Colors.white, size: 20),
            ),
            label: 'Scripts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
