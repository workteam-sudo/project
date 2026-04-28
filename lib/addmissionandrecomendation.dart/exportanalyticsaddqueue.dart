
import 'package:flutter/material.dart';

class LuminaHealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumina Health',
      theme: ThemeData(
        fontFamily: 'Inter',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF8FAFC),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AnalyticsDashboard(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AnalyticsDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // 🧩 Sidebar Navigation
          Container(
            width: 280,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 40,
                  offset: Offset(4, 0),
                ),
              ],
              border: Border.all(color: Colors.blue.withOpacity(0.1)),
            ),
            child: Column(
              children: [
                // Logo
                Container(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'Lumina Health',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1E293B),
                      letterSpacing: -0.5,
                    ),
                  ),
                ),
                // Profile Section
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFF3B82F6).withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: Color(0xFF3B82F6),
                        child: Text(
                          'JV',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Dr. Julian Vance',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF1E293B),
                            ),
                          ),
                          Text(
                            'Chief Medical Officer',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Menu Items
                Expanded(
                  child: Column(
                    children: [
                      _navItem(Icons.analytics, 'Clinical Analytics', false),
                      _navItem(Icons.add_circle, 'Direct Admissions', false),
                      _navItem(Icons.people, 'Patient Registry', false),
                      _navItem(Icons.home_work, 'Facility Census', false),
                      SizedBox(height: 8),
                     _navItem(Icons.settings, 'System Settings', true),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Main Content Area
          Expanded(
            child: Column(
              children: [
                // 🔝 Top Header
                Container(
                  padding: EdgeInsets.fromLTRB(32, 32, 32, 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 20,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Export Analytics',
                              style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF1E293B),
                              ),
                            ),
                            Text(
                              'System Settings',
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xFF64748B),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Stack(
                            children: [
                              Icon(Icons.notifications_none, size: 24, color: Color(0xFF64748B)),
                              Positioned(
                                right: 0,
                                top: 0,
                                child: Container(
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 16),
                          Text(
                            'Surgical Dept., Last backup 2h ago',
                            style: TextStyle(
                              fontSize: 14,
                              color: Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Main Content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 📊 Left Column - Configuration
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              // Date Range Card
                              _configCard(
                                title: 'Date Range',
                                children: [
                                  _presetRow('Last Quarter', false),
                                  _presetRow('Fiscal Year', false),
                                  _presetRow('Custom Range', true,),
                                  SizedBox(height: 24),
                                  Row(
                                    children: [
                                      Expanded(child: _datePicker('Start Date', 'April 01, 2024')),
                                      SizedBox(width: 16),
                                      Expanded(child: _datePicker('End Date', 'April 24, 2024', isActive: true)),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 24),
                              // Dataset Selection Card
                              _configCard(
                                title: 'Dataset Selection',
                                children: [
                                  _datasetItem(Icons.people, 'Patient Census', 'Daily patient volume and demographics', true),
                                  _datasetItem(Icons.trending_up, 'Admission Rates', 'Admission trends and patterns', true),
                                  _datasetItem(Icons.favorite, 'Outcomes', 'Clinical outcomes and recovery rates', true),
                                  _datasetItem(Icons.receipt, 'Financial Billing', 'Billing and revenue data', false, isDisabled: true),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 32),
                        // 📦 Right Column - Summary & Actions
                        Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              // Format Selection
                              _configCard(
                                title: 'Export Format',
                                children: [
                                  _formatOption('PDF Report', Icons.picture_as_pdf, false),
                                  _formatOption('CSV Spreadsheet', Icons.table_chart, true),
                                  _formatOption('JSON Data', Icons.code, false),
                                ],
                              ),
                              SizedBox(height: 24),
                              // Export Summary Card
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(32),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                      Color(0xFF3B82F6),
                                      Color(0xFF1D4ED8),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF3B82F6).withOpacity(0.3),
                                      blurRadius: 30,
                                      offset: Offset(0, 12),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Icon(Icons.download, size: 48, color: Colors.white.withOpacity(0.8)),
                                    SizedBox(height: 24),
                                    Text(
                                      'April 01 - April 24, 2024',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Patient Census, Admissions, Outcomes',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'CSV • ~2.4 MB',
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.7),
                                        fontSize: 14,
                                      ),
                                    ),
                                    SizedBox(height: 32),
                                    SizedBox(
                                      width: double.infinity,
                                      height: 56,
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.white,
                                          foregroundColor: Color(0xFF3B82F6),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          elevation: 0,
                                          shadowColor: Colors.white.withOpacity(0.5),
                                        ),
                                        onPressed: () {},
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(Icons.download),
                                            SizedBox(width: 8),
                                            Text(
                                              'Generate Export',
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w700,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 24),
                              // Data Policy Info
                              Container(
                                padding: EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(16),
                                  border: Border.all(color: Color(0xFF3B82F6).withOpacity(0.2)),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.03),
                                      blurRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Row(
                                  children: [
                                    Icon(Icons.shield, color: Color(0xFF3B82F6), size: 20),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        'PHI compliant export (HIPAA). Data encrypted at rest and in transit.',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xFF64748B),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _navItem(IconData icon, String title, bool isActive, {bool highlight = false}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 32, vertical: 8),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isActive ? Color(0xFF3B82F6).withOpacity(0.1) : null,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: isActive ? Color(0xFF3B82F6) : Color(0xFF64748B), size: 20),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              color: isActive ? Color(0xFF3B82F6) : Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _configCard({required String title, required List<Widget> children}) {
    return Container(
      padding: EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 25,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF1E293B),
            ),
          ),
          SizedBox(height: 24),
          ...children,
        ],
      ),
    );
  }

  Widget _presetRow(String title, bool isSelected, {bool highlight = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF3B82F6).withOpacity(0.05) : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: isSelected ? Border.all(color: Color(0xFF3B82F6).withOpacity(0.3)) : null,
      ),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isSelected ? Color(0xFF3B82F6) : Color(0xFF94A3B8),
          ),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }

  Widget _datePicker(String label, String date, {bool isActive = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF64748B),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: isActive
                ? Border.all(color: Color(0xFF3B82F6), width: 2)
                : Border.all(color: Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
              ),
            ],
          ),
          child: Row(
            children: [
              Icon(Icons.calendar_today, color: Color(0xFF64748B), size: 18),
              SizedBox(width: 8),
              Text(
                date,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1E293B),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _datasetItem(IconData icon, String title, String subtitle, bool isSelected, {bool isDisabled = false}) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isSelected && !isDisabled ? Color(0xFF3B82F6).withOpacity(0.05) : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: isSelected && !isDisabled
            ? Border.all(color: Color(0xFF3B82F6).withOpacity(0.3))
            : Border.all(color: Colors.transparent),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected && !isDisabled ? Color(0xFF3B82F6).withOpacity(0.1) : Color(0xFF3B82F6).withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: isDisabled ? Color(0xFF94A3B8) : Color(0xFF3B82F6), size: 20),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDisabled ? Color(0xFF94A3B8) : Color(0xFF1E293B),
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: isDisabled ? Color(0xFFB8BCC9) : Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),
          Icon(
            isSelected ? Icons.check_circle : Icons.radio_button_unchecked,
            color: isSelected && !isDisabled ? Color(0xFF3B82F6) : Color(0xFF94A3B8),
          ),
        ],
      ),
    );
  }

  Widget _formatOption(String title, IconData icon, bool isSelected) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isSelected ? Color(0xFF3B82F6).withOpacity(0.05) : Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: isSelected ? Border.all(color: Color(0xFF3B82F6).withOpacity(0.3)) : null,
      ),
      child: Row(
        children: [
          Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
            color: isSelected ? Color(0xFF3B82F6) : Color(0xFF94A3B8),
          ),
          SizedBox(width: 16),
          Icon(icon, color: Color(0xFF64748B), size: 20),
          SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1E293B),
            ),
          ),
        ],
      ),
    );
  }
}