class PickupRequestModel {
  final String id;
  final String userId;
  final String address;
  final DateTime scheduledDate;
  final String status;
  final DateTime createdAt;

  PickupRequestModel({
    required this.id,
    required this.userId,
    required this.address,
    required this.scheduledDate,
    this.status = 'Pending',
    required this.createdAt,
  });

  factory PickupRequestModel.fromMap(Map<String, dynamic> map, String documentId) {
    return PickupRequestModel(
      id: documentId,
      userId: map['userId'] ?? '',
      address: map['address'] ?? '',
      scheduledDate: map['scheduledDate'] != null ? DateTime.parse(map['scheduledDate'].toString()) : DateTime.now(),
      status: map['status'] ?? 'Pending',
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt'].toString()) : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'address': address,
      'scheduledDate': scheduledDate.toIso8601String(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
