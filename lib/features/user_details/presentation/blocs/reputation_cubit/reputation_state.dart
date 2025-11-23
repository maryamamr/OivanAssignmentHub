import 'package:equatable/equatable.dart';
import '../../../data/models/reputation_model.dart';

enum ReputationStatus { initial, loading, success, error }

class ReputationState extends Equatable {
  final ReputationStatus status;
  final List<ReputationModel> reputationHistory;
  final bool hasReachedMax;
  final String? errorMessage;

  const ReputationState({
    this.status = ReputationStatus.initial,
    this.reputationHistory = const [],
    this.hasReachedMax = false,
    this.errorMessage,
  });

  ReputationState copyWith({
    ReputationStatus? status,
    List<ReputationModel>? reputationHistory,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return ReputationState(
      status: status ?? this.status,
      reputationHistory: reputationHistory ?? this.reputationHistory,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, reputationHistory, hasReachedMax, errorMessage];
}
