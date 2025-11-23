import 'package:equatable/equatable.dart';
import '../../../../user_list/data/models/user_model.dart';

enum BookmarkStatus { initial, loading, success, error }

class BookmarkState extends Equatable {
  final BookmarkStatus status;
  final List<UserModel> bookmarkedUsers;
  final String? errorMessage;

  const BookmarkState({
    this.status = BookmarkStatus.initial,
    this.bookmarkedUsers = const [],
    this.errorMessage,
  });

  BookmarkState copyWith({
    BookmarkStatus? status,
    List<UserModel>? bookmarkedUsers,
    String? errorMessage,
  }) {
    return BookmarkState(
      status: status ?? this.status,
      bookmarkedUsers: bookmarkedUsers ?? this.bookmarkedUsers,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, bookmarkedUsers, errorMessage];
}
