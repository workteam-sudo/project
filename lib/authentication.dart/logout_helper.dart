import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

/// Confirms and signs the user out, then clears the navigation stack to root.
Future<void> confirmAndSignOut(BuildContext context) async {
  final navigator = Navigator.of(context);
  final messenger = ScaffoldMessenger.maybeOf(context);

  final confirmed = await showDialog<bool>(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text('Log out'),
      content: const Text(
        'Are you sure you want to log out? You will need to sign in again to access your account.',
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(ctx, true),
          child: const Text('Log out'),
        ),
      ],
    ),
  );

  if (confirmed != true) return;

  try {
    await FirebaseAuth.instance.signOut();
    navigator.popUntil((route) => route.isFirst);
  } catch (e) {
    messenger?.showSnackBar(
      SnackBar(content: Text('Could not sign out: $e')),
    );
  }
}
