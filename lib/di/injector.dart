import 'package:get_it/get_it.dart';
import '../core/service/hive_service.dart';
import '../core/service/network_service.dart';
import '../features/bookmark/data/datasources/bookmark_local_datasource.dart';
import '../features/bookmark/data/repositories/bookmark_repository.dart';
import '../features/bookmark/presentation/blocs/bookmark_cubit/bookmark_cubit.dart';
import '../features/user_details/data/repositories/reputation_repository.dart';
import '../features/user_details/presentation/blocs/reputation_cubit/reputation_cubit.dart';
import '../features/user_list/data/datasources/user_remote_datasource.dart';
import '../features/user_list/data/repositories/user_repository.dart';
import '../features/user_list/presentation/blocs/user_list_cubit/user_list_cubit.dart';

class Injector {
  static final Injector _singleton = Injector._internal();
  final _flyweightMap = <String, dynamic>{};

  factory Injector() => _singleton;

  Injector._internal();

  static Future<void> init() async {
    final hiveService = HiveService();
    await hiveService.init();
    GetIt.I.registerSingleton<HiveService>(hiveService);
  }

  // Services
  NetworkService get networkService =>
      _flyweightMap['networkService'] ??= NetworkServiceImpl();
  HiveService get hiveService => GetIt.I<HiveService>();

  // User List Feature
  UserListCubit get userListCubit => UserListCubit(userRepository);
  UserRepository get userRepository => _flyweightMap['userRepository'] ??=
      UserRepositoryImpl(userRemoteDataSource, bookmarkRepository);
  UserRemoteDataSource get userRemoteDataSource =>
      _flyweightMap['userRemoteDataSource'] ??=
          UserRemoteDataSourceImpl(networkService);

  // Bookmark Feature
  BookmarkCubit get bookmarkCubit => BookmarkCubit(bookmarkRepository);
  BookmarkRepository get bookmarkRepository =>
      _flyweightMap['bookmarkRepository'] ??=
          BookmarkRepositoryImpl(bookmarkLocalDataSource);
  BookmarkLocalDataSource get bookmarkLocalDataSource =>
      _flyweightMap['bookmarkLocalDataSource'] ??=
          BookmarkLocalDataSourceImpl(hiveService);

  // Reputation Feature
  ReputationCubit get reputationCubit => ReputationCubit(reputationRepository);
  ReputationRepository get reputationRepository =>
      _flyweightMap['reputationRepository'] ??=
          ReputationRepositoryImpl(userRemoteDataSource);
}
