import 'package:flutter/material.dart';
import '../models/waste_item_model.dart';
import '../repositories/waste_repository.dart';

class WasteViewModel extends ChangeNotifier {
  final WasteRepository _repository = WasteRepository();
  final String _userId;

  WasteViewModel(this._userId);

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  List<WasteItemModel> _wasteItems = [];
  List<WasteItemModel> get wasteItems => _wasteItems;

  void setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  void setErrorMessage(String? msg) {
    _errorMessage = msg;
    notifyListeners();
  }

  Future<bool> logWaste(String category, String description, {String? imageUrl}) async {
    setLoading(true);
    setErrorMessage(null);
    try {
      final newItem = await _repository.logWaste(
        userId: _userId,
        category: category,
        description: description,
        imageUrl: imageUrl,
      );

      if (newItem != null) {
        _wasteItems.insert(0, newItem);
        setLoading(false);
        return true;
      }
      return false;
    } catch (e) {
      setErrorMessage("Failed to log waste: ${e.toString()}");
      setLoading(false);
      return false;
    }
  }

  Stream<List<WasteItemModel>> getUserWasteLogs() {
    return _repository.getUserWasteLogs(_userId);
  }
}
