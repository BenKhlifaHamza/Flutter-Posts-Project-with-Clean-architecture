import 'core/network/network_info.dart';
import 'features/posts/data/api/posts_local_data_source.dart';
import 'features/posts/data/api/posts_remote_data_source.dart';
import 'features/posts/data/repositories/post_repository_imp.dart';
import 'features/posts/domaine/repositories/posts_repository.dart';
import 'features/posts/domaine/use_cases/add_post_uc.dart';
import 'features/posts/domaine/use_cases/delete_post_uc.dart';
import 'features/posts/domaine/use_cases/get_all_posts_uc.dart';
import 'features/posts/domaine/use_cases/update_post_uc.dart';
import 'features/posts/presentation/blocs/add_delete_update_post/add_delete_update_bloc.dart';
import 'features/posts/presentation/blocs/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  /*****************--Futures - Posts--*****************/

  /*****************--Bloc--*****************/
  sl.registerFactory(() => PostsBloc(getAllPostsUC: sl.call()));
  sl.registerFactory(() => AddDeleteUpdateBloc(
      addPostUC: sl(), updatePostUC: sl(), deletePostUC: sl()));

  /*****************--Use Case--*****************/
  sl.registerLazySingleton(() => GetAllPostsUC(postsRepository: sl()));
  sl.registerLazySingleton(() => AddPostUC(sl()));
  sl.registerLazySingleton(() => UpdatePostUC(sl()));
  sl.registerLazySingleton(() => DeletePostUC(sl()));

  /*****************--Repository--*****************/
  sl.registerLazySingleton<PostsRepository>(() => PostRepositoryImp(
      remoteDataSource: sl(), localDataSource: sl(), networkInfo: sl()));

  /*****************--Data Source--*****************/
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => PostRemoteDataSourceImp(client: sl()));

  sl.registerLazySingleton<PostLocalDataSource>(
      () => PostLocalDataSourceImp(sharedPreferences: sl()));

  /*****************--Core--*****************/
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImp(sl()));

  /*****************--External--*****************/
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
