import 'package:ecommerce_app/core/di/di.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

GetIt getIt = GetIt.instance;

@InjectableInit(
  initializerName: 'init', // default
  preferRelativeImports: true, // default
  asExtension: true, // default
)
void configureDependencies() => getIt.init();

// void configureDependencies() {
//   getIt.registerFactory<SourcesMapper>(() => SourcesMapper());
//   getIt.registerFactory<Connectivity>(() => Connectivity());
//   getIt.registerFactory<NewsRemoteDataSource>(() => NewsRemoteDataSourceImpl());
//   getIt.registerFactory<NewsLocalDataSource>(() => NewsLocalDataSourceImpl());
//   getIt.registerFactory<NewsRepository>(
//       () => NewsRepositoryImpl(getIt(), getIt(), getIt(), getIt()));
//   getIt.registerFactory(() => GetSourcesUseCase(getIt()));
//   getIt.registerFactory(() => NewsScreenViewModel(getIt()));
// }
