import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService;

  AuthProvider({required AuthService authService}) : _authService = authService;

  User? _currentUser;
  bool _isLoading = false;
  String? _errorMessage;
  bool _isLoggedIn = false;

  // Getters
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isLoggedIn => _isLoggedIn;
  String? get userId => _currentUser?.uid;
  String? get userEmail => _currentUser?.email;
  String? get userName => _currentUser?.displayName;

  // Initialize auth state
  void initializeAuthState() {
    _authService.authStateChanges.listen((user) {
      _currentUser = user;
      _isLoggedIn = user != null;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    });
  }

  // Login with Email & Password
  Future<void> login({required String email, required String password}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userCredential = await _authService.loginWithEmailPassword(
        email: email,
        password: password,
      );
      _currentUser = userCredential.user;
      _isLoggedIn = true;
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Register with Email & Password
  Future<void> register({
    required String email,
    required String password,
    required String displayName,
  }) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userCredential = await _authService.registerWithEmailPassword(
        email: email,
        password: password,
        displayName: displayName,
      );
      _currentUser = userCredential.user;
      _isLoggedIn = true;
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Login with Google
  Future<void> loginWithGoogle() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final userCredential = await _authService.loginWithGoogle();
      if (userCredential != null) {
        _currentUser = userCredential.user;
        _isLoggedIn = true;
      } else {
        _errorMessage = 'Google login dibatalkan';
      }
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Logout
  Future<void> logout() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.signOut();
      _currentUser = null;
      _isLoggedIn = false;
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Reset Password
  Future<void> resetPassword({required String email}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.resetPassword(email: email);
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update Profile
  Future<void> updateProfile({String? displayName, String? photoUrl}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.updateProfile(
        displayName: displayName,
        photoUrl: photoUrl,
      );
      _currentUser = _authService.currentUser;
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Update Email
  Future<void> updateEmail({required String newEmail}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.updateEmail(newEmail: newEmail);
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Change Password
  Future<void> changePassword({required String newPassword}) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.changePassword(newPassword: newPassword);
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete Account
  Future<void> deleteAccount() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _authService.deleteAccount();
      _currentUser = null;
      _isLoggedIn = false;
    } catch (e) {
      _errorMessage = e.toString();
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Refresh current user
  Future<void> refreshUser() async {
    try {
      _currentUser = _authService.currentUser;
      notifyListeners();
    } catch (e) {
      _errorMessage = e.toString();
      notifyListeners();
    }
  }

  // Check if user is logged in
  bool checkIsLoggedIn() {
    return _authService.isLoggedIn();
  }
}
