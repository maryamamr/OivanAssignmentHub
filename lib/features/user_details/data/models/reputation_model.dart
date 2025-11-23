class ReputationModel {
  final String reputationHistoryType;
  final int reputationChange;
  final int creationDate;
  final int postId;

  const ReputationModel({
    required this.reputationHistoryType,
    required this.reputationChange,
    required this.creationDate,
    required this.postId,
  });

  factory ReputationModel.fromJson(Map<String, dynamic> json) {
    return ReputationModel(
      reputationHistoryType: json['reputation_history_type'] ?? '',
      reputationChange: json['reputation_change'] ?? 0,
      creationDate: json['creation_date'] ?? 0,
      postId: json['post_id'] ?? 0,
    );
  }
}
