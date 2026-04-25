import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isPatientSelected = true;
  bool _patientPasswordVisible = true;
  bool _doctorPasswordVisible = true;
  // Controllers for SEPARATE fields
  final _patientEmailController = TextEditingController();
  final _patientPasswordController = TextEditingController();
  final _doctorEmailController = TextEditingController();
  final _doctorPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _patientEmailController.dispose();
    _patientPasswordController.dispose();
    _doctorEmailController.dispose();
    _doctorPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: SafeArea(
        child: Form(
          key: _formKey,

          child: SingleChildScrollView(
            child: Column(
              children: [
                // 🔥 HOSPITAL LOGO + HEADER
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade600, Colors.teal.shade400],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.local_hospital, size: 80, color: Colors.white),
                      SizedBox(height: 20),
                      Text(
                        'Hospital Management',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'System',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: [
                      // Patient/Doctor Toggle
                      Container(
                        padding: EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.08),
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => _isPatientSelected = true),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 18,
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _isPatientSelected
                                        ? Colors.teal
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.person,
                                        color: _isPatientSelected
                                            ? Colors.white
                                            : Color(0xFF64748B),
                                        size: 22,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Patient',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: _isPatientSelected
                                              ? Colors.white
                                              : Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => _isPatientSelected = false),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                    vertical: 18,
                                    horizontal: 20,
                                  ),
                                  decoration: BoxDecoration(
                                    color: !_isPatientSelected
                                        ? Colors.teal
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.local_hospital_outlined,
                                        color: !_isPatientSelected
                                            ? Colors.white
                                            : Color(0xFF64748B),
                                        size: 22,
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        'Doctor',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: !_isPatientSelected
                                              ? Colors.white
                                              : Color(0xFF64748B),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 40),

                      // 🔥 PATIENT FIELDS
                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        child: _isPatientSelected
                            ? _buildLoginCard(
                                context,
                                'Patient Email',
                                _patientEmailController,
                                Icons.email_outlined,
                                false,
                              )
                            : SizedBox(),
                      ),

                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        child: _isPatientSelected
                            ? _buildLoginCard(
                                context,
                                'Patient Password',
                                _patientPasswordController,
                                Icons.lock_outline,
                                true,
                                passwordVisible: _patientPasswordVisible,
                                onVisibilityChanged: () => setState(
                                  () => _patientPasswordVisible =
                                      !_patientPasswordVisible,
                                ),
                              )
                            : SizedBox(),
                      ),

                      SizedBox(height: 30),

                      // 🔥 DOCTOR FIELDS
                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        child: !_isPatientSelected
                            ? _buildLoginCard(
                                context,
                                'Doctor Email',
                                _doctorEmailController,
                                Icons.email_outlined,
                                false,
                              )
                            : SizedBox(),
                      ),

                      AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        child: !_isPatientSelected
                            ? _buildLoginCard(
                                context,
                                'Doctor Password',
                                _doctorPasswordController,
                                Icons.lock_outline,
                                true,
                                passwordVisible: _doctorPasswordVisible,
                                onVisibilityChanged: () => setState(
                                  () => _doctorPasswordVisible =
                                      !_doctorPasswordVisible,
                                ),
                              )
                            : SizedBox(),
                      ),

                      SizedBox(height: 30),

                      // Login Button
                      // Login Button - NEW CODE (PASTE THIS)
                      Container(
                        width: double.infinity,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.teal.shade500,
                              Colors.teal.shade600,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.teal.withOpacity(0.3),
                              blurRadius: 15,
                              offset: Offset(0, 6),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            // 🔥 THIS ONE LINE FIXES EVERYTHING
                            if (_formKey.currentState!.validate()) {
                              if (_isPatientSelected) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  '/dashboard',
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Doctor Dashboard Coming Soon!',
                                    ),
                                  ),
                                );
                              }
                            }    
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: Text(
                            _isPatientSelected
                                ? 'PATIENT LOGIN'
                                : 'DOCTOR LOGIN',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      TextButton(
                        onPressed: () =>
                            Navigator.pushNamed(context, '/forgot'),
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            color: Colors.teal.shade600,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have account? "),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/signup'),
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.teal),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔥 Custom Login Card Widget
  Widget _buildLoginCard(
    BuildContext context,
    String label,
    TextEditingController controller,
    IconData icon,
    bool isPassword, {
    bool passwordVisible = true,
    VoidCallback? onVisibilityChanged,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        // 🔥 TextFormField (NOT TextField)
        controller: controller,
        obscureText: isPassword ? !passwordVisible : false,
        keyboardType: label.contains('Email')
            ? TextInputType.emailAddress
            : TextInputType.text,

        // 🔥 VALIDATION
        validator: (value) {
          if (value == null || value.isEmpty) {
            return label.contains('Email')
                ? 'Email required'
                : 'Password required';
          }
          if (label.contains('Email')) {
            if (!value.contains('@')) return 'Enter valid email';
          } else {
            if (value.length < 6) return 'Password 6+ characters';
          }
          return null;
        },

        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.teal.shade600),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    passwordVisible ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: onVisibilityChanged,
                )
              : null,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.teal.shade400, width: 2),
          ),
          // 🔥 RED ERROR BORDER
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(color: Colors.red, width: 2),
          ),
          errorStyle: TextStyle(color: Colors.red, fontSize: 12),
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
      ),
    );
  }
}
