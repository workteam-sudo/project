import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum UserRole { patient, doctor }

class AuthService {
  AuthService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
    required UserRole role,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    final credential = await _auth.createUserWithEmailAndPassword(
      email: normalizedEmail,
      password: password,
    );

    final user = credential.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-creation-failed',
        message: 'Unable to create account.',
      );
    }

    await user.updateDisplayName(fullName.trim());
    await user.sendEmailVerification();

    try {
      await _firestore.collection('users').doc(user.uid).set({
        'fullName': fullName.trim(),
        'email': normalizedEmail,
        'role': role.name,
        'emailVerified': false,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } on FirebaseException catch (e) {
      // Keep Auth and Firestore consistent if profile creation fails.
      await user.delete();
      throw FirebaseAuthException(
        code: 'profile-write-failed',
        message:
            'Account creation failed while saving profile (${e.code}). Check Firestore setup/rules.',
      );
    }
  }

  Future<UserRole> signIn({
    required String email,
    required String password,
    required UserRole selectedRole,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim().toLowerCase(),
      password: password,
    );
    final user = credential.user;

    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'User record not found.',
      );
    }

    await user.reload();
    final refreshedUser = _auth.currentUser;
    if (refreshedUser == null) {
      throw FirebaseAuthException(
        code: 'session-expired',
        message: 'Session expired. Please login again.',
      );
    }

    if (!refreshedUser.emailVerified) {
      throw FirebaseAuthException(
        code: 'email-not-verified',
        message: 'Please verify your email before logging in.',
      );
    }

    final doc = await _firestore.collection('users').doc(refreshedUser.uid).get();
    if (!doc.exists) {
      throw FirebaseAuthException(
        code: 'profile-not-found',
        message: 'Profile missing. Contact administrator.',
      );
    }

    final data = doc.data();
    final roleName = data?['role'] as String?;
    final actualRole = UserRole.values.firstWhere(
      (role) => role.name == roleName,
      orElse: () => UserRole.patient,
    );

    if (actualRole != selectedRole) {
      await _auth.signOut();
      throw FirebaseAuthException(
        code: 'role-mismatch',
        message: 'Selected role does not match this account.',
      );
    }

    await _firestore.collection('users').doc(refreshedUser.uid).update({
      'emailVerified': true,
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return actualRole;
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _auth.sendPasswordResetEmail(email: email.trim().toLowerCase());
  }

  Future<void> resendVerificationEmail({
    required String email,
    required String password,
  }) async {
    final credential = await _auth.signInWithEmailAndPassword(
      email: email.trim().toLowerCase(),
      password: password,
    );
    final user = credential.user;
    if (user == null) {
      throw FirebaseAuthException(
        code: 'user-not-found',
        message: 'User record not found.',
      );
    }
    await user.sendEmailVerification();
    await _auth.signOut();
  }
}
