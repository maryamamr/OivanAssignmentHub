import 'package:equatable/equatable.dart';
import '../../../data/models/user_model.dart';

enum UserListStatus { initial, loading, success, error }

class UserListState extends Equatable {
  final UserListStatus status;
  final List<UserModel> users;
  final bool hasReachedMax;
  final String? errorMessage;

  const UserListState({
    this.status = UserListStatus.initial,
    this.users = const [],
    this.hasReachedMax = false,
    this.errorMessage,
  });

  UserListState copyWith({
    UserListStatus? status,
    List<UserModel>? users,
    bool? hasReachedMax,
    String? errorMessage,
  }) {
    return UserListState(
      status: status ?? this.status,
      users: users ?? this.users,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, users, hasReachedMax, errorMessage];
}
