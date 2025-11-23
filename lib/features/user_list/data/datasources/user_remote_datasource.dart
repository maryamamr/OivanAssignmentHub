import '../../../../core/service/network_service.dart';
import '../models/user_model.dart';
import '../../../user_details/data/models/reputation_model.dart';
import '../../../../core/constants/api_constants.dart';

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getUsers({required int page, required int pageSize});
  Future<List<ReputationModel>> getReputation({
    required int userId,
    required int page,
    required int pageSize,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final NetworkService _networkService;

  UserRemoteDataSourceImpl(this._networkService);

  @override
  Future<List<UserModel>> getUsers({
    required int page,
    required int pageSize,
  }) async {
    final response = await _networkService.get(
      '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}',
      queryParameters: {
        'page': page,
        'pagesize': pageSize,
        'site': 'stackoverflow',
      },
    );

    final List<dynamic> items = response.data['items'];
    return items.map((json) => UserModel.fromJson(json)).toList();
  }

  @override
  Future<List<ReputationModel>> getReputation({
    required int userId,
    required int page,
    required int pageSize,
  }) async {
    final response = await _networkService.get(
      '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/$userId${ApiConstants.reputationHistoryEndpoint}',
      queryParameters: {
        'page': page,
        'pagesize': pageSize,
        'site': 'stackoverflow',
      },
    );

    final List<dynamic> items = response.data['items'];
    return items.map((json) => ReputationModel.fromJson(json)).toList();
  }
}
