import 'package:get_it/get_it.dart';

import 'package:book_search/features/books/domain/domain.dart';
import 'package:book_search/features/books/infrastructure/infrastructure.dart';
import 'package:book_search/shared/shared.dart';

final instance = GetIt.instance;

Future<void> initDependencies() async {
  _initBooks();

  final RestConfig restConfig = RestConfig();
  instance.registerLazySingleton<RestConfig>(() => restConfig);

  final ApiService apiService = ApiService(restConfig: instance());
  instance.registerLazySingleton<ApiService>(() => apiService);
}

void _initBooks() {
  instance.registerFactory<BooksDatasource>(
    () => BooksDatasourceImpl(apiService: instance()),
  );
  instance.registerFactory<BooksRepository>(
    () => BooksRepositoryImpl(dataSource: instance()),
  );
}
