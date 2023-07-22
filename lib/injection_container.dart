import 'package:clean_arch_news/features/daily_news/data/data_soruces/remote/news_api_service.dart';
import 'package:clean_arch_news/features/daily_news/data/repository/article_repository_imp.dart';
import 'package:clean_arch_news/features/daily_news/domain/repository/article_repository.dart';
import 'package:clean_arch_news/features/daily_news/domain/usecases/get_article.dart';
import 'package:clean_arch_news/features/daily_news/presentation/bloc/article/remote/remote_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<NewsApiService>(NewsApiService(sl()));

  sl.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(sl()));

  // UseCases
  sl.registerSingleton<GetArticleUseCase>(GetArticleUseCase(sl()));

  // Blocs
  sl.registerFactory<RemoteArticlesBloc>(() => RemoteArticlesBloc(sl()));
  
}
