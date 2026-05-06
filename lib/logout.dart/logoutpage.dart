import 'package:flutter/material.dart';
import 'package:flutter_application_1/authentication.dart/logout_helper.dart';

/// Used by named route `/logout`. Triggers the shared confirm + Firebase sign-out flow.
class LogoutModalDemo extends StatefulWidget {
  const LogoutModalDemo({super.key});

  @override
  State<LogoutModalDemo> createState() => _LogoutModalDemoState();
}

class _LogoutModalDemoState extends State<LogoutModalDemo> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      confirmAndSignOut(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
