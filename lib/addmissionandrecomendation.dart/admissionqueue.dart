// 
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clinical Sanctuary',
      theme: ThemeData(
        fontFamily: 'Inter',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF2F4F7),
      ),
      home: AdmissionQueueScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class AdmissionQueueScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(),
          SliverToBoxAdapter(child: _buildHeader()),
          SliverToBoxAdapter(child: _buildActionButtons()),
          SliverToBoxAdapter(child: _buildEmergencySection()),
          SliverToBoxAdapter(child: _buildUrgentSection()),
          SliverToBoxAdapter(child: _buildRoutineSection()),
          SliverToBoxAdapter(child: _buildQueueMetrics()),
          SliverToBoxAdapter(child: _buildWaitTimeTrends()),
          // SliverToBoxAdapter(child: _buildBottomStats()),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      pinned: true,
      titleSpacing: 0,
      title: Row(
        children: [
          Icon(Icons.menu, color: Colors.grey[600], size: 24),
          SizedBox(width: 16),
          Text(
            'Clinical Sanctuary',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.black87,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.filter_list, color: Colors.grey[600]),
          onPressed: () {},
        ),
        CircleAvatar(
          radius: 18,
          backgroundColor: Color(0xFF4F46E5),
          child: Text('Dr', style: TextStyle(color: Colors.white, fontSize: 12)),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Admission Queue',
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.red[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '4 High Priority',
                  style: TextStyle(
                    color: Colors.red[800],
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ),
              SizedBox(width: 16),
              Text(
                '24 Patients Total',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Container(
            height: 1,
            color: Colors.grey[300],
            margin: EdgeInsets.symmetric(vertical: 12),
          ),
          Row(
            children: [
              Icon(Icons.refresh, size: 16, color: Colors.grey[500]),
              SizedBox(width: 4),
              Text(
                'Last updated 2m ago',
                style: TextStyle(color: Colors.grey[500], fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: _neumorphicButton(
              'Export Analytics',
              Colors.grey[200]!,
              Colors.grey[400]!,
              Icons.download,
            ),
          ),
          SizedBox(width: 12),
          _neumorphicButton(
            'Direct Admission',
            Color(0xFF3B82F6),
            Colors.white,
            Icons.add,
            isPrimary: true,
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencySection() {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Emergency', '2 REQ', Colors.red),
          SizedBox(height: 16),
          ...List.generate(2, (index) => _emergencyCard(index)),
        ],
      ),
    );
  }

  Widget _buildUrgentSection() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Urgent', '5 REQ', Color(0xFF3B82F6)),
          SizedBox(height: 16),
          ...List.generate(3, (index) => _urgentCard(index)),
        ],
      ),
    );
  }

  Widget _buildRoutineSection() {
    return Container(
      margin: EdgeInsets.fromLTRB(24, 16, 24, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionHeader('Routine', '17 REQ', Colors.grey[500]!),
          SizedBox(height: 16),
          ...List.generate(4, (index) => _routineRow(index)),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title, String badge, Color color) {
    return Row(
      children: [
        Icon(Icons.warning_amber_rounded, color: color, size: 24),
        SizedBox(width: 12),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(width: 12),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            badge,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }

  Widget _emergencyCard(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Left red border effect
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 4,
              decoration: BoxDecoration(
                color: Colors.red[400],
                borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 20, 20, 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.red[400],
                        shape: BoxShape.circle,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      ['CRITICAL STABILITY', 'AIRWAY RISK'][index % 2],
                      style: TextStyle(
                        color: Colors.red[700],
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        ['Elena Rodriguez', 'Mark Stevenson'][index % 2],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        'ID: ${['A-2478', 'A-3591'][index % 2]} • 34/F',
                        style: TextStyle(color: Colors.grey[600], fontSize: 14),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Severe chest pain with shortness of breath',
                          style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      ['08:12', '15:45'][index % 2],
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.red[600],
                      ),
                    ),
                    Text(
                      'IN QUEUE',
                      style: TextStyle(
                        color: Colors.red[500],
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _urgentCard(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Left blue border effect
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Container(
              width: 4,
              decoration: BoxDecoration(
                color: Color(0xFF3B82F6),
                borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(24, 20, 20, 20),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xFF3B82F6).withOpacity(0.1),
                  child: Icon(Icons.person, color: Color(0xFF3B82F6), size: 20),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'John Carter',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                      ),
                      Text('ID: A-1289 • 45/M', style: TextStyle(color: Colors.grey[600])),
                      SizedBox(height: 8),
                      Text(
                        'Abdominal pain, nausea',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      SizedBox(height: 12),
                      Wrap(
                        spacing: 8,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Color(0xFF3B82F6).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'General Surg',
                              style: TextStyle(
                                color: Color(0xFF3B82F6),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.green[100]!,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              'OK',
                              style: TextStyle(
                                color: Colors.green[700],
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(
                      '01:24',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    ),
                    Text('IN QUEUE', style: TextStyle(color: Colors.grey[500])),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _routineRow(int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
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
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[200]!,
              child: Icon(Icons.person_outline, color: Colors.grey[500]),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sarah Johnson', style: TextStyle(fontWeight: FontWeight.w600)),
                  Text('Routine checkup', style: TextStyle(color: Colors.grey[600])),
                ],
              ),
            ),
            Text(
              '${(index + 1) * 2}:45h',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueueMetrics() {
    return Container(
      margin: EdgeInsets.all(24),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!, style: BorderStyle.solid, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.trending_up, size: 48, color: Color(0xFF10B981)),
          SizedBox(width: 24),
          Expanded(
            child: Text(
              'Average Routine wait time is currently 5h 12m.\nEfficiency up 8% today.',
              style: TextStyle(
                fontSize: 16,
                height: 1.4,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaitTimeTrends() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 24),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 25,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Wait Time Trends',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          SizedBox(height: 8),
          Text(
            'Live Performance',
            style: TextStyle(color: Colors.grey[600], fontSize: 16),
          ),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(5, (index) {
              double height = [0.3, 0.7, 1.0, 0.8, 0.5][index];
              return Container(
                width: 32,
                height: 120 * height,
                decoration: BoxDecoration(
                  color: Color(0xFF3B82F6).withOpacity(0.6),
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  // Widget _buildBottomStats() {
  //   return Container(
  //     margin: EdgeInsets.fromLTRB(24, 16, 24, 40),
  //     child: Row(
  //       children: [
  //         Expanded(
  //           child: Container(
  //             padding: EdgeInsets.all(32),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(24),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black.withOpacity(0.1),
  //                   blurRadius: 30,
  //                   offset: Offset(0, 15),
  //                 ),
  //               ],
  //             ),
  //             child: Column(
  //               children: [
  //                 Icon(Icons.speed, size: 48, color: Color(0xFF10B981)), // ✅ Fixed: Icons.efficiency → Icons.speed
  //                 SizedBox(height: 16),
  //                 Text(
  //                   '94%',
  //                   style: TextStyle(
  //                     fontSize: 36,
  //                     fontWeight: FontWeight.w800,
  //                     color: Color(0xFF10B981),
  //                   ),
  //                 ),
  //                 Text(
  //                   'Efficiency',
  //                   style: TextStyle(color: Colors.grey[600], fontSize: 16),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //         SizedBox(width: 24),
  //         Expanded(
  //           child: Container(
  //             padding: EdgeInsets.all(32),
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(24),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.black.withOpacity(0.1),
  //                   blurRadius: 30,
  //                   offset: Offset(0, 15),
  //                 ),
  //               ],
  //             ),
  //             child: Column(
  //               children: [
  //                 Icon(Icons.people, size: 48, color: Color(0xFF3B82F6)),
  //                 SizedBox(height: 16),
  //                 Text(
  //                   '48',
  //                   style: TextStyle(
  //                     fontSize: 36,
  //                     fontWeight: FontWeight.w800,
  //                     color: Color(0xFF3B82F6),
  //                   ),
  //                 ),
  //                 Text(
  //                   Text(
  //                   'Admissions',
  //                   style: TextStyle(color: Colors.grey[600], fontSize: 16),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _neumorphicButton(String text, Color bgColor, Color textColor, IconData icon, {bool isPrimary = false}) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        color: isPrimary ? bgColor : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: bgColor.withOpacity(0.3),
                  blurRadius: 20,
                  offset: Offset(0, 8),
                ),
              ]
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: Offset(4, 8),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.8),
                  blurRadius: 20,
                  offset: Offset(-4, -8),
                ),
              ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {},
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, color: isPrimary ? Colors.white : Colors.grey[500], size: 20),
                SizedBox(width: 8),
                Text(
                  text,
                  style: TextStyle(
                    color: isPrimary ? textColor : Colors.grey[700],
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}