import 'package:flutter/material.dart';
import 'dart:math' as math;


class HospitalSystemApp extends StatelessWidget {
  const HospitalSystemApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hospital System',
      theme: ThemeData(
        fontFamily: 'Inter',
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF8FAFC),
      ),
      home: ReportPreviewScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ReportPreviewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: CustomScrollView(
        slivers: [
          // 🔝 Fixed Top Header with Glassmorphism
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 80,
            backgroundColor: Colors.white.withOpacity(0.95),
            elevation: 0,
            forceElevated: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 20,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
            title: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios_new, size: 18, color: Color(0xFF64748B)),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                ),
                SizedBox(width: 12),
                Text(
                  'Report Preview',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
            actions: [
              CircleAvatar(
                radius: 22,
                backgroundColor: Color(0xFF3B82F6),
                child: Text(
                  'JV',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              SizedBox(width: 24),
            ],
          ),
          
          // Main Content - Centered narrow layout
          SliverToBoxAdapter(
            child: Container(
              constraints: BoxConstraints(maxWidth: 900),
              margin: EdgeInsets.fromLTRB(48, 80, 48, 48),
              child: Column(
                children: [
                  // ✅ Main Hero Section
                  Stack(
                    clipBehavior: Clip.none,
                    alignment: Alignment.center,
                    children: [
                      // Soft blue glow background
                      Positioned(
                        top: -40,
                        child: Container(
                          width: 240,
                          height: 240,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xFF3B82F6).withOpacity(0.25),
                                blurRadius: 100,
                                spreadRadius: -20,
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Success circle container
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Color(0xFF60A5FA),
                              Color(0xFF3B82F6),
                              Color(0xFF1D4ED8),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF3B82F6).withOpacity(0.4),
                              blurRadius: 40,
                              offset: Offset(0, 20),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 72,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 48),
                  
                  // Hero Text
                  Text(
                    'Report Ready for Review',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF1E293B),
                      height: 1.1,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      'Your clinical analysis has been securely compiled and is ready for download.',
                      style: TextStyle(
                        fontSize: 20,
                        color: Color(0xFF64748B),
                        height: 1.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 80),

                  // 📊 Report Summary Bento Grid
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 🔷 Left Large Card (Main Details)
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: EdgeInsets.all(48),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(36),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.08),
                                blurRadius: 50,
                                offset: Offset(0, 25),
                              ),
                            ],
                            border: Border.all(
                              color: Color(0xFF3B82F6).withOpacity(0.15),
                              width: 1,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Label badge
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFF3B82F6).withOpacity(0.15),
                                      Color(0xFF1D4ED8).withOpacity(0.1),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                child: Text(
                                  'Report Summary',
                                  style: TextStyle(
                                    color: Color(0xFF3B82F6),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                              SizedBox(height: 32),
                              
                              // Main title
                              Text(
                                'Comprehensive Patient Analytics',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1E293B),
                                  height: 1.1,
                                ),
                              ),
                              SizedBox(height: 48),
                              
                              // Date Range Row
                              _detailRow(
                                icon: Icons.calendar_month,
                                label: 'Date Range',
                                value: 'Jan 2024 – Mar 2024',
                                iconColor: Color(0xFF3B82F6),
                              ),
                              SizedBox(height: 24),
                              
                              // Generated Time Row
                              _detailRow(
                                icon: Icons.schedule,
                                label: 'Generated',
                                value: '2 minutes ago',
                                iconColor: Color(0xFF10B981),
                              ),
                              SizedBox(height: 40),
                              
                              // Divider
                              Container(
                                height: 1,
                                width: double.infinity,
                                color: Color(0xFFE2E8F0),
                              ),
                              SizedBox(height: 32),
                              
                              // Security Badges Row
                              Row(
                                children: [
                                  _securityBadge(Icons.lock_outline, 'AES-256 Encryption', Colors.green),
                                  SizedBox(width: 16),
                                  _securityBadge(Icons.verified_user, 'HIPAA Compliant', Color(0xFF3B82F6)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      
                      SizedBox(width: 40),
                      
                      // 🔶 Right Side Cards (Stacked)
                      Expanded(
                        child: Column(
                          children: [
                            // File Format Card
                            _infoCard(
                              icon: Icons.picture_as_pdf_rounded,
                              label: 'File Format',
                              value: 'PDF Document',
                              iconColor: Color(0xFFEC4899),
                            ),
                            SizedBox(height: 32),
                            
                            // File Size Card
                            _infoCard(
                              icon: Icons.storage_rounded,
                              label: 'File Size',
                              value: '12.4 MB',
                              iconColor: Color(0xFF10B981),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 80),

                  // 🎯 Action Buttons Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Primary Button - Download
                      Container(
                        height: 72,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [Color(0xFF4F46E5), Color(0xFF3B82F6)],
                          ),
                          borderRadius: BorderRadius.circular(40),
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xFF4F46E5).withOpacity(0.4),
                              blurRadius: 40,
                              offset: Offset(0, 20),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(40),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(40),
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 56, vertical: 22),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.download_rounded, color: Colors.white, size: 28),
                                  SizedBox(width: 16),
                                  Text(
                                    'Download Report',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      
                      SizedBox(width: 32),
                      
                      // Secondary Button - Share
                      Container(
                        height: 72,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                            color: Color(0xFF3B82F6).withOpacity(0.3),
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 30,
                              offset: Offset(0, 15),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(40),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(40),
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 22),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.share_rounded, color: Color(0xFF3B82F6), size: 24),
                                  SizedBox(width: 12),
                                  Text(
                                    'Share via Secure Portal',
                                    style: TextStyle(
                                      color: Color(0xFF3B82F6),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 100),

                  // ✨ Bottom Decorative Element
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.85),
                      borderRadius: BorderRadius.circular(32),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 40,
                          offset: Offset(0, 20),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Sparkline-style visual divider
                        Container(
                          height: 60,
                          child: CustomPaint(
                            painter: AnalyticsSparklinePainter(),
                            size: Size(double.infinity, 60),
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          'Hospital System Analytics v4.2',
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF94A3B8),
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
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
    );
  }

  // Helper widgets
  Widget _detailRow({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: iconColor.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(icon, color: iconColor, size: 24),
        ),
        SizedBox(width: 24),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 15,
                color: Color(0xFF64748B),
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _securityBadge(IconData icon, String text, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 20),
          SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoCard({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: iconColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 25,
            offset: Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 36),
          ),
          SizedBox(height: 24),
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Color(0xFF64748B),
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: Color(0xFF1E293B),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class AnalyticsSparklinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Background gradient
    final bgPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.transparent, Color(0xFF3B82F6).withOpacity(0.05)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;
    
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    // Main sparkline
    final linePaint = Paint()
      ..color = Color(0xFF3B82F6)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final points = [
      Offset(20, size.height * 0.7),
      Offset(size.width * 0.25, size.height * 0.3),
      Offset(size.width * 0.45, size.height * 0.65),
      Offset(size.width * 0.65, size.height * 0.25),
      Offset(size.width * 0.85, size.height * 0.45),
      Offset(size.width - 20, size.height * 0.55),
    ];

    final path = Path();
    path.addPolygon(points, false);
    canvas.drawPath(path, linePaint);

    // Data points (dots)
    final dotPaint = Paint()
      ..color = Color(0xFF3B82F6)
      ..style = PaintingStyle.fill;
    
    for (var point in points) {
      canvas.drawCircle(point, 6, dotPaint);
    }

    // Highlight glow on key points
    final glowPaint = Paint()
      ..color = Color(0xFF3B82F6).withOpacity(0.3)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 4);
    
    canvas.drawCircle(points[3], 8, glowPaint); // Peak point glow
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
