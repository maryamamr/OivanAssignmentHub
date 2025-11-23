import '../models/reputation_model.dart';
import '../../../user_list/data/datasources/user_remote_datasource.dart';

abstract class ReputationRepository {
  Future<List<ReputationModel>> getReputation({
    required int userId,
    required int page,
    required int pageSize,
  });
}

class ReputationRepositoryImpl implements ReputationRepository {
  final UserRemoteDataSource _remoteDataSource;

  ReputationRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<ReputationModel>> getReputation({
    required int userId,
    required int page,
    required int pageSize,
  }) async {
    return await _remoteDataSource.getReputation(
      userId: userId,
      page: page,
      pageSize: pageSize,
    );
  }
}
