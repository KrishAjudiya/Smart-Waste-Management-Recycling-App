import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/waste_item_model.dart';

class WasteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<WasteItemModel?> logWaste({
    required String userId,
    required String category,
    required String description,
    String? imageUrl,
  }) async {
    try {
      final docRef = _firestore.collection('waste_logs').doc();
      final newItem = WasteItemModel(
        id: docRef.id,
        userId: userId,
        category: category,
        description: description,
        imageUrl: imageUrl,
        createdAt: DateTime.now(),
      );

      await docRef.set(newItem.toMap());
      
      // Increment user reward points
      await _firestore.collection('users').doc(userId).update({
        'totalRewardPoints': FieldValue.increment(10)
      });

      return newItem;
    } catch (e) {
      throw Exception("Failed to save waste log: $e");
    }
  }

  Stream<List<WasteItemModel>> getUserWasteLogs(String userId) {
    return _firestore
        .collection('waste_logs')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => WasteItemModel.fromMap(doc.data(), doc.id))
            .toList());
  }
}
