class WasteItemModel {
  final String id;
  final String userId;
  final String category;
  final String description;
  final String? imageUrl;
  final String status;
  final DateTime createdAt;

  WasteItemModel({
    required this.id,
    required this.userId,
    required this.category,
    required this.description,
    this.imageUrl,
    this.status = 'Logged',
    required this.createdAt,
  });

  factory WasteItemModel.fromMap(Map<String, dynamic> map, String documentId) {
    return WasteItemModel(
      id: documentId,
      userId: map['userId'] ?? '',
      category: map['category'] ?? '',
      description: map['description'] ?? '',
      imageUrl: map['imageUrl'],
      status: map['status'] ?? 'Logged',
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt'].toString()) : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'category': category,
      'description': description,
      'imageUrl': imageUrl,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
