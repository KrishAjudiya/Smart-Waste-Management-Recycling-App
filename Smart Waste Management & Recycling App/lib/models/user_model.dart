class UserModel {
  final String uid;
  final String name;
  final String email;
  final String role;
  final int totalRewardPoints;
  final DateTime createdAt;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.role,
    this.totalRewardPoints = 0,
    required this.createdAt,
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String documentId) {
    return UserModel(
      uid: documentId,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      role: map['role'] ?? 'user',
      totalRewardPoints: map['totalRewardPoints']?.toInt() ?? 0,
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt'].toString()) : DateTime.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'totalRewardPoints': totalRewardPoints,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
