import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     //  implement build
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: AuthScreen(),
//     );
//   }
// }

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0,
          title: const Text(
            "Hospital Management System",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            // This customizes the look of the tabs
            indicatorColor: Colors.white,
            indicatorWeight: 4,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white60,
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            tabs: [
              Tab(text: "LOGIN"),
              Tab(text: "SIGN UP"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // Login Tab Content
            LoginTab(),
            // Signup Tab Content
            SignupTab(),
          ],
        ),
      ),
    );
  }
}

// LOGIN WIDGET
class LoginTab extends StatelessWidget {
  const LoginTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 40),
          const Icon(Icons.local_hospital, size: 80, color: Colors.teal),
          const SizedBox(height: 20),
          const Text(
            "Welcome Back",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          // Email Field
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: _inputDecoration("Email Address", Icons.email_outlined),
          ),
          const SizedBox(height: 16),
          // Password Field
          TextFormField(
            obscureText: true,
            decoration: _inputDecoration("Password", Icons.lock_outline),
          ),
          const SizedBox(height: 10),
          // Forgot Password
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/forgot');
              },
              child: const Text(
                "Forgot Password?",
                style: TextStyle(color: Colors.teal),
              ),
            ),
          ),
          const SizedBox(height: 20),
          // Login Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/dashboard');

              // Implement Login Logic
              debugPrint("Login Clicked");
            },
            child: const Text(
              "LOGIN",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// SIGNUP WIDGET

class SignupTab extends StatelessWidget {
  const SignupTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 20),
          const Text(
            "Create Account",
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),

          // Name Field
          TextFormField(
            decoration: _inputDecoration("Full Name", Icons.person_outline),
          ),
          const SizedBox(height: 16),

          // Email Field
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: _inputDecoration("Email Address", Icons.email_outlined),
          ),
          const SizedBox(height: 16),

          // Role Dropdown (Crucial for Hospital System)
          DropdownButtonFormField<String>(
            initialValue: "Patient",
            decoration: _inputDecoration("Role", Icons.badge_outlined),
            items: const [
              DropdownMenuItem(value: "Patient", child: Text("Patient")),
              DropdownMenuItem(value: "Doctor", child: Text("Doctor")),
              DropdownMenuItem(value: "Admin", child: Text("Admin Staff")),
            ],
            onChanged: (value) {},
          ),
          const SizedBox(height: 16),

          // Password Field
          TextFormField(
            obscureText: true,
            decoration: _inputDecoration("Password", Icons.lock_outline),
          ),
          const SizedBox(height: 16),

          // Confirm Password Field
          TextFormField(
            obscureText: true,
            decoration: _inputDecoration(
              "Confirm Password",
              Icons.lock_outline,
            ),
          ),
          const SizedBox(height: 30),

          // Signup Button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              //implemet signup
              debugPrint("Signup Clicked");
            },
            child: const Text(
              "SIGN UP",
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper function for consistent styling
InputDecoration _inputDecoration(String label, IconData icon) {
  return InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, color: Colors.teal),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.transparent),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.teal, width: 2),
    ),
  );
}
