import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../services/firebase_service.dart';

class AuthViewModel extends ChangeNotifier {
  final FirebaseService _firebaseService = FirebaseService();

  UserModel? _currentUserModel;
  UserModel? get currentUserModel => _currentUserModel;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void setErrorMessage(String? msg) {
    _errorMessage = msg;
    notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    setLoading(true);
    setErrorMessage(null);
    try {
      UserModel? user = await _firebaseService.loginWithEmailPassword(email, password);
      if (user != null) {
        _currentUserModel = user;
        setLoading(false);
        return true;
      }
    } catch (e) {
      setErrorMessage(e.toString());
    }
    setLoading(false);
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    setLoading(true);
    setErrorMessage(null);
    try {
      UserModel? user = await _firebaseService.signUpWithEmailPassword(email, password, name);
      if (user != null) {
        _currentUserModel = user;
        setLoading(false);
        return true;
      }
    } catch (e) {
      setErrorMessage(e.toString());
    }
    setLoading(false);
    return false;
  }

  Future<void> logout() async {
    await _firebaseService.signOut();
    _currentUserModel = null;
    notifyListeners();
  }

  Future<void> checkCurrentUser() async {
    final user = _firebaseService.currentUser;
    if (user != null) {
      _currentUserModel = await _firebaseService.getUserProfile(user.uid);
      notifyListeners();
    }
  }
}
