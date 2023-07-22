import 'dart:io';

import 'package:clean_arch_news/core/constants/constants.dart';
import 'package:clean_arch_news/core/resources/data_state.dart';
import 'package:clean_arch_news/features/daily_news/data/data_soruces/remote/news_api_service.dart';
import 'package:clean_arch_news/features/daily_news/data/models/article.dart';
import 'package:clean_arch_news/features/daily_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;

  ArticleRepositoryImpl(this._newsApiService);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticle() async {
    try {
      final httpResponse = await _newsApiService.getNewsArticles(
        apiKey: newsAPIKey,
        country: countryQuery,
        category: categoryQuery,
      );

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        return DataSuccess(httpResponse.data);
      } else {
        return DataFiled(DioException(
          error: httpResponse.response.statusMessage,
          response: httpResponse.response,
          type: DioExceptionType.badResponse,
          requestOptions: httpResponse.response.requestOptions,
        ));
      }
    } on DioException catch (e) {
      return DataFiled(e);
    }
  }
}
