import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pickup_request_model.dart';
import '../services/firebase_service.dart';

class PickupViewModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String _userId;

  PickupViewModel(this._userId);

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

  Future<bool> schedulePickup(String address, DateTime scheduledDate) async {
    setLoading(true);
    setErrorMessage(null);
    try {
      final docRef = _firestore.collection('pickup_requests').doc();
      final newRequest = PickupRequestModel(
        id: docRef.id,
        userId: _userId,
        address: address,
        scheduledDate: scheduledDate,
        status: 'Pending',
        createdAt: DateTime.now(),
      );

      await docRef.set(newRequest.toMap());
      
      setLoading(false);
      return true;
    } catch (e) {
      setErrorMessage("Failed to schedule pickup: ${e.toString()}");
      setLoading(false);
      return false;
    }
  }

  Stream<List<PickupRequestModel>> getUserPickupRequests() {
    return _firestore
        .collection('pickup_requests')
        .where('userId', isEqualTo: _userId)
        .orderBy('scheduledDate', descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => PickupRequestModel.fromMap(doc.data(), doc.id))
            .toList());
  }
}
