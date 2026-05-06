import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/doctordashboard.dart/dashboard.dart';
import 'package:flutter_application_1/patientdash.dart/dashboard.dart';

import 'auth_landing.dart';
import 'auth_service.dart';

/// Root widget: reacts to auth + Firestore role and shows the correct shell.
class AppRoot extends StatefulWidget {
  const AppRoot({super.key});

  @override
  State<AppRoot> createState() => _AppRootState();
}

class _AppRootState extends State<AppRoot> {
  StreamSubscription<User?>? _authSub;
  StreamSubscription<User?>? _userSub;

  @override
  void initState() {
    super.initState();
    void refresh() {
      if (mounted) setState(() {});
    }

    _authSub = FirebaseAuth.instance.authStateChanges().listen((_) => refresh());
    _userSub = FirebaseAuth.instance.userChanges().listen((_) => refresh());
  }

  @override
  void dispose() {
    _authSub?.cancel();
    _userSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const AuthLandingScreen();
    }

    if (!user.emailVerified) {
      return _VerifyEmailScreen(
        user: user,
        onSessionChanged: () => setState(() {}),
      );
    }

    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, docSnap) {
        if (docSnap.hasError) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'Could not load profile: ${docSnap.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }
        if (!docSnap.hasData || !docSnap.data!.exists) {
          return const Scaffold(
            body: Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Profile not found. Please contact support or sign up again.',
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        }

        final role = docSnap.data!.data()?['role'] as String?;
        if (role == UserRole.doctor.name) {
          return const DoctorDashboard();
        }
        return const PatientDashboard();
      },
    );
  }
}

class _VerifyEmailScreen extends StatefulWidget {
  const _VerifyEmailScreen({
    required this.user,
    required this.onSessionChanged,
  });

  final User user;
  final VoidCallback onSessionChanged;

  @override
  State<_VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<_VerifyEmailScreen> {
  bool _busy = false;

  Future<void> _resend() async {
    setState(() => _busy = true);
    try {
      await widget.user.sendEmailVerification();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Verification email sent.')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not send email: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _refresh() async {
    setState(() => _busy = true);
    try {
      await widget.user.reload();
      if (mounted) {
        widget.onSessionChanged();
        setState(() {});
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify email')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'We sent a verification link to your email. Open it, then tap “I have verified”.',
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _busy ? null : _refresh,
              child: const Text('I have verified'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: _busy ? null : _resend,
              child: const Text('Resend verification email'),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: _busy ? null : _signOut,
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
