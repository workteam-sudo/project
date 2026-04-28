import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinical Sanctuary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
      ),
      home: ConfirmationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ConfirmationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F4F7),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24),
          child: Column(
            children: [
              // Top Header
              _buildHeader(),
              SizedBox(height: 40),
              
              // Success Confirmation Section
              _buildSuccessSection(),
              SizedBox(height: 40),
              
              // Patient Profile Card
              _buildPatientProfileCard(),
              SizedBox(height: 24),
              
              // Destination Unit Card
              _buildDestinationUnitCard(),
              SizedBox(height: 32),
              
              // Action Buttons
              _buildActionButtons(),
              SizedBox(height: 24),
              
              // Footer Note
              _buildFooterNote(),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundImage: NetworkImage('https://images.unsplash.com/photo-1559839734-2b71ea197ec2?w=150'),
          backgroundColor: Color(0xFFEBF2FF),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Text(
            'Clinical Sanctuary',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF3B82F6),
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 12, offset: Offset(0, 2)),
            ],
          ),
          child: Icon(Icons.search_outlined, color: Color(0xFF64748B), size: 20),
        ),
      ],
    );
  }

  Widget _buildSuccessSection() {
    return Column(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)],
            ),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0xFF3B82F6).withOpacity(0.3),
                blurRadius: 25,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Icon(Icons.check_rounded, color: Colors.white, size: 40),
        ),
        SizedBox(height: 24),
        Text(
          'Recommendation Submitted',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700, color: Color(0xFF1E293B)),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 12),
        Text(
          'The admission request has been successfully\nrouted for processing.',
          style: TextStyle(fontSize: 16, color: Color(0xFF64748B)),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildPatientProfileCard() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 25, offset: Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: Text(
              'PATIENT PROFILE',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF3B82F6), letterSpacing: 1.2),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage('https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=150'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Eleanor Vance', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
                    SizedBox(height: 8),
                    Text('Patient ID: CL-882910', style: TextStyle(fontSize: 14, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                    Text('DOB: 05/14/1945', style: TextStyle(fontSize: 14, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Container(width: 10, height: 10, decoration: BoxDecoration(color: Color(0xFF3B82F6), shape: BoxShape.circle)),
              SizedBox(width: 12),
              Text('Awaiting Triage', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF3B82F6))),
              Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: Color(0xFFFEE2E2), borderRadius: BorderRadius.circular(20)),
                child: Text('High Priority', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Color(0xFFDC2626))),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDestinationUnitCard() {
    return Container(
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 25, offset: Offset(0, 8))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              'DESTINATION UNIT',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: Color(0xFF8B5CF6), letterSpacing: 1.2),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)]),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.favorite_rounded, color: Colors.white, size: 24),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Cardiology', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Color(0xFF1E293B))),
                    Text('Acute Care Wing, Level 4', style: TextStyle(fontSize: 14, color: Color(0xFF64748B), fontWeight: FontWeight.w500)),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          Container(height: 1, color: Color(0xFFE2E8F0), margin: EdgeInsets.symmetric(vertical: 12)),
          Padding(
            padding: EdgeInsets.only(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Estimated Bed Ready', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                    Spacer(),
                    Text('~45 Minutes', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Color(0xFF1E293B))),
                  ],
                ),
                SizedBox(height: 12),
                // ✅ PERFECT CUSTOM PROGRESS BAR - NO ERRORS
                Container(
                  height: 6,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Color(0xF1F5F9)),
                  child: Row(
                    children: [
                      Container(
                        width: 120,
                        height: 6,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: Color(0xFF3B82F6)),
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Color(0xFF3B82F6), Color(0xFF1D4ED8)]),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [BoxShadow(color: Color(0xFF3B82F6).withOpacity(0.3), blurRadius: 15, offset: Offset(0, 6))],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.assignment_outlined, color: Colors.white, size: 20),
                  SizedBox(width: 12),
                  Text('View Admission Queue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white)),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 16),
        Container(
          width: double.infinity,
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Color(0xE2E8F0)),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: Offset(0, 2))],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(16),
              onTap: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.list_outlined, color: Color(0xFF64748B), size: 20),
                  SizedBox(width: 12),
                  Text('Go to Patient List', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF334155))),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFooterNote() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.info_outline_rounded, color: Color(0xFF94A3B8), size: 16),
        SizedBox(width: 8),
        Text(
          "Confirmation sent to Dr. Miller's surgical dashboard.",
          style: TextStyle(fontSize: 14, color: Color(0xFF94A3B8), fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}