import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get current user
  User? get currentUser => _firebaseAuth.currentUser;

  // Get auth state changes stream
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  // Get current user ID
  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  // Get current user email
  String? get currentUserEmail => _firebaseAuth.currentUser?.email;

  // Login with Email & Password
  Future<UserCredential> loginWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Register with Email & Password
  Future<UserCredential> registerWithEmailPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      await userCredential.user?.updateDisplayName(displayName);
      await userCredential.user?.reload();

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Login with Google
  Future<UserCredential?> loginWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _firebaseAuth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Sign Out
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _googleSignIn.signOut();
    } catch (e) {
      throw Exception('Gagal logout: $e');
    }
  }

  // Reset Password
  Future<void> resetPassword({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email.trim());
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Update Profile
  Future<void> updateProfile({
    String? displayName,
    String? photoUrl,
  }) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) throw Exception('User tidak ditemukan');

      await user.updateDisplayName(displayName ?? user.displayName);
      if (photoUrl != null) {
        await user.updatePhotoURL(photoUrl);
      }
      await user.reload();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Update Email
  Future<void> updateEmail({required String newEmail}) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) throw Exception('User tidak ditemukan');

      await user.verifyBeforeUpdateEmail(newEmail.trim());
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Change Password
  Future<void> changePassword({required String newPassword}) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) throw Exception('User tidak ditemukan');

      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Delete Account
  Future<void> deleteAccount() async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user == null) throw Exception('User tidak ditemukan');

      await user.delete();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }

  // Check if user is logged in
  bool isLoggedIn() {
    return _firebaseAuth.currentUser != null;
  }

  // Handle Firebase Auth Exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found':
        return 'Email tidak ditemukan';
      case 'wrong-password':
        return 'Password salah';
      case 'email-already-in-use':
        return 'Email sudah terdaftar';
      case 'weak-password':
        return 'Password terlalu lemah (minimal 6 karakter)';
      case 'invalid-email':
        return 'Format email tidak valid';
      case 'operation-not-allowed':
        return 'Operasi tidak diizinkan';
      case 'user-disabled':
        return 'Akun telah dinonaktifkan';
      case 'too-many-requests':
        return 'Terlalu banyak percobaan. Coba lagi nanti';
      default:
        return 'Terjadi kesalahan: ${e.message}';
    }
  }
}
