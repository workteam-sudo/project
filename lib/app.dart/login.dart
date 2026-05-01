import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/authentication.dart/auth_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _authService = AuthService();
  bool _isPatientSelected = true;
  bool _passwordVisible = false;
  bool _isLoading = false;
  String? _lastAuthErrorCode;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    try {
      final role = await _authService.signIn(
        email: _emailController.text,
        password: _passwordController.text,
        selectedRole: _isPatientSelected ? UserRole.patient : UserRole.doctor,
      );

      if (!mounted) return;
      final route = role == UserRole.doctor ? '/doctordashboard' : '/dashboard';
      Navigator.pushNamedAndRemoveUntil(context, route, (_) => false);
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      setState(() => _lastAuthErrorCode = e.code);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Login failed')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Icon(Icons.local_hospital, size: 80, color: Colors.teal.shade600),
                  const SizedBox(height: 20),
                  const Text(
                    'Hospital Login',
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 30),
                  _buildRoleToggle(),
                  const SizedBox(height: 24),
                  _buildField(
                    controller: _emailController,
                    label: _isPatientSelected ? 'Patient Email' : 'Doctor Email',
                    icon: Icons.email_outlined,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email is required';
                      }
                      if (!value.contains('@')) return 'Enter a valid email';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  _buildField(
                    controller: _passwordController,
                    label: 'Password',
                    icon: Icons.lock_outline,
                    obscureText: !_passwordVisible,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _passwordVisible ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() => _passwordVisible = !_passwordVisible);
                      },
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) return 'Password is required';
                      if (value.length < 6) return 'Password must be at least 6 characters';
                      return null;
                    },
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/forgot'),
                      child: const Text('Forgot Password?'),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _handleLogin,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        child: _isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text(
                                _isPatientSelected ? 'LOGIN AS PATIENT' : 'LOGIN AS DOCTOR',
                                style: const TextStyle(fontWeight: FontWeight.bold),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (_lastAuthErrorCode == 'email-not-verified')
                    TextButton(
                      onPressed: _isLoading ? null : _resendVerification,
                      child: const Text('Resend verification email'),
                    ),
                  if (_lastAuthErrorCode == 'operation-not-allowed')
                    const Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Text(
                        'Email/password provider appears disabled in Firebase Auth settings.',
                        style: TextStyle(color: Colors.red),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                        onPressed: () => Navigator.pushNamed(context, '/signup'),
                        child: const Text('Sign up'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRoleToggle() {
    return Row(
      children: [
        Expanded(
          child: ChoiceChip(
            label: const Text('Patient'),
            selected: _isPatientSelected,
            onSelected: (_) => setState(() => _isPatientSelected = true),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ChoiceChip(
            label: const Text('Doctor'),
            selected: !_isPatientSelected,
            onSelected: (_) => setState(() => _isPatientSelected = false),
          ),
        ),
      ],
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required FormFieldValidator<String> validator,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
      ),
    );
  }

  Future<void> _resendVerification() async {
    if (_emailController.text.trim().isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Enter email and password to resend verification.')),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await _authService.resendVerificationEmail(
        email: _emailController.text,
        password: _passwordController.text,
      );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verification email sent. Check inbox/spam.')),
      );
    } on FirebaseAuthException catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Could not resend verification email')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}
