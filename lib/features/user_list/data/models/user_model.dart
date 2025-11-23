class UserModel {
  final int userId;
  final String displayName;
  final String profileImage;
  final int reputation;
  final String location;
  final int creationDate;
  final bool isBookmarked;

  const UserModel({
    required this.userId,
    required this.displayName,
    required this.profileImage,
    required this.reputation,
    required this.location,
    required this.creationDate,
    this.isBookmarked = false,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'] ?? 0,
      displayName: json['display_name'] ?? 'Unknown',
      profileImage: json['profile_image'] ?? '',
      reputation: json['reputation'] ?? 0,
      location: json['location'] ?? 'Unknown',
      creationDate: json['creation_date'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'display_name': displayName,
      'profile_image': profileImage,
      'reputation': reputation,
      'location': location,
      'creation_date': creationDate,
    };
  }

  UserModel copyWith({
    int? userId,
    String? displayName,
    String? profileImage,
    int? reputation,
    String? location,
    int? creationDate,
    bool? isBookmarked,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      displayName: displayName ?? this.displayName,
      profileImage: profileImage ?? this.profileImage,
      reputation: reputation ?? this.reputation,
      location: location ?? this.location,
      creationDate: creationDate ?? this.creationDate,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }
}
