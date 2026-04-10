// import 'package:flutter/material.dart';

// class AuthScreen extends StatelessWidget {
//   const AuthScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         backgroundColor: Colors.grey[100],
//         appBar: AppBar(
//           backgroundColor: Colors.teal,
//           elevation: 0,
//           title: const Text(
//             "Hospital Management System",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: 24,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           centerTitle: true,
//           bottom: const TabBar(
//             // This customizes the look of the tabs
//             indicatorColor: Colors.white,
//             indicatorWeight: 4,
//             labelColor: Colors.white,
//             unselectedLabelColor: Colors.white60,
//             labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             tabs: [
//               Tab(text: "LOGIN"),
//               Tab(text: "SIGN UP"),
//             ],
//           ),
//         ),
//         body: const TabBarView(
//           children: [
//             // Login Tab Content
//             LoginTab(),
//             // Signup Tab Content
//             SignupTab(),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // LOGIN WIDGET
// class LoginTab extends StatelessWidget {
//   const LoginTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const SizedBox(height: 40),
//           const Icon(Icons.local_hospital, size: 80, color: Colors.teal),
//           const SizedBox(height: 20),
//           const Text(
//             "Welcome Back",
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 16),

//           DropdownButtonFormField<String>(
//             initialValue: "Patient",
//             decoration: _inputDecoration("Role", Icons.badge_outlined),
//             items: const [
//               DropdownMenuItem(value: "Patient", child: Text("Patient")),
//               DropdownMenuItem(value: "Doctor", child: Text("Doctor")),
//               DropdownMenuItem(value: "Admin", child: Text("Admin Staff")),
//             ],
//             onChanged: (value) {},
//           ),
//           const SizedBox(height: 16),
//           // Email Field
//           TextFormField(
//             keyboardType: TextInputType.emailAddress,
//             decoration: _inputDecoration("Email Address", Icons.email_outlined),
//           ),
//           const SizedBox(height: 16),
//           // Password Field
//           TextFormField(
//             obscureText: true,
//             decoration: _inputDecoration("Password", Icons.lock_outline),
//           ),
//           const SizedBox(height: 10),
//           // Forgot Password
//           Align(
//             alignment: Alignment.centerRight,
//             child: TextButton(
//               onPressed: () {
//                 Navigator.pushNamed(context, '/forgot');
//               },
//               child: const Text(
//                 "Forgot Password?",
//                 style: TextStyle(color: Colors.teal),
//               ),
//             ),
//           ),
//           const SizedBox(height: 20),
//           // Login Button
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.teal,
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             onPressed: () {
//               Navigator.pushNamed(context, '/dashboard');

//               // Implement Login Logic
//               debugPrint("Login Clicked");
//             },
//             child: const Text(
//               "LOGIN",
//               style: TextStyle(fontSize: 18, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // SIGNUP WIDGET

// class SignupTab extends StatelessWidget {
//   const SignupTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(24),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           const SizedBox(height: 20),
//           const Text(
//             "Create Account",
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Colors.black87,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           const SizedBox(height: 30),

//           // Name Field
//           TextFormField(
//             decoration: _inputDecoration("Full Name", Icons.person_outline),
//           ),
//           const SizedBox(height: 16),

//           // Email Field
//           TextFormField(
//             keyboardType: TextInputType.emailAddress,
//             decoration: _inputDecoration("Email Address", Icons.email_outlined),
//           ),
//           const SizedBox(height: 16),
//           DropdownButtonFormField<String>(
//             initialValue: "Patient",
//             decoration: _inputDecoration("Role", Icons.badge_outlined),
//             items: const [
//               DropdownMenuItem(value: "Patient", child: Text("Patient")),
//               DropdownMenuItem(value: "Doctor", child: Text("Doctor")),
//               DropdownMenuItem(value: "Admin", child: Text("Admin Staff")),
//             ],
//             onChanged: (value) {},
//           ),

//           // Role Dropdown (Crucial for Hospital System)
//           const SizedBox(height: 16),

//           // Password Field
//           TextFormField(
//             obscureText: true,
//             decoration: _inputDecoration("Password", Icons.lock_outline),
//           ),
//           const SizedBox(height: 16),

//           // Confirm Password Field
//           TextFormField(
//             obscureText: true,
//             decoration: _inputDecoration(
//               "Confirm Password",
//               Icons.lock_outline,
//             ),
//           ),
//           const SizedBox(height: 30),

//           // Signup Button
//           ElevatedButton(
//             style: ElevatedButton.styleFrom(
//               backgroundColor: Colors.teal,
//               padding: const EdgeInsets.symmetric(vertical: 16),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//             ),
//             onPressed: () {
//               //implemet signup
//               debugPrint("Signup Clicked");
//             },
//             child: const Text(
//               "SIGN UP",
//               style: TextStyle(fontSize: 18, color: Colors.white),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // Helper function for consistent styling
// InputDecoration _inputDecoration(String label, IconData icon) {
//   return InputDecoration(
//     labelText: label,
//     prefixIcon: Icon(icon, color: Colors.teal),
//     filled: true,
//     fillColor: Colors.white,
//     border: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: BorderSide.none,
//     ),
//     enabledBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: const BorderSide(color: Colors.transparent),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderRadius: BorderRadius.circular(12),
//       borderSide: const BorderSide(color: Colors.teal, width: 2),
//     ),
//   );
// }
// import 'package:flutter/material.dart';

// class LoginPage extends StatefulWidget {
//   @override
//   _LoginPageState createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage>
//     with SingleTickerProviderStateMixin {
//   bool _isPatientSelected = true;
//   bool _obscurePassword = true;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   late AnimationController _toggleController;
//   late Animation<double> _toggleAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _toggleController = AnimationController(
//       duration: Duration(milliseconds: 300),
//       vsync: this,
//     );
//     _toggleAnimation = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(parent: _toggleController, curve: Curves.easeInOut),
//     );
//   }

//   @override
//   void dispose() {
//     _toggleController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   void _onRoleToggle(bool isPatient) {
//     setState(() {
//       _isPatientSelected = isPatient;
//     });
//     if (isPatient) {
//       _toggleController.forward();
//     } else {
//       _toggleController.reverse();
//     }
//   }

//   void _login() {
//     // Login logic here
//     String role = _isPatientSelected ? 'Patient' : 'Doctor';
//    debugPrint('Logging in as $role');
//     debugPrint('Email: ${_emailController.text}');
//    debugPrint('Password: ${_passwordController.text}');

//     // Navigate to respective dashboard
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => _isPatientSelected
//             ? PatientDashboard()
//             : DoctorDashboard(),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color(0xFFF8FAFC),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
//           child: Column(
//             children: [
//               // Header Section
//               _buildHeader(),

//               SizedBox(height: 60),

//               // Main Card
//               Container(
//                 width: double.infinity,
//                 constraints: BoxConstraints(maxWidth: 450),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(24),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.black.withOpacity(0.08),
//                       blurRadius: 30,
//                       offset: Offset(0, 10),
//                     ),
//                   ],
//                 ),
//                 padding: EdgeInsets.all(32),
//                 child: Column(
//                   children: [
//                     // Role Toggle
//                     _buildRoleToggle(),

//                     SizedBox(height: 32),

//                     // Email Field
//                     _buildTextField(
//                       label: 'Email Address',
//                       icon: Icons.email_outlined,
//                       controller: _emailController,
//                       keyboardType: TextInputType.emailAddress,
//                     ),

//                     SizedBox(height: 20),

//                     // Password Field
//                     _buildPasswordField(),

//                     SizedBox(height: 16),

//                     // Forgot Password
//                     _buildForgotPassword(),

//                     SizedBox(height: 32),

//                     // Login Button
//                     _buildLoginButton(),
//                   ],
//                 ),
//               ),

//               SizedBox(height: 40),

//               // Bottom Section
//               _buildBottomSection(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildHeader() {
//     return Column(
//       children: [
//         Container(
//           padding: EdgeInsets.all(24),
//           decoration: BoxDecoration(
//             color: Colors.teal.withOpacity(0.1),
//             shape: BoxShape.circle,
//           ),
//           child: Icon(
//             Icons.local_hospital,
//             size: 64,
//             color: Color(0xFF14B8A6),
//           ),
//         ),
//         SizedBox(height: 24),
//         Text(
//           'Hospital Management System',
//           style: TextStyle(
//             fontSize: 28,
//             fontWeight: FontWeight.w700,
//             color: Colors.black87,
//             letterSpacing: -0.5,
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           'Log In',
//           style: TextStyle(
//             fontSize: 32,
//             fontWeight: FontWeight.w800,
//             color: Color(0xFF1E293B),
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           'Access your dashboard to manage hospital services efficiently.',
//           style: TextStyle(
//             fontSize: 16,
//             color: Color(0xFF64748B),
//             height: 1.5,
//           ),
//           textAlign: TextAlign.center,
//         ),
//       ],
//     );
//   }

//   Widget _buildRoleToggle() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Color(0xFFF1F5F9),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Color(0xFFE2E8F0)),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: GestureDetector(
//               onTap: () => _onRoleToggle(true),
//               child: AnimatedContainer(
//                 duration: Duration(milliseconds: 300),
//                 padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//                 decoration: BoxDecoration(
//                   color: _isPatientSelected
//                       ? Color(0xFF14B8A6)
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.person,
//                       color: _isPatientSelected
//                           ? Colors.white
//                           : Color(0xFF64748B),
//                       size: 20,
//                     ),
//                     SizedBox(width: 8),
//                     Text(
//                       'Patient Access',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: _isPatientSelected
//                             ? Colors.white
//                             : Color(0xFF475569),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: GestureDetector(
//               onTap: () => _onRoleToggle(false),
//               child: AnimatedContainer(
//                 duration: Duration(milliseconds: 300),
//                 padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//                 decoration: BoxDecoration(
//                   color: !_isPatientSelected
//                       ? Color(0xFF14B8A6)
//                       : Colors.transparent,
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.local_hospital_outlined,
//                       color: !_isPatientSelected
//                           ? Colors.white
//                           : Color(0xFF64748B),
//                       size: 20,
//                     ),
//                     SizedBox(width: 8),
//                     Text(
//                       'Doctor Access',
//                       style: TextStyle(
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                         color: !_isPatientSelected
//                             ? Colors.white
//                             : Color(0xFF475569),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildTextField({
//     required String label,
//     required IconData icon,
//     required TextEditingController controller,
//     TextInputType? keyboardType,
//   }) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Color(0xFFF8FAFC),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Color(0xFFE2E8F0)),
//       ),
//       child: TextField(
//         controller: controller,
//         keyboardType: keyboardType,
//         decoration: InputDecoration(
//           labelText: label,
//           labelStyle: TextStyle(color: Color(0xFF64748B)),
//           prefixIcon: Icon(icon, color: Color(0xFF64748B)),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           filled: true,
//           fillColor: Colors.transparent,
//         ),
//       ),
//     );
//   }

//   Widget _buildPasswordField() {
//     return Container(
//       decoration: BoxDecoration(
//         color: Color(0xFFF8FAFC),
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Color(0xFFE2E8F0)),
//       ),
//       child: TextField(
//         controller: _passwordController,
//         obscureText: _obscurePassword,
//         decoration: InputDecoration(
//           labelText: 'Password',
//           labelStyle: TextStyle(color: Color(0xFF64748B)),
//           prefixIcon: Icon(Icons.lock_outlined, color: Color(0xFF64748B)),
//           suffixIcon: IconButton(
//             icon: Icon(
//               _obscurePassword ? Icons.visibility : Icons.visibility_off,
//               color: Color(0xFF64748B),
//             ),
//             onPressed: () {
//               setState(() {
//                 _obscurePassword = !_obscurePassword;
//               });
//             },
//           ),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
//           filled: true,
//           fillColor: Colors.transparent,
//         ),
//       ),
//     );
//   }

//   Widget _buildForgotPassword() {
//     return Align(
//       alignment: Alignment.centerRight,
//       child: TextButton(
//         onPressed: () {
//           // Forgot password logic
//         },
//         child: Text(
//           'Forgot Password?',
//           style: TextStyle(
//             fontSize: 14,
//             color: Color(0xFF14B8A6),
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildLoginButton() {
//     return SizedBox(
//       width: double.infinity,
//       height: 56,
//       child: ElevatedButton(
//         onPressed: _login,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Color(0xFF14B8A6),
//           foregroundColor: Colors.white,
//           elevation: 4,
//           shadowColor: Color(0xFF14B8A6).withOpacity(0.3),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//         ),
//         child: Text(
//           'Log In',
//           style: TextStyle(
//             fontSize: 16,
//             fontWeight: FontWeight.w700,
//             letterSpacing: 0.5,
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildBottomSection() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         Text(
//           "Don't have an account? ",
//           style: TextStyle(
//             fontSize: 16,
//             color: Color(0xFF64748B),
//           ),
//         ),
//         GestureDetector(
//           onTap: () {
//             // Navigate to Sign Up
//           },
//           child: Text(
//             'Sign Up',
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w700,
//               color: Color(0xFF14B8A6),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }

// // Placeholder Dashboard Pages
// class PatientDashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Patient Dashboard')),
//       body: Center(child: Text('Patient Dashboard')),
//     );
//   }
// }

// class DoctorDashboard extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Doctor Dashboard')),
//       body: Center(child: Text('Doctor Dashboard')),
//     );
//   }
// }
// PASTE THIS NEW AuthScreen HERE (replaces the old one)
// class AuthScreen extends StatelessWidget {
//   const AuthScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.teal.shade50, Colors.white],
//           ),
//         ),
//         child: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(24.0),
//             child: Column(
//               children: [
//                 Expanded(
//                   flex: 2,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.local_hospital,
//                         size: 100,
//                         color: Colors.teal.shade600,
//                       ),
//                       const SizedBox(height: 24),
//                       const Text(
//                         "Hospital Management System",
//                         style: TextStyle(
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                           color: Color(0xFF0D9488),
//                         ),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         "Welcome to better healthcare",
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.grey.shade600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   flex: 1,
//                   child: Column(
//                     children: [
//                       SizedBox(
//                         width: double.infinity,
//                         height: 56,
//                         child: ElevatedButton.icon(
//                           icon: const Icon(Icons.login, color: Colors.white),
//                           label: const Text(
//                             "LOGIN",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.white,
//                             ),
//                           ),
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.teal,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                             elevation: 4,
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => LoginPage(),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                       const SizedBox(height: 16),
//                       SizedBox(
//                         width: double.infinity,
//                         height: 56,
//                         child: OutlinedButton.icon(
//                           icon: const Icon(
//                             Icons.person_add,
//                             color: Colors.teal,
//                           ),
//                           label: const Text(
//                             "SIGN UP",
//                             style: TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.teal,
//                             ),
//                           ),
//                           style: OutlinedButton.styleFrom(
//                             side: const BorderSide(
//                               color: Colors.teal,
//                               width: 2,
//                             ),
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                           ),
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => SignupPage(),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
