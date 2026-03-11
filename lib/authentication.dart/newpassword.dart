import 'package:flutter/material.dart';
import 'package:flutter_application_1/app.dart/screens.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() =>
      _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  // Password visibility toggles
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;

  // Password strength indicators (simulated - based on user input)
  bool _hasMinLength = false;
  bool _hasUppercase = false;
  bool _hasNumber = false;
  bool _hasSpecialChar = false;

  // Text controllers
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Check password strength requirements
  void _checkPasswordStrength(String password) {
    setState(() {
      _hasMinLength = password.length >= 8;
      _hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
      _hasNumber = RegExp(r'[0-9]').hasMatch(password);
      _hasSpecialChar = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Healthcare professional color palette
    const Color primaryTeal = Color(0xFF00897B); // Medical Teal
    const Color softBackground = Color(0xFFF5F7FA); // Light Grey Background
    const Color cardWhite = Colors.white;
    const Color textDark = Color(0xFF1A1A1A);
    const Color textGrey = Color(0xFF6B7280);
    const Color successGreen = Color(0xFF10B981);
    const Color borderDefault = Color(0xFFE5E7EB);

    return Scaffold(
      backgroundColor: softBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Card(
              elevation: 6,
              shadowColor: Colors.black.withOpacity(0.08),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: cardWhite,
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 1. Back Arrow Icon
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: softBackground,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: primaryTeal,
                          size: 20,
                        ),
                      ),
                    ),
                    // const SizedBox(height: 24),

                    // 2. Lock/Security Icon
                    // Center(
                    //   child: Container(
                    //     padding: const EdgeInsets.all(16),
                    //     decoration: BoxDecoration(
                    //       color: primaryTeal.withOpacity(0.1),
                    //       shape: BoxShape.circle,
                    //     ),
                    //     child: const Icon(
                    //       Icons.lock_outline_rounded,
                    //       color: primaryTeal,
                    //       size: 40,
                    //     ),
                    //   ),
                    // ),
                    const SizedBox(height: 20),

                    // 3. Title: "Reset Password"
                    const Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryTeal,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),

                    // 4. Main Heading: "Create New Password"
                    const Text(
                      'Create New Password',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: textDark,
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Subtext
                    const Text(
                      'Your new password must be different from previously used passwords.',
                      style: TextStyle(
                        fontSize: 15,
                        color: textGrey,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // 5. New Password Input Field
                    TextField(
                      controller: _newPasswordController,
                      obscureText: _obscureNewPassword,
                      onChanged: _checkPasswordStrength,
                      decoration: InputDecoration(
                        labelText: 'New Password',
                        hintText: 'Enter new password',
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: primaryTeal,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureNewPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: textGrey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureNewPassword = !_obscureNewPassword;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: softBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: borderDefault),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: borderDefault),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: primaryTeal,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 16.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 6. Confirm Password Input Field
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: _obscureConfirmPassword,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        hintText: 'Re-enter new password',
                        prefixIcon: const Icon(
                          Icons.lock_outline_rounded,
                          color: primaryTeal,
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                            color: textGrey,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                        ),
                        filled: true,
                        fillColor: softBackground,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: borderDefault),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: borderDefault),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: primaryTeal,
                            width: 2,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal: 16.0,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // 7. Password Strength Requirements
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: softBackground,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Password requirements:',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: textDark,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildRequirementRow(
                            'At least 8 characters',
                            _hasMinLength,
                            successGreen,
                            textGrey,
                          ),
                          const SizedBox(height: 8),
                          _buildRequirementRow(
                            'One uppercase letter',
                            _hasUppercase,
                            successGreen,
                            textGrey,
                          ),
                          const SizedBox(height: 8),
                          _buildRequirementRow(
                            'One number',
                            _hasNumber,
                            successGreen,
                            textGrey,
                          ),
                          const SizedBox(height: 8),
                          _buildRequirementRow(
                            'One special character',
                            _hasSpecialChar,
                            successGreen,
                            textGrey,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 28),

                    // 8. Primary Reset Password Button
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AuthScreen(),
                            ),
                            (route) => false,
                          );
                          // Password reset logic would go here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryTeal,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text(
                          'Reset Password',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget for password requirement rows
  Widget _buildRequirementRow(
    String text,
    bool isMet,
    Color activeColor,
    Color inactiveColor,
  ) {
    return Row(
      children: [
        Icon(
          isMet ? Icons.check_circle : Icons.circle_outlined,
          size: 18,
          color: isMet ? activeColor : inactiveColor,
        ),
        const SizedBox(width: 10),
        Text(
          text,
          style: TextStyle(
            fontSize: 13,
            color: isMet ? activeColor : inactiveColor,
            fontWeight: isMet ? FontWeight.w500 : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
