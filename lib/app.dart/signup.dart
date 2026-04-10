import 'package:flutter/material.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isPatientSelected = true;
  bool _passwordVisible = true;
  bool _confirmPasswordVisible = true;

  // Controllers for SEPARATE fields
  final _nameController = TextEditingController();
  final _patientEmailController = TextEditingController();
  final _patientPasswordController = TextEditingController();
  final _patientConfirmPasswordController = TextEditingController();
  final _doctorEmailController = TextEditingController();
  final _doctorPasswordController = TextEditingController();
  final _doctorConfirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _patientEmailController.dispose();
    _patientPasswordController.dispose();
    _patientConfirmPasswordController.dispose();
    _doctorEmailController.dispose();
    _doctorPasswordController.dispose();
    _doctorConfirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: SafeArea(
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

                    SizedBox(height: 50 ),

                    // 🔥 NAME FIELD (Always visible)
                    _buildSignupCard(
                      context,
                      'Full Name',
                      _nameController,
                      Icons.person_outline,
                      false,
                    ),

                    SizedBox(height: 20),

                    // 🔥 PATIENT FIELDS
                    AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      child: _isPatientSelected
                          ? _buildSignupCard(
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
                          ? _buildSignupCard(
                              context,
                              'Patient Password',
                              _patientPasswordController,
                              Icons.lock_outline,
                              true,
                              passwordVisible: _passwordVisible,
                              onVisibilityChanged: () => setState(
                                () => _passwordVisible = !_passwordVisible,
                              ),
                            )
                          : SizedBox(),
                    ),

                    AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      child: _isPatientSelected
                          ? _buildSignupCard(
                              context,
                              'Confirm Password',
                              _patientConfirmPasswordController,
                              Icons.lock_outline,
                              true,
                              passwordVisible: _confirmPasswordVisible,
                              onVisibilityChanged: () => setState(
                                () => _confirmPasswordVisible =
                                    !_confirmPasswordVisible,
                              ),
                            )
                          : SizedBox(height: 20),
                    ),

                    SizedBox(),

                    // 🔥 DOCTOR FIELDS
                    AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      child: !_isPatientSelected
                          ? _buildSignupCard(
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
                          ? _buildSignupCard(
                              context,
                              'Doctor Password',
                              _doctorPasswordController,
                              Icons.lock_outline,
                              true,
                              passwordVisible: _passwordVisible,
                              onVisibilityChanged: () => setState(
                                () => _passwordVisible = !_passwordVisible,
                              ),
                            )
                          : SizedBox(),
                    ),

                    AnimatedContainer(
                      duration: Duration(milliseconds: 400),
                      curve: Curves.easeInOut,
                      child: !_isPatientSelected
                          ? _buildSignupCard(
                              context,
                              'Confirm Password',
                              _doctorConfirmPasswordController,
                              Icons.lock_outline,
                              true,
                              passwordVisible: _confirmPasswordVisible,
                              onVisibilityChanged: () => setState(
                                () => _confirmPasswordVisible =
                                    !_confirmPasswordVisible,
                              ),
                            )
                          : SizedBox(),
                    ),

                    SizedBox(height: 40),

                    // Sign Up Button
                    Container(
                      width: double.infinity,
                      height: 56,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.teal.shade500, Colors.teal.shade600],
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
                          // No logic - just show message
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                _isPatientSelected
                                    ? 'Patient signup coming soon!'
                                    : 'Doctor signup coming soon!',
                              ),
                              backgroundColor: Colors.teal,
                            ),
                          );
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
                              ? 'SIGN UP AS PATIENT'
                              : 'SIGN UP AS DOCTOR',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔥 Custom Signup Card Widget
  Widget _buildSignupCard(
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
      child: TextField(
        controller: controller,
        obscureText: isPassword ? !passwordVisible : false,
        keyboardType: label.contains('Email')
            ? TextInputType.emailAddress
            : TextInputType.text,
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
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        ),
      ),
    );
  }
}
